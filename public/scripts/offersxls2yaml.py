#!/usr/local/bin/python

import sys
import os
import string

sys.path.append(os.path.join(os.path.realpath(os.path.dirname(sys.argv[0])), '..', 'lib'))

import copy
import csv
import pprint
import xlrd
import re
import datetime
from itertools import ifilter

pairs = {}
templates = {}
offer_start_column = 6

__KNOWN_TYPES = ('Meta Data', 'Actual', 'Eligibility', 'Notification')
offers_to_dup_for_email_elig = []

__WB_DATEMODE = None

def main():
  global offer_start_column
  global __WB_DATEMODE
  offer_start_row = None
  offerings_start_row = None

  offers_xls = sys.argv[1]
  edu_xls = sys.argv[2] if len(sys.argv) > 2 else None

  wb = xlrd.open_workbook(filename=offers_xls)
  __WB_DATEMODE = wb.datemode

  for sheet in ( i for i in wb.sheet_names() if re.search(r'Offers', i,re.IGNORECASE) or re.search(r'EDU Offer Templates', i) ):
    sheet_reader = wb.sheet_by_name(sheet)
    target = pairs if sheet != 'EDU Offer Templates' else templates
    target[sheet] = []

    for line_num in xrange(sheet_reader.nrows):
      line = sheet_reader.row_values(line_num)

      key, type = line[2], line[4]
      if key == 'NAME':
        offer_start_row = line_num
      elif key == 'Offer Order (For Offer Offer Chain)':
        offerings_start_row = line_num

      if offer_start_row is None or line_num < offer_start_row:
        continue

      if line_num < offerings_start_row or offerings_start_row is None:
        # main offer and metadata values
        if type not in __KNOWN_TYPES and key != 'Product Bundle':
          continue

        for i in range(len(line) - offer_start_column):
          target[sheet].append({})

        for i, rec in enumerate(line[offer_start_column:]):
          offer = target[sheet][i]
          if type == 'Actual':
            if key == 'ID':
              match = re.match(r'(\d+)', str(rec))
              if match:
                rec = match.group(1)
            offer[key] = rec
          elif type == 'Meta Data':
            offer.setdefault('metadata', []).append( (key, rec) )
          elif type == 'Eligibility':
            offer.setdefault('eligibility', []).append( (key, rec) )
            if key == 'REQUIRES_EMAIL_DOMAIN':
              for email_domain in rec.split(','):
                offer.setdefault('metadata', []).append( (key, email_domain) )
              if rec.count(',') > 0:
                offers_to_dup_for_email_elig.append((sheet, i))
          elif key == 'Product Bundle':
            offer['bundle_id'] = rec
          elif type == 'Notification':
            offer.setdefault('notification', []).append( (key, rec) )
      else:
        # Parse the offerings
        for i, rec in enumerate(line[offer_start_column:]):
          if target[sheet][i].get('no_more_offers'):
            continue

          if key == 'Offer Order (For Offer Offer Chain)':
            if rec in ('N/A', '', None):
              target[sheet][i]['no_more_offers'] = 1
            else:
              target[sheet][i].setdefault('offers', []).append({'index':rec})
          elif key == 'Number of Recurrences':
            rec_lower_case = string.lower(str(rec))
            target[sheet][i]['offers'][-1]['recurrences'] = -1 if rec_lower_case == string.lower("Tilforbid") else rec
          elif key == 'Entitlement Duration':
            target[sheet][i]['offers'][-1]['duration'] = rec
          elif key == 'MONTHLY_PRICE' or key == 'MARKET_PRICE':
            target[sheet][i]['offers'][-1]['price'] = rec
          elif key == 'International Mark Up':
            target[sheet][i]['offers'][-1]['markup'] = rec
          elif key == 'Discount':
            target[sheet][i]['offers'][-1]['discount'] = rec

  try:
    edu_sheet = wb.sheet_by_name('EDU Details')
    for line_num in xrange(1, edu_sheet.nrows):
      line = edu_sheet.row_values(line_num)
      (college_code, college_name, state, discount, email_domain, college_name_and_state) = line
      o = reduce(lambda x, y: y if y.get('offers') and y['offers'][0]['discount'] == discount else x, templates['EDU Offer Templates'])
      offer = copy.deepcopy(o)
      for type in ('metadata', 'eligibility'):
        for i, tpl in enumerate(offer[type]):
          if tpl[0] == u'REQUIRES_EMAIL_DOMAIN':
            offer[type].pop(i)
            offer[type].append( (u'REQUIRES_EMAIL_DOMAIN', email_domain) )
            break
      offer['metadata'] += [
          (u'COLLEGE_CODE', college_code),
          (u'COLLEGE_NAME', college_name),
          (u'STATE', state),
          (u'COLLEGE_NAME_AND_STATE', college_name_and_state)
        ]
      pairs.setdefault('EDU Offers', []).append(offer)
  except xlrd.biffh.XLRDError:
    pass

  sys.stdout.write('offer_chains:\n')
  for sheet_name, sheet in pairs.iteritems():
    write_header(sheet_name)
    for i, offer in enumerate(sheet):
      if offer == {}:
        continue
      try:
        write_offer_header(i)
        write_offer(i, offer)
        write_eligibility(offer)
        write_metadata(offer)
        write_notifications(offer)
        write_offerings(offer)
      except:
        sys.stderr.write('Error writing sheet: %s offer %s\n' % (sheet_name, i))
        raise

