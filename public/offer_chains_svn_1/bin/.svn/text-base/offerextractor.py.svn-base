import sys
import cx_Oracle
from operator import itemgetter
import pprint
import datetime
import getpass

oc_query = """
SELECT
  NVL(md_uid.value, oc.name || oc.description || oc.create_date || oc.created_by || oc.offer_chain_status_id || ( select listagg(name || value, '') within group ( order by name ) from offer_chain_eligibility where offer_chain_id = oc.id) || ( select listagg(name || value, '') within group (order by name) from offer_chain_meta_data where offer_chain_id = oc.id )) group_id,
  oc.id OFFER_CHAIN_ID,
  NVL(md_uid.value, 'None') UUID,
  oc.name NAME,
  oc.description DESCRIPTION,
  md_sub.value SUBSCRIBER_TYPE,
  md_bundle.value BUNDLE_NAME,
  md_ofr_type.value OFFER_TYPE,
  md_bill_cycle.value BILLING_CYCLE,
  md_exp.value OFFER_EXPLANATION,
  ( SELECT listagg(name || ': ' || value, ', ') within group ( order by name ) from offer_chain_eligibility where offer_chain_id = oc.id ),
  md_prd_id.VALUE CIS_PRD_ID,
  oc.create_date
FROM
  offer_chain oc
  LEFT JOIN offer_chain_meta_data md_sub ON md_sub.offer_chain_id = oc.id and md_sub.name = 'SUBSCRIBER_TYPE'
  LEFT JOIN offer_chain_meta_data md_bundle ON md_bundle.offer_chain_id = oc.id and md_bundle.name = 'BUNDLE'
  LEFT JOIN offer_chain_meta_data md_ofr_type ON md_ofr_type.offer_chain_id = oc.id AND md_ofr_type.name = 'OFFER_TYPE'
  LEFT JOIN offer_chain_meta_data md_bill_cycle ON md_bill_cycle.offer_chain_id = oc.id AND md_bill_cycle.name = 'BILLING_CYCLE'
  LEFT JOIN offer_chain_meta_data md_uid ON md_uid.offer_chain_id = oc.id AND md_uid.name = 'UID'
  LEFT JOIN offer_chain_meta_data md_exp ON md_exp.offer_chain_id = oc.id AND md_uid.name = 'BUNDLE_EXPLANATION'
  LEFT JOIN offer_chain_meta_data md_prd_id ON md_prd_id.offer_chain_id = oc.id AND md_prd_id.name = 'CIS_PRD_ID'
WHERE
  oc.offer_chain_status_id = 1
ORDER BY 2
"""

environments = (
  ('Mainline/1b\' Dev', 'core_owner/ecdvo1@//192.168.200.133:1549/ECDV1'),
  ('Phase 1C Dev', 'core_owner/ecdvo1@//192.168.200.133:1589/ECDV2'),
  ('TT Dev', 'core_owner/ecdvo1@//192.168.200.133:1559/ECDV3'),
  ('Circ Dev', 'core_owner/ecdvo1@//192.168.200.133:1569/ECDV4'),
  ('Mainline/1b\' Staging', 'core_owner/ecdvo1@(DESCRIPTION=(ADDRESS_LIST=(load_balance=on)(failover=on)(ADDRESS=(PROTOCOL=TCP)(HOST=10.5.103.179)(PORT=1566))(ADDRESS=(PROTOCOL=TCP)(HOST=10.5.103.180)(PORT=1566)))(CONNECT_DATA=(SERVER=DEDICATED)(service_name=ECST)(FAILOVER_MODE=(TYPE=SELECT)(METHOD=BASIC)(RETRIES=20)(DELAY=15))))'),
  ('Phase Staging', 'core_owner/ecdvo1@//10.5.103.179:1568/ECST2'),
  ('Circ Staging', 'core_owner/ecdvo1@//10.5.103.180:1598/ECST3')
)

env_ocs = dict()

for i, env in enumerate(environments):
  try:
    with cx_Oracle.Connection(env[1]) as conn:
      cur = conn.cursor()
      cur.execute(oc_query)
      sys.stderr.write( "Fetching OC's from {env}\n".format(env=env[0]) )

      for oc in cur.fetchall():
        # Create a tuple to hold the ids and the oc itself
        oc_uid = env_ocs.setdefault(oc[0], ([''] * len(environments), oc[2:]))
        # Store the id in the first element of the tuple
        oc_uid[0][i] = oc[1]
  except cx_Oracle.DatabaseError as err:
    sys.stderr.write( "Error extracting offers from environment {env}: {err}".format(env=env[0], err=err) )

