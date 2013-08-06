#!/usr/bin/python
import os, time, logging, re, errno
import httplib, csv, json
from collections import deque
from optparse import OptionParser
from datetime import datetime


class GiftCodeService:
    def __init__(self, opts):
        self.opts = opts
        self.conn = self.__new_connection()
        self.sartreUrl = '/svc/ecommerce-core/accounts/{0}/gift-certificates/purchases.json'.format(self.opts.agent)

    def fetchGiftCode(self, record2process):
        purchase = {
            'offer_chain_id': self.opts.offer,
            'recipient_email': record2process['toEmail'],
            'recipient_name': record2process['toName'],
            'sender_email': record2process['fromEmail'],
            'sender_name': record2process['fromName'],
            'message': 'Bulk Code Generator',
            'campaign': self.opts.campaign,
            'reference_sequence': record2process['recordNumber']
        }

        if self.opts.duration is not None:
            purchase['duration_days'] = self.opts.duration
        elif self.opts.expiration is not None:
            purchase['expiration_date'] = self.opts.expiration

        headers = {
            'Content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
            'Accept': 'text/json'
        }

        postBody = json.dumps({
            'meta': {
                'user_agent': 'SYSTEM',
                'is_cs': 'true'
            },
            'data': {
                'zero_charge_instrument': 1,
                'purchases': [
                    purchase
                ]
            }
        })

        responseBody = self.__makeRequest(self.sartreUrl, headers, postBody)
        decodedResponse = json.loads(responseBody)

        gcCode = decodedResponse['data'][0]['code']
        referenceCode = decodedResponse['data'][0]['reference_code']

        if gcCode is None:
            raise ValueError('No code found in: {0}'.format(responseBody))

        return gcCode, referenceCode

    def close(self):
        self.conn.close()

    def __makeRequest(self, url, headers, body):
        retryCount = 5

        while retryCount > 0:

            try:
                self.conn.request('POST', url, body, headers)
                response = self.conn.getresponse()

                if response.status != 200:
                    raise IOError('Response with status: {0}\n{1}'.format(response.status, response.read()))

                return response.read()

            except IOError, e:
                if e.errno != errno.ECONNRESET:
                    raise
                else:
                    logging.warning('IOError, re-establishing connection')
                    self.conn.close()
                    self.conn = self.__new_connection()
                    retryCount -= 1

        raise ValueError("Unable to make request after {0} attempts".format(retryCount))

    def __new_connection(self):
        return httplib.HTTPSConnection(self.opts.host)


class WorkDispatcher:
    def __init__(self, opts):
        self.successes = self.failures = 0
        self.start = datetime.now()

        self.workQueue = deque()

        doneFile = '{0}-from-{1}-to-{2}.done'.format(opts.fromEmail, opts.startIndex, opts.startIndex + opts.amount - 1)

        if os.path.exists(doneFile):
            raise IOError('File already exists: {0}'.format(doneFile))

        self.doneWriter = csv.writer(open(doneFile, 'a'), delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)

        for recordNumber in xrange(opts.startIndex, opts.startIndex + opts.amount):
            self.workQueue.append({
                'recordNumber': recordNumber,
                'toName': opts.toName,
                'toEmail': opts.toEmail,
                'fromName': opts.fromName,
                'fromEmail': opts.fromEmail})

    def next(self):
        return self.workQueue.popleft()

    def success(self, record2process, gcCode, referenceCode):
        doneRow = [record2process[key] for key in 'recordNumber', 'toName', 'toEmail', 'fromName', 'fromEmail'] + \
                  [gcCode, 'SUCCESS', time.asctime(), referenceCode]
        self.doneWriter.writerow(doneRow)
        self.successes += 1

    def failure(self, record2process):
        doneRow = [record2process[key] for key in 'recordNumber', 'toName', 'toEmail', 'fromName', 'fromEmail']
        self.doneWriter.writerow(doneRow)
        self.failures += 1

    def dumpStats(self):
        logging.info('%d successes, %d failures', self.successes, self.failures)

        totalRequests = self.successes + self.failures
        totalSeconds = (datetime.now() - self.start).seconds

        logging.info("Time: %0.6f seconds", totalSeconds)
        logging.info("Average: %0.6f per second", float(totalSeconds) / float(totalRequests))


def main():
    parser = OptionParser(usage='Usage: %prog [opts] --host host --agent regiId --')
    parser.add_option('-d', '--debug', action='store_true', default=False, help='Show debugging output')
    parser.add_option('-m', '--sendmail', action='store_true', default=False,
                      help='Send email as codes are generated (unsupported)')
    parser.add_option('-o', '--offer', help='Offer chain ID to use')
    parser.add_option('-a', '--agent', help='User-agent to use in sartre calls')

    parser.add_option('--expiration', help='Expiration date in "YYYY-MM-DD" or "YYYY-MM-DD HH:mm:ss" format')
    parser.add_option('--duration', type=int, help='Duration in days of this gift code')
    parser.add_option('--curl', action='store_true', default=False,
                      help='Display curl output but do not execute HTTP requests')

    parser.add_option('--toName', type=str, help='Name of the user receiving these gift codes',
                      default='NYT Marketing Dept')
    parser.add_option('--toEmail', type=str, help='E-mail address of the user receiving these gift codes',
                      default='noemail')

    parser.add_option('--fromName', type=str, help='Name of the user sending these gift codes')
    parser.add_option('--fromEmail', type=str, help='E-mail address of the user sending these gift codes')

    parser.add_option('--campaign', type=str, help='Unique campaign name used to generate reference code')
    parser.add_option('--startIndex', type=int, help='Start index for reference codes', default=1)
    parser.add_option('--amount', type=int, help='Number of codes to generate')
    parser.add_option('--host', type=str, help='Hostname and port for Sartre web server (e.g. localhost:8443)')

    opts, args = parser.parse_args()

    if opts.sendmail:
        parser.error('Sendmail option is no longer supported')

    if opts.debug:
        log_level = logging.DEBUG
    else:
        log_level = logging.INFO

    for required in ['agent', 'host', 'amount', 'campaign', 'fromName', 'fromEmail']:
        if opts.__dict__[required] is None:
            parser.error('Missing required argument: {0}'.format(required))

    EXPIRATION_PATTERN = re.compile(r'\d{4}-\d{2}-\d{2}(?:\d{2}:\d{2}:\d{2})?')

    if opts.expiration is not None:
        if opts.duration is not None:
            parser.error('Please use either duration or expiration, not both')
        if not EXPIRATION_PATTERN.match(opts.expiration):
            parser.error('Expiration pattern must be in YYYY-MM-DD[ HH:mm:ss] format (ex: 2014-06-01)')

    logging.basicConfig(format='%(filename)s:%(lineno)s %(message)s', level=log_level)

    giftCodeService = GiftCodeService(opts)
    dispatcher = WorkDispatcher(opts)

    logging.debug('Starting')

    while True:
        try:
            record = dispatcher.next()
        except IndexError:
            giftCodeService.close()
            break

        try:
            gcCode, referenceCode = giftCodeService.fetchGiftCode(record)
            dispatcher.success(record, gcCode, referenceCode)
        except BaseException:
            logging.exception("Exception when fetching gift code")
            dispatcher.failure(record)

    dispatcher.dumpStats()


if __name__ == '__main__':
    main()
