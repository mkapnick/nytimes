#!/usr/bin/python
import sys, getopt, os, time
import httplib, urllib
import threading
import csv
from collections import deque

_debug = None
_sendmail = None

class EmailQueue:

    def __init__(self, inputFile, env, offer_chain):

        self.emails2process = deque()
        self.offer_chain = offer_chain
        
        doneFile = inputFile + '.done'
        
        if (env == 'dev'):
            self.sartreHost = 'sartre-core.private.dev.nytimes.com:8443';
            self.profileHost = 'profileapi.private.dev.nytimes.com:443'
        elif (env == 'stg'):
            self.sartreHost = 'sartre-core.stg.nytimes.com:8443';
            self.profileHost = 'profileapi.private.stg.nytimes.com:443'
        elif (env == 'stg-circ'):
            self.sartreHost = 'sartre-core-circ.stg.nytimes.com:8443';
            self.profileHost = 'profileapi.private.stg.nytimes.com:443'
        elif (env == 'stg-circ1'):
            self.sartreHost = 'sartre-core03.sprvt.nytimes.com:8443';
            self.profileHost = 'profileapi.private.stg.nytimes.com:443'
        elif (env == 'stg-circ2'):
            self.sartreHost = 'sartre-core04.sprvt.nytimes.com:8443';
            self.profileHost = 'profileapi.private.stg.nytimes.com:443'
        elif (env == 'prod'):
            self.sartreHost = 'sartre-core.prd.nytimes.com:8443';
            self.profileHost = 'profileapi-sartre.private.lga2.nytimes.com:443'
        else:
            print "Invalid enviroment"
            sys.exit(2)
        
        if (_sendmail == 1):
            if (self.offer_chain == '1000001'):
                # Ad Comp Offer Chain
                self.emailTemplate = 'http://knews.em.nytimes.com/applicationdata/nyt-email/templates/complimentary_access2.multi.san'
            elif (self.offer_chain == '1000026'):
                # MEU Office Chain
                self.emailTemplate = 'http://knews.em.nytimes.com/applicationdata/nyt-email/templates/meu_gc_redeemer.multi.san'
            else:
                print "Invalid offer chain"
                sys.exit(2)
                    
        emailFileReader = csv.reader(open(inputFile, 'r'), delimiter=',', quotechar='"')
        self.doneWriter = csv.writer(open(doneFile, 'a'), delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
        for row in emailFileReader:
            if row[0][0] == '#':
                #Comment Row
                self.doneWriter.writerow(row)
                print "Skipping Comment " + row[0]
            elif len(row) > 5:
                # We've already got a gift code for this dude.
                self.doneWriter.writerow(row)
                print "Skipping Record " + row[0]
            else:
                self.emails2process.append({'regiId':   row[0],
                                        'toName':   row[1],
                                        'toEmail':  row[2],
                                        'fromName': row[3],
                                        'fromEmail':row[4]})



class GCGenerator(threading.Thread):
    
    def __init__(self, agent, emailQueue, threadId):
        
        self.emailQueue = emailQueue
        self.threadId = threadId
        self.agent_id = agent
        self.headers = {"Content-type": "application/x-www-form-urlencoded; charset=UTF-8", "Accept": "text/json"}
        self.sartreUrl = '/svc/ecommerce-core/accounts/' + self.agent_id + '/gift-certificates/purchases.json'
        self.emailUrl = '/svc/nyt-email/realtime-email/template-url/by-email';
        threading.Thread.__init__(self)
        
        
    def dprint(self, str):
        if _debug == 1:
            print str


    def run(self):
        
        threadId = str(self.threadId)
        
        self.dprint('Starting Thread #' + threadId)
        
        while True:
            
            try:
                record2process = self.emailQueue.emails2process.popleft()
            except IndexError:
                break
            
            params = '{ "meta": {"user_agent":SYSTEM,"is_cs":"true"}, '
            params += '"data": {"zero_charge_instrument": 1, '
            params += '"purchases":[{"offer_chain_id": ' + self.emailQueue.offer_chain + ', '
            params += '"recipient_email": "' + record2process['toEmail'] + '", '
            params += '"recipient_name": "' + record2process['toName'] + '", '
            params += '"sender_email": "' + record2process['fromEmail'] + '", '
            params += '"sender_name":  "' + record2process['fromName'] + '", "message":  "Bulk Code Generator"}]}}'

            gcCode = None
            
            retryCount = 5; 
            while retryCount > 0: 
                try:
                    conn = httplib.HTTPSConnection(self.emailQueue.sartreHost)
                    self.dprint("Thread: %s - Sending Request for %s" % (threadId, record2process['regiId']))
                    conn.request("POST", self.sartreUrl, params, self.headers)
                    response = conn.getresponse()
                    self.dprint("Thread: %s - Receiving Resonce for %s" % (threadId, record2process['regiId']))
                    break
                except IOError, (errno, strerror):
                    if errno != errno.ECONNRESET:
                       raise
                    else:
                       time.sleep(5)
                       retryCount -= 1

            if (response.status != 200):
                msg = "Thread: %s - %s %s %s" % (threadId, response.status, response.reason, response.read())
                self.dprint(msg)
                self.emailQueue.doneWriter.writerow([
                            record2process['regiId'],
                            record2process['toName'],
                            record2process['toEmail'],
                            record2process['fromName'],
                            record2process['fromEmail']])
            else:
                data = response.read()
                json = eval(data)
                gcCode = json['data'][0]['code']
                self.dprint("Thread: %s - %s" % (threadId, gcCode))
                if (gcCode is None):
                    msg = "Thread: %s - Attempt %s" % (threadId, data)
                    self.dprint(msg)
                    self.emailQueue.doneWriter.writerow([
                            record2process['regiId'],
                            record2process['toName'],
                            record2process['toEmail'],
                            record2process['fromName'],
                            record2process['fromEmail']])
                else:
                    if _sendmail == 1:
                        self.dprint("Thread: %s - Sending Email" % (threadId))
                    
                        emailConn = httplib.HTTPSConnection(self.emailQueue.profileHost)
                        
                        emailParams = '{"email": {"template_url": "%s", ' % (self.emailQueue.emailTemplate)
                        emailParams += '"sender_ip": "127.0.0.1", "ignore_nonfatal_errors": "true", "email_params": '
                        emailParams += '[{ "to_email": "%s", "gccode": "%s", ' % ( record2process['toEmail'], gcCode)
                        emailParams += '"from_email": "ordercs@nytimes.com"}]}}'
                        self.dprint(emailParams)
                        
                        emailConn.request("POST", self.emailUrl, emailParams, self.headers)
                        r2 = emailConn.getresponse()
                        data2 = r2.read()
                        self.dprint("Thread: %s - Receiving Responce for %s" % (threadId, record2process['regiId']))
                        if (data2 == '{"results":[]}'):
                            msg = "Thread: %s - %d %s" % (threadId, r2.status, data2)
                            self.emailQueue.doneWriter.writerow([
                                record2process['regiId'],
                                record2process['toName'],
                                record2process['toEmail'],
                                record2process['fromName'],
                                record2process['fromEmail'],
                                gcCode, 'SUCCESS Email', time.asctime()])
                        else:
                            msg = "Thread: %s - %d %s" % (threadId, r2.status, data2)
                            self.dprint(msg)
                            self.emailQueue.doneWriter.writerow([
                                record2process['regiId'],
                                record2process['toName'],
                                record2process['toEmail'],
                                record2process['fromName'],
                                record2process['fromEmail'],
                                gcCode, 'ERROR Email : ' + data2, time.asctime()])
                        emailConn.close()
                    
                    else:
                        self.dprint('Writing Log')
                        self.emailQueue.doneWriter.writerow([
                                record2process['regiId'],
                                record2process['toName'],
                                record2process['toEmail'],
                                record2process['fromName'],
                                record2process['fromEmail'],
                                gcCode, 'SUCCESS', time.asctime()])
                        
                conn.close()


        self.dprint('Ending Thread #' + threadId)


def main(argv):
    
    email_file = None
    offer_chain = None
    agent = None

    try:                                
        opts, args = getopt.getopt(argv, "hdi:o:a:e:t:m", ["help", "debug", "input=","offer=", "agent=", "env=", "threads=", "sendmail"]) 
    except getopt.GetoptError:
        usage()
        sys.exit(2)
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            usage()
            sys.exit()
        elif opt in ('-d', "--debug"):
            global _debug
            _debug = 1
            print "Debugging is ON"                  
        elif opt in ('-m', "--sendmail"):                
            global _sendmail
            _sendmail = 1
            print "Sending Mail Old Skool Style"                  
        elif opt in ("-i", "--input"): 
            email_file = arg
        elif opt in ("-o", "--offer"): 
            offer_chain = arg
        elif opt in ("-a", "--agent"): 
            agent = arg
        elif opt in ("-e", "--env"): 
            env = arg
        elif opt in ("-t", "--threads"):
            threadCount = int(arg)

    if (email_file is None or offer_chain is None or agent is None or env is None):
        print "Missing arguments"
        sys.exit(2)
        
    doneFile = email_file + '.done'

    if os.path.exists(doneFile):
        print "Error: DONE file already exists"
        sys.exit(2)

    emailQueue = EmailQueue(email_file, env, offer_chain)
    
    for x in range ( threadCount ):
        bulkLoad = GCGenerator(agent, emailQueue, x)
        bulkLoad.start()
    

if __name__ == "__main__":
    main(sys.argv[1:])
