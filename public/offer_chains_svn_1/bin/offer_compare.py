import yaml
import sys
import os
import getpass
from copy import deepcopy
import cx_Oracle

envs = {
      'main_stg': "core_owner/ecdvo1@//ecst1.stg.nytimes.com:1566/ECST",
      'circ_stg': "core_owner/ecdvo1@//ecst1.stg.nytimes.com:1568/ECST2",
      'phase_stg': "core_owner/ecdvo1@//ecst1.stg.nytimes.com:1570/ECST3",
      'prod': "coresupport/%s@//localhost:1566/ECPR" 
}

usage = '''
Wrong number of arguments. Usage: 
$ python %s <prod|main_stg|circ_stg|phase_stg> <offers.auto.yaml> 
or 
$ python %s <prod|main_stg|circ_stg|phase_stg> <offer_id> 
''' % ( sys.argv[0], sys.argv[0] )

# sqls for extracting offer_chain data from database

sel_offer_chain = """
select o.offer_chain_status_id status, 
o.description, 
o.adoptability_window_end_date end_date, 
o.group_account_type_id, 
o.product_uri,
o.revoke_entitlements,
o.id,
o.name,
o.is_address_required,
o.is_gift_certificate gift_certificate,
b.name billing_source,
o.vendor_source_id,
o.adoptability_window_start_date start_date
from core_owner.offer_chain o, core_owner.billing_source b
where b.id = o.billing_source_id
and o.id = :oc_id
"""

sel_eligibilities_for_oc = """
select name key, value
from core_owner.offer_chain_eligibility
where offer_chain_id = :oc_id
"""

sel_notifications_for_oc = """
select a.name action, n.value type
from core_owner.offer_chain_notification_type ocn, core_owner.action a, ops_owner.notification_type n
where a.id = ocn.action_id
and n.id = ocn.notification_type_id
and ocn.offer_chain_id = :oc_id
"""

sel_offerings_for_oc = """
select ooc.offer_id,
o.entitlement_duration duration,
ooc.index_value as "index",
0 price,
ooc.num_recurrences recurrences
from core_owner.offer_offer_chain ooc, core_owner.offer o
where o.id = ooc.offer_id
and ooc.offer_chain_id = :oc_id
"""

sel_metadata_for_oc = """
select name key, value
from core_owner.offer_chain_meta_data
where offer_chain_id = :oc_id
"""

sel_products_for_offer = """
select 
opo.product_offering_id,
c.code capability, 
p.name, 
p.production_cost,
po.quantity,
po.tax_category_id,
po.tax_policy_type_id,
po.unit_price,
p.product_uri uri
from core_owner.offer_product_offering opo,  core_owner.product_offering po, core_owner.capability c, core_owner.product p
where po.id = opo.product_offering_id
and c.id = po.capability_id
and p.id = po.product_id
and opo.offer_id = :o_id
"""

sel_metadata_for_product = """
select name key, value
from core_owner.product_offering_meta_data
where product_offering_id = :po_id
"""


'''
def reset_entries(elms):
   for item in elms:
      # if a list, call recursively
      if isinstance(elms, list):
         reset_entries(item)
      # if a dictionary and the value is not a list or dictionary,
      # set the keys to empty string (or None ?) unless keys are 'key' or 'action';
      if isinstance(elms, dict):
         if isinstance(elms[item], list) or isinstance(elms[item], dict):
            reset_entries(elms[item])
         else:
            if item != 'key' and item != 'action':
               elms[item] = ''

'''

def load_offers_from_db(conn, new_offers):
   old_offers = { 'offer_chains': [] }
   for offer in new_offers['offer_chains']:
      old_offer = load_offer(conn, offer['id'])
      if old_offer != {}:
         old_offers['offer_chains'].append(old_offer)
   return old_offers      