def bundle(id):
  bundles = dict( {
    1 : web() + wap() + article() + timesmachine() + smartphone(),
    2 : web() + wap() + article() + timesmachine() + tablet() + timesreaderhd(),
    3 : web() + wap() + article() + timesmachine() + smartphone() + tabletallaccess() + timesreaderhd(),
    4 : webhd() + wap() + article() + timesmachine() + smartphonehd() + replica() + crosswordshd() + tablethd() + timesreaderhd(),
    5 : webhd() + wap() + article() + timesmachine() + replica(),
    6 : webhd() + wap() + article() + timesmachine() + smartphonehd(),
    7 : webhd() + wap() + article() + timesmachine() + tablethd() + timesreaderhd(),
    8 : tabletmeu() + timesreaderhd(),
    9 : webhd() + wap() + article() + timesmachine() + smartphonehd() + tablethd() + timesreaderhd() + crosswordshd(),
    10 : crosswords(),
    11 : timesreader(),
    12 : single_article(),
    13 : ihtreader(),
    14 : webhd() + wap() + article() + timesmachine() + smartphonehd() + tablethd() + timesreaderhd(),
    15 : webtaxfree() + wap() + article() + timesmachine() + ihtsmartphone(),
    16 : ihttablet(),
    17 : webtaxfree() + wap() + article() + timesmachine() + ihtsmartphone() + ihttabletada() + ihtreaderhd(),
    18 : webhd() + wap() + article() + timesmachine() + ihtsmartphonecomp(),
    19 : ihttabletcomp(),
    20 : webhd() + wap() + article() + timesmachine() + ihtsmartphonecomp() + ihttabletcomp() + ihtreaderhd(),
    21 : webhd() + wap() + article() + timesmachine() + smartphonehd() + ihtsmartphonecomp() + tablethd() + timesreaderhd() + ihttabletcomp() + ihtreaderhd() + crosswordshd(),
    22 : webtaxfree() + wap() + article() + timesmachine() + smartphonetaxfree(),
    23 : webtaxfree() + wap() + article() + timesmachine() + tablettaxfree() + timesreaderhd(),
    24 : webtaxfree() + wap() + article() + timesmachine() + smartphonetaxfree() + tabletallaccesstaxfree() + timesreaderhd(),
    26 : meuintenttobuy(),
    27 : ihtreader(),
    28 : webhd() + wap() + article() + timesmachine() + smartphonehd() + replica() + tablethd() + timesreaderhd(),
    30 : carecrosswords(),
  } )
  try:
    ret = "\n".join([ (" " * 10) + i for i in bundles[id].split("\n") ])
  except KeyError:
    sys.stderr.write("Unknown bundle: {id}\n".format(id=id))
    ret = 'UNKNOWN BUNDLE'
    raise
  return ret