#sys.stdout.write("""====== Sartre Offer Chains ======
#===== History =====
#
#^ Date ^ Updated By ^
sys.stdout.write("""| {date} | {user} |

===== List of Environments =====

^ DB ^ Environment Use ^ CSTools ^ API Server ^ EXT API Server ^ Core Server ^ Reporting Server ^
||||||||
|  **//Development//**  |||||||
||||||||
| ECDV1 | Mainline / Phase1B' | cstools01.qprvt.nytimes.com, cstools02.qprvt.nytimes.com | sartre-api01.qprvt.nytimes.com, sartre-api02.qprvt.nytimes.com | sartre-api-ext01.qprvt.nytimes.com, sartre-api-ext02.qprvt.nytimes.com | sartre-core01.qprvt.nytimes.com, sartre-core02.qprvt.nytimes.com | sartre-reporting01.qprvt.nytimes.com, sartre-reporting02.qprvt.nytimes.com |
| ECDV2 | Phase 1C | cstools05.qprvt.nytimes.com, cstools06.qprvt.nytimes.com | sartre-api05.qprvt.nytimes.com, sartre-api06.qprvt.nytimes.com | sartre-api-ext05.qprvt.nytimes.com, sartre-api-ext06.qprvt.nytimes.com | sartre-core05.qprvt.nytimes.com, sartre-core06.qprvt.nytimes.com | sartre-reporting05.qprvt.nytimes.com, sartre-reporting06.qprvt.nytimes.com |
| ECDV3 | Thumbtack |  | thumbtack-api01.qprvt.nytimes.com | thumbtack-api-ext01.qprvt.nytimes.com | thumbtack-core01.qprvt.nytimes.com | |
| ECDV4 | Circulation | cstools03.qprvt.nytimes.com, cstools04.qprvt.nytimes.com | sartre-api03.qprvt.nytimes.com, sartre-api04.qprvt.nytimes.com | sartre-api-ext03.qprvt.nytimes.com, sartre-api-ext04.qprvt.nytimes.com | sartre-core03.qprvt.nytimes.com, sartre-core04.qprvt.nytimes.com | sartre-reporting03.qprvt.nytimes.com, sartre-reporting04.qprvt.nytimes.com |
||||||||
|  **//Staging//**  |||||||
||||||||
| ECST | Mainline / Phase1B' | cstools01.sprvt.nytimes.com, cstools02.sprvt.nytimes.com | sartre-api01.sprvt.nytimes.com, sartre-api02.sprvt.nytimes.com | sartre-api-ext01.sprvt.nytimes.com, sartre-api-ext02.sprvt.nytimes.com | sartre-core01.sprvt.nytimes.com, sartre-core02.sprvt.nytimes.com | sartre-reporting01.sprvt.nytimes.com, sartre-reporting02.sprvt.nytimes.com |
| ECST2 | Phase | cstools05.sprvt.nytimes.com, cstools06.sprvt.nytimes.com | sartre-api05.sprvt.nytimes.com, sartre-api06.sprvt.nytimes.com | sartre-api-ext05.sprvt.nytimes.com, sartre-api-ext06.sprvt.nytimes.com | sartre-core05.sprvt.nytimes.com, sartre-core06.sprvt.nytimes.com | sartre-reporting05.sprvt.nytimes.com, sartre-reporting06.sprvt.nytimes.com |
| ECST3 | Circulation | cstools03.sprvt.nytimes.com, cstools04.sprvt.nytimes.com | sartre-api03.sprvt.nytimes.com, sartre-api04.sprvt.nytimes.com | sartre-api-ext03.sprvt.nytimes.com, sartre-api-ext04.sprvt.nytimes.com | sartre-core03.sprvt.nytimes.com, sartre-core04.sprvt.nytimes.com | sartre-reporting03.sprvt.nytimes.com, sartre-reporting04.sprvt.nytimes.com |

===== Offer Chain distribution =====

""".format( date=datetime.datetime.now(), user=getpass.getuser() )
)

header = [env[0] for env in environments] + ['Name', 'Description', 'Subscriber Type', 'Bundle Name', 'Offer Type', 'Billing Cycle', 'Bundle Explanation', 'Eligibility', 'CIS Prod id', 'Create Date'] + ['UID']

sys.stdout.write("^  Environment  ^^^^^^^  OfferChain data  ^^^^^^^^^^^\n")
sys.stdout.write("^ {0} ^\n".format(" ^ ".join(header)))

count = 0
for uid, oc in sorted(env_ocs.iteritems(), key=lambda (k,v): v[1][-1]):
  count += 1
  if count % 10 == 0:
    header = [env[0] for env in environments] + ['Name', 'Description', 'Subscriber Type', 'Bundle Name', 'Offer Type', 'Billing Cycle', 'Bundle Explanation', 'Eligibility', 'CIS Prod id', 'Create Date'] + ['UID']
    sys.stdout.write("^ {0} ^\n".format(" ^ ".join(header)))
  row = [ oc[0][i] for i,v in enumerate(environments) ] + list(oc[1][1:]) + [oc[1][0]]
  sys.stdout.write("| {0} |\n".format(" | ".join([ str(i) for i in row ])))
sys.stdout.write("^ {0} ^\n".format(" ^ ".join(header)))