def load_offer(conn, offer_id):
   offer = {}
   # skip if have new offer
   if offer_id == 0:
      return offer

   # offer_chain
   cur = conn.cursor()
   cur.execute(sel_offer_chain, oc_id=offer_id)
   row = cur.fetchone()
   if row == None:
      # no offer found
      return offer

   offer = dict(zip((d[0].lower() for d in cur.description), row))
   
   # eligibilities
   cur.execute(sel_eligibilities_for_oc, oc_id=offer_id)
   eligibilities = []
   for el in cur.fetchall():
      el_item = dict(zip((d[0].lower() for d in cur.description), el))
      eligibilities.append(el_item)
   eligibilities = sorted(eligibilities, key=lambda elem: elem['key'])
   offer['eligibility'] = eligibilities
   
   # notifications
   cur.execute(sel_notifications_for_oc, oc_id=offer_id)
   notifications = []
   for nt  in cur.fetchall():
      nt_item = dict(zip((d[0].lower() for d in cur.description), nt))
      notifications.append(nt_item)
   notifications = sorted(notifications, key=lambda elem: elem['action'])
   offer['notifications'] = notifications

   # metadata
   cur.execute(sel_metadata_for_oc, oc_id=offer_id)
   metadata  = []
   for md in cur.fetchall():
      md_item = dict(zip((d[0].lower() for d in cur.description), md))
      metadata.append(md_item)
   metadata = sorted(metadata, key=lambda elem: elem['key'])
   offer['metadata'] = metadata

   # offerings
   offerings = []
   cur.execute(sel_offerings_for_oc, oc_id=offer_id)
   for ofr in cur.fetchall():
      offer_item = dict(zip((d[0].lower() for d in cur.description), ofr))
      offerings.append(offer_item)
   offer['offerings'] = offerings
   
   # products
   for offer_item in offer['offerings']:
      products = []
      cur.execute(sel_products_for_offer, o_id=offer_item['offer_id'])
      for prod in cur.fetchall():
         prod_item = dict(zip((d[0].lower() for d in cur.description), prod))
         products.append(prod_item)
      offer_item['products'] = products

   # metadata for each product
   for offer_item in offer['offerings']:
      for prod_item in offer_item['products']:
         metadata = []
         cur.execute(sel_metadata_for_product, po_id=prod_item['product_offering_id'])
         for md in cur.fetchall():
            md_item = dict(zip((d[0].lower() for d in cur.description), md))
            metadata.append(md_item)
         prod_item['metadata'] = metadata
   
   return offer


def main():
   if len(sys.argv) != 3:
      sys.exit(usage)
   
   env = sys.argv[1]
   if env not in envs:
      sys.exit("Wrong environment, got: %s, expected: prod|main_stg|circ_stg|phase_stg" % env)
   
   conn_str = envs[env]
   # for production, ask for db password
   if env == 'prod':
      pwd = getpass.getpass("DB password:")
      conn_str = conn_str % pwd

   offer_id = None
   new_yaml_file_name = None
   
   # if the second argument is not an offer_id (cannot be 'casted' as int), 
   # then assume that it is the new offers.auto.yaml file name generated by offer_maker
   try:
      offer_id = int(sys.argv[2])
   except ValueError:
      new_yaml_file_name = sys.argv[2]

   new_offers = {}
   
   try:
      with cx_Oracle.Connection(conn_str) as conn:

         if new_yaml_file_name != None:
      
            with open(new_yaml_file_name, 'rb') as f:
               new_offers = yaml.load(f)
            
            # sort some of the lists for easier diff
            for oc in new_offers['offer_chains']:
               oc['metadata'] = sorted(oc['metadata'], key=lambda elem: elem['key'])
               # check if have any notifications
               if oc.has_key('notifications') and oc['notifications'] != None:
                  oc['notifications'] = sorted(oc['notifications'], key=lambda elem: elem['action'])
               oc['eligibility'] = sorted(oc['eligibility'], key=lambda elem: elem['key'])

            with open('new_offers.yaml', 'wb') as f:
               yaml.dump(new_offers, f, default_flow_style=False)

            old_offers = load_offers_from_db(conn, new_offers)
            with open('old_offers.yaml', 'wb') as f:
               yaml.dump(old_offers, f, default_flow_style=False)
      
         else: 
            # assumes the second argument is an offer_id, extract it from database and
            # write to an yaml file
            print "Extracting offer data for offer: %d from the database." % offer_id
            offer = load_offer(conn, offer_id)

            with open('offer.yaml', 'wb') as f:
               yaml.dump(offer, f, default_flow_style=False)

   except cx_Oracle.DatabaseError as err:
      sys.stderr.write( "Error extracting offers from environment {env}: {err}".format(env=env, err=err) )


   print "Done."

if __name__ == '__main__':
   main()