def escape(x):
  if x != None and type(x) == type(u"") and x.find(u'\u2019') >= 0 :
    x = x.replace(u'\u2019', '\'')
    return x.replace("'","''")
  else:
    return str(x).replace("'", "''")   

def extract_date(date):
  try:
    return 'to_date(\'' + datetime.datetime(*xlrd.xldate_as_tuple(date, __WB_DATEMODE)).strftime('%d-%b-%Y %T') + '\',\'DD-MON-YY HH24:MI:SS\')'
  except ValueError:
    if re.match(r'\d\d-\w\w\w-\d\d\d\d', date):
      return date
    else:
      raise

def write_header(name):
  sys.stdout.write("""
################################################################################
##   Spreadsheet Name: {name}
################################################################################
""".format(name=name))

def write_offer_header(column):
  sys.stdout.write("""
  ##############################################################################
  ##   Offer column: {i}
  ##############################################################################
  """.format(i=column_letter(column + offer_start_column)))

def column_nums(column, nums=None, first_level=False):
  if nums is None:
    nums = []
  quo, rem = divmod(column, 26)
  nums.insert(0, rem)
  if quo > 26:
    nums += column_num(quo)
  else:
    if first_level is True:
      if quo > 0:
        nums.insert(0, quo - 1)
  return nums

def column_letter(column):
  letters = "".join([ chr(65 + i) for i in column_nums(column, first_level=True) ])
  return letters

def write_offer(column, offer):
  try:
    sys.stdout.write("""
  - name: \"{name}\"
    description: \"{description}\"
    start_date: {start_date}
    end_date: {end_date}
    gift_certificate: {gc}
    product_uri:
    id: {id}
    revoke_entitlements: {revoke}
    vendor_source_id: {vendor_source_id}
    group_account_type_id : \"{group_account_type_id}\"
    amazon_appstore_sku : \"{amazon_appstore_sku}\"
    is_address_required: {is_address_required}
    billing_source: {billing_source}
    status: {status}""".format(
      id = int(offer['ID']) if offer.get('ID') else '',
      name = offer['NAME'],
      description = escape(offer['DESCRIPTION']),
      start_date = extract_date(offer['ADOPTABILITY_WINDOW_START_DATE']),
      end_date = extract_date(offer['ADOPTABILITY_WINDOW_END_DATE']),
      gc = 1 if offer['IS_GIFT_CERTIFICATE'] == 1 else 0,
      status = 1 if offer['STATUS'] == 'Active' else 1,
      revoke = 1 if offer.get('REVOKE_ENTITLEMENTS') else 0,
      vendor_source_id = int(offer['VENDOR_SOURCE_ID']) if offer.get('VENDOR_SOURCE_ID') else 1,
      group_account_type_id= offer['GROUP_ACCOUNT_TYPE_ID'],
      is_address_required = int(offer['IS_ADDRESS_REQUIRED']),
      billing_source = offer['BILLING_SOURCE'],
      amazon_appstore_sku = offer['AMAZON_APPSTORE_SKU'] if offer.get('AMAZON_APPSTORE_SKU') else ''
      )
    )
  except:
    sys.stderr.write("Error writing offer: %s\n" % (offer,))
    raise

def write_eligibility(offer):
  sys.stdout.write("""
    eligibility:""")
  ## Add eligibility rules
  for key, value in offer.get('eligibility'):
    try:
      value = float(value)
      value = int(value) if int(value) == value else value
      if key == 'ANNUAL_PRICE':
        value = "{0:.2f}".format(value)
    except ValueError:
      value = value
    sys.stdout.write("""
      - key: \"{key}\"
        value: \"{value}\"""".format(key=key, value=value))

def write_metadata(offer):
  sys.stdout.write("""
    metadata:""")
      ## Add meta data 
  for key, value in offer['metadata']:
    #  This is a way to ensure that if we get a float, and it is integer, that we print it as an int, not a float
    try:
      value = float(value)
      value = int(value) if int(value) == value else value
      if key == 'ANNUAL_PRICE':
        value = "{0:.2f}".format(value)
    except ValueError:
      value = value

    sys.stdout.write("""
      - key: \"{key}\"
        value: \"{value}\"""".format(key=key, value=escape(value) if value else ''))

def write_notifications(offer):
  if offer.get('notification'):
    sys.stdout.write("""
    notifications:""")
    for action, type in offer['notification']:
      if type:
        sys.stdout.write("""
      - action: \"{action}\"
        type: \"{type}\"""".format(action=action, type=type if type else ''))

def write_offerings(offer):
  sys.stdout.write("""
    offerings:""")
  for i, offering in enumerate(offer['offers']):
    if offering['duration'] == 365:
      article_quantity = 1200
    else:
      article_quantity = int(offering['duration'] / 28 * 100)

    sys.stdout.write("""
      - duration: {duration!s}
        index: {index}
        recurrences: {recur}
        price: '{price}'
        products:{products}""".format(
          duration = int(offering['duration']),
          index = i,
          recur = int(offering['recurrences']),
          price = round(offering['price'], 2),
          products = bundle(offer['bundle_id']).format(
            quantity=int(offering['duration']),
            article_quantity = article_quantity,
            markup = offering['markup']
            )
      ))


################################################################################
##      PRODUCTS
################################################################################
def product(prd):
  yamls = {
      'web': """
- name: Web
  tax_category_id: 2
  tax_policy_type_id: 1
  production_code:
  uri:
  production_cost: 0
  unit_price: '0.357143'
  quantity: {quantity}
  capability: 'MM'
  metadata:
    - key: entitlement_uri
      value: 'http://:hostname:/svc/user/entitlements/mm/:id:.json'
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'
    - key: capability
      value: MM"""

  , 'webhd': """
- name: Web
  tax_category_id: 2
  tax_policy_type_id: 1
  production_code:
  uri:
  production_cost: 0
  unit_price: '0'
  quantity: {quantity}
  capability: 'MM'
  metadata:
    - key: entitlement_uri
      value: 'http://:hostname:/svc/user/entitlements/mm/:id:.json'
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'
    - key: capability
      value: MM"""

  , 'webtaxfree': """
- name: Web
  tax_category_id: 2
  tax_policy_type_id: 2
  production_code:
  uri:
  production_cost: 0
  unit_price: '0.357143'
  quantity: {quantity}
  capability: 'MM'
  metadata:
    - key: entitlement_uri
      value: 'http://:hostname:/svc/user/entitlements/mm/:id:.json'
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'
    - key: capability
      value: MM"""

  , 'wap': """
- name: Mobile
  tax_category_id: 2
  tax_policy_type_id: 1
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0'
  quantity: {quantity}
  capability: 'MOW'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/mow/:id:.json
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'
    - key: capability
      value: MOW"""

 , 'article': """
- name: Archive Article
  tax_category_id: 2
  tax_policy_type_id: 1
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0'
  quantity: {article_quantity}
  capability: 'AAA'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/archive/size/{article_quantity}/:id:.json
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'"""

 , 'single_article': """
- name: Archive Article
  tax_category_id: 2
  tax_policy_type_id: 1
  production_cost:
  uri:
  production_cost: 0
  unit_price: '3.95'
  quantity: 1
  capability: 'AAA'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/archive/size/1/:id:.json
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'"""

  , 'timesmachine': """
- name: TimesMachine
  tax_category_id: 2
  tax_policy_type_id: 1
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0'
  quantity: {quantity}
  capability: 'NONE'
  metadata:
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'"""

  , 'replica': """
- name: Replica
  tax_category_id: 2
  tax_policy_type_id: 1
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0'
  quantity: {quantity}
  capability: 'NONE'
  metadata:
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'"""

  , 'smartphone': """
- name: Smartphone
  tax_category_id: 2
  tax_policy_type_id: 1
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0.178571'
  quantity: {quantity}
  capability: 'MSD'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/msd/:id:.json
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'
    - key: capability
      value: MSD"""

  , 'smartphonetaxfree': """
- name: Smartphone
  tax_category_id: 2
  tax_policy_type_id: 2
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0.178571'
  quantity: {quantity}
  capability: 'MSD'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/msd/:id:.json
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'
    - key: capability
      value: MSD"""

  , 'smartphonehd': """
- name: Smartphone
  tax_category_id: 2
  tax_policy_type_id: 1
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0'
  quantity: {quantity}
  capability: 'MSD'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/msd/:id:.json
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'
    - key: capability
      value: MSD"""

  , 'tablet': """
- name: Tablet
  tax_category_id: 2
  tax_policy_type_id: 1
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0.357143'
  quantity: {quantity}
  capability: 'MTD'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/mtd/:id:.json
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'
    - key: capability
      value: MTD"""

  , 'tablettaxfree': """
- name: Tablet
  tax_category_id: 2
  tax_policy_type_id: 2
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0.357143'
  quantity: {quantity}
  capability: 'MTD'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/mtd/:id:.json
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'
    - key: capability
      value: MTD"""

  , 'tablethd': """
- name: Tablet
  tax_category_id: 2
  tax_policy_type_id: 1
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0'
  quantity: {quantity}
  capability: 'MTD'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/mtd/:id:.json
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'
    - key: capability
      value: MTD""" 

  , 'tabletmeu': """
- name: Tablet
  tax_category_id: 2
  tax_policy_type_id: 1
  production_cost:
  uri:
  production_cost: 0
  unit_price: '1.25'
  quantity: {quantity}
  capability: 'MTD'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/mtd/:id:.json
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'
    - key: capability
      value: MTD""" 

  , 'tabletihd': """
- name: Tablet
  tax_category_id: 2
  tax_policy_type_id: 1
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0.164384'
  quantity: {quantity}
  capability: 'MTD'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/mtd/:id:.json
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'
    - key: capability
      value: MTD""" 

  , 'tabletallaccess': """
- name: Tablet
  tax_category_id: 2
  tax_policy_type_id: 1
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0.714286'
  quantity: {quantity}
  capability: 'MTD'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/mtd/:id:.json
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'
    - key: capability
      value: MTD"""

  , 'tabletallaccesstaxfree': """
- name: Tablet
  tax_category_id: 2
  tax_policy_type_id: 2
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0.714286'
  quantity: {quantity}
  capability: 'MTD'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/mtd/:id:.json
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'
    - key: capability
      value: MTD"""

  , 'timesreader': """
- name: TimesReader
  tax_category_id: 2
  tax_policy_type_id: 1
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0.713929'
  quantity: {quantity}
  capability: 'TNR'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/timesreader/:id:.json
    - key: capability
      value: TNR
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'""" 

  , 'timesreaderhd': """
- name: TimesReader
  tax_category_id: 2
  tax_policy_type_id: 1
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0'
  quantity: {quantity}
  capability: 'TNR'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/timesreader/:id:.json
    - key: capability
      value: TNR
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'"""

  , 'ihtreader': """
- name: IHTReader
  tax_category_id: 2
  tax_policy_type_id: 2
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0.533929'
  quantity: {quantity}
  capability: 'IHTR'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/ihtreader/:id:.json
    - key: capability
      value: IHT
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'""" 

  , 'ihtreaderhd': """
- name: IHTReader
  tax_category_id: 2
  tax_policy_type_id: 2
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0'
  quantity: {quantity}
  capability: 'IHTR'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/ihtreader/:id:.json
    - key: capability
      value: IHT
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'"""

  , 'crosswordshd': """
- name: Crosswords
  tax_category_id: 2
  tax_policy_type_id: 1
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0'
  quantity: {quantity}
  capability: 'XWD'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/crosswords/:id:.json
    - key: capability
      value: XWD
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'"""

  , 'carecrosswords': """
- name: Crosswords
  tax_category_id: 4
  tax_policy_type_id: 1
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0'
  quantity: {quantity}
  capability: 'XWD'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/crosswords/:id:.json
    - key: capability
      value: XWD
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'"""

  , 'crosswords': """
- name: Crosswords
  tax_category_id: 4
  tax_policy_type_id: 1
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0.24'
  quantity: {quantity}
  capability: 'XWD'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/crosswords/:id:.json
    - key: capability
      value: XWD
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'"""

  , 

'ihtsmartphone': """
- name: IHTSmartphone
  tax_category_id: 2
  tax_policy_type_id: 2
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0.178571'
  quantity: {quantity}
  capability: 'GMSD'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/gmsd/:id:.json
    - key: capability
      value: GMSD
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'"""

  , 'ihtsmartphonecomp': """
- name: IHTSmartphone
  tax_category_id: 2
  tax_policy_type_id: 1
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0'
  quantity: {quantity}
  capability: 'GMSD'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/gmsd/:id:.json
    - key: capability
      value: GMSD
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'"""

  , 'ihttablet': """
- name: IHTTablet
  tax_category_id: 2
  tax_policy_type_id: 2
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0.535714'
  quantity: {quantity}
  capability: 'GMTD'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/gmtd/:id:.json
    - key: capability
      value: GMTD
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'"""

  , 'ihttabletada': """
- name: IHTTablet
  tax_category_id: 2
  tax_policy_type_id: 2
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0.357143'
  quantity: {quantity}
  capability: 'GMTD'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/gmtd/:id:.json
    - key: capability
      value: GMTD
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'"""

  , 'ihttabletcomp': """
- name: IHTTablet
  tax_category_id: 2
  tax_policy_type_id: 1
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0'
  quantity: {quantity}
  capability: 'GMTD'
  metadata:
    - key: entitlement_uri
      value: http://:hostname:/svc/user/entitlements/gmtd/:id:.json
    - key: capability
      value: GMTD
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'"""

  , 'meuintenttobuy': """
- name: MeuIntentToBuy
  tax_category_id: 2
  tax_policy_type_id: 1
  production_cost:
  uri:
  production_cost: 0
  unit_price: '0'
  quantity: {quantity}
  capability: 'NONE'
  metadata:
    - key: DEFAULT_VAT_RATE
      value: '{{"*": {markup}}}'"""
  }
  return yamls[prd]

def web():
  return product('web')

def webhd():
  return product('webhd')

def webtaxfree():
  return product('webtaxfree')

def wap():
  return product('wap')

def article():
  return product('article')

def single_article():
  return product('single_article')

def timesmachine():
  return product('timesmachine')

def replica():
  return product('replica')

def smartphone():
  return product('smartphone')

def smartphonehd():
  return product('smartphonehd')

def tablet():
  return product('tablet')

def tablethd():
  return product('tablethd')

def tabletmeu():
  return product('tabletmeu')

def tabletihd():
  return product('tabletihd')

def tabletallaccess():
  return product('tabletallaccess')

def timesreader():
  return product('timesreader')

def timesreaderhd():
  return product('timesreaderhd')

def ihtreader():
  return product('ihtreader')

def ihtreaderhd():
  return product('ihtreaderhd')

def crosswords():
  return product('crosswords')

def carecrosswords():
  return product('carecrosswords')

def crosswordshd():
  return product('crosswordshd')

def ihtsmartphone():
  return product('ihtsmartphone')

def ihtsmartphonecomp():
  return product('ihtsmartphonecomp')

def ihttablet():
  return product('ihttablet')

def ihttabletada():
  return product('ihttabletada')

def ihttabletcomp():
  return product('ihttabletcomp')

def smartphonetaxfree():
  return product('smartphonetaxfree')

def tablettaxfree():
  return product('tablettaxfree')

def tabletallaccesstaxfree():
  return product('tabletallaccesstaxfree')

def meuintenttobuy():
  return product('meuintenttobuy')

if __name__ == '__main__':
  main()
