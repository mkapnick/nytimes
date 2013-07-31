#!/usr/bin/env python
################################################################################
#
# Make offer chains in Sartre
# This app will make SQL statements to create offer chains.  Optionally it will
# run them through SQLPlus for you.
#
#
#
#
#
################################################################################

from __future__ import with_statement
from __future__ import print_function

import sys
import yaml
import binascii
from decimal import Decimal, InvalidOperation, getcontext
from hashlib import sha256

sql_stmts = dict()


class Printer(object):
    def print(self, msg):
        if msg.strip() == "I":
            pass

        print(msg)


class Maker(object):
    printer = Printer()

    def main(self):

        with open(sys.argv[1]) as offerXlsFile:
            offerYaml = yaml.load(offerXlsFile.read())

        self.printer.print("WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK\nSET SCAN OFF\nSET DEFINE OFF")

        for oc in offerYaml['offer_chains']:
            offer = OfferMaker.make_offer(oc)
            self.print_offer(offer)

    def print_offer(self, stmt):
        self.printer.print("DECLARE\nTMP_VAR NUMBER;\nCUR_PRD_ID NUMBER;\nCUR_CAPABILITY_ID NUMBER;\nBEGIN")

        flattened = self.flatten(stmt)
        for x in flattened:
            for st in x.split("\n"):
                if st == '':
                    continue
                self.printer.print(st.rjust(2))

        self.printer.print("END;\n/")
        self.printer.print("COMMIT;")

    def flatten(self, iterable):
        result = []

        for item in iterable:
            if isinstance(item, (list, tuple)):
                result.extend(self.flatten(item))
            else:
                result.append(item)

        return result


class BaseStmt(object):
    _table = _vals = _cols = None

    def __init__(self, opts):
        self._opts = opts

    def escape(self, val):
        """Escape single-quotes in string

        :str: the string to escape

        :returns: A new string with single quotes escaped
        """
        if isinstance(val, str):
            return val.replace("'", "''")
        return val

    @classmethod
    def create_cols(cls):
        return ('CREATED_BY', 'CREATE_DATE')

    @classmethod
    def get_create_stmts(cls, conf):
        """Default statement creator.  Returns a tuple of insert statements for each object in list of passed objects

        :conf: List of objects to create
        """
        if conf is None:
            return ()

        try:
            if isinstance(conf, (tuple, list)):
                return tuple([cls(i).insert(i) for i in conf])
            else:
                return (cls(conf).insert(conf), )
        except:
            raise

    @classmethod
    def get_remove_stmts(self):
        return "DELETE FROM {table} WHERE offer_chain_id = {id};".format(table=self._table,
                                                                         id=OfferChainStmt.offerChainId)

    @classmethod
    def create_vals(cls):
        return "'%s'" % (cls.current_user(),), 'SYSDATE'

    @classmethod
    def update_vals(cls):
        return cls.create_vals()

    @classmethod
    def update_cols(cls):
        return 'updated_by', 'update_date'

    @classmethod
    def current_user(cls):
        return 'OFFERMAKER'

    def insert(self, data):
        """Return an insert statement

        :kwargs:
          :data: dict of kwargs to use to replace the vals
        """
        repl = dict()
        try:
            for k, v in data.iteritems():
                repl[k] = self.escape(v)
                # don't escape or add single quotes if this is a to_date :\
                if str(v).startswith('to_date'):
                    repl[k] = v
                else:
                    if repl[k] is None:
                        repl[k] = 'NULL'
                    else:
                        repl[k] = "'{0}'".format(v)
        except AttributeError:
            raise

        data = dict(
            table=self._table,
            value_list=", ".join(self._vals),
            column_list=", ".join(self._cols)
        )
        stmt = "INSERT INTO {table} ({column_list}) VALUES ({value_list});".format(**data)
        stmt = stmt.format(**repl)
        return stmt


class OfferMaker(object):
    @classmethod
    def make_offer(cls, oc):
        """Return statements that will create a complete offerchain

        :param: OfferChain
          Offer chain configuration parameters
        """
        return OfferChainStmt.get_create_stmts(oc)


class OfferChainStmt(BaseStmt):
    _table = 'OFFER_CHAIN'
    _cols = ('ID', 'NAME', 'DESCRIPTION', 'ADOPTABILITY_WINDOW_START_DATE', 'ADOPTABILITY_WINDOW_END_DATE',
             'IS_GIFT_CERTIFICATE', 'PRODUCT_URI', 'OFFER_CHAIN_STATUS_ID', 'REVOKE_ENTITLEMENTS', 'VENDOR_SOURCE_ID',
             'BILLING_SOURCE_ID', 'IS_SEAT_LICENSE', 'GROUP_ACCOUNT_TYPE_ID', 'IS_ADDRESS_REQUIRED',
             'AMAZON_APPSTORE_SKU') + BaseStmt.create_cols() + BaseStmt.update_cols()

    @classmethod
    def get_create_stmts(cls, oc):
        """Return statements that will create a complete offerchain.  Iterate down through configuration to create lower level statements

        :param: OfferChain
          Offer chain configuration parameters
        """
        uuid = OfferChainMetaDataStmt.uuid(meta=oc.get('metadata'), elig=oc.get('eligibility'), oc=oc)

        if not oc.get('id'):
            oc['id'] = binascii.crc32(uuid) & 0xffffffff
        cls.offerChainId = oc['id']

        stmts = []
        stmts.append('BEGIN')
        stmts.append('  SELECT 1 INTO TMP_VAR FROM OFFER_CHAIN WHERE ID = {0} AND ROWNUM <= 1;'.format(oc['id']))
        stmts.append(
            '  UPDATE OFFER_CHAIN SET NAME=\'{name}\', DESCRIPTION=\'{description}\', PRODUCT_URI=\'{product_uri}\', VENDOR_SOURCE_ID=\'{vendor_source_id}\', BILLING_SOURCE_ID=(SELECT ID FROM BILLING_SOURCE BS WHERE BS.NAME=\'{billing_source}\'), IS_SEAT_LICENSE={is_seat_license}, GROUP_ACCOUNT_TYPE_ID=\'{group_account_type_id}\',IS_ADDRESS_REQUIRED={is_address_required}, OFFER_CHAIN_STATUS_ID = 1, UPDATE_DATE = SYSDATE, UPDATED_BY = \'OFFERMAKER\', IS_GIFT_CERTIFICATE=\'{gift_cert}\', REVOKE_ENTITLEMENTS = \'{revoke}\', ADOPTABILITY_WINDOW_START_DATE = {start_date}, ADOPTABILITY_WINDOW_END_DATE = {end_date}, AMAZON_APPSTORE_SKU={amazon_appstore_sku} WHERE ID = {id};'.format(
                name=oc['name'],
                description=oc['description'],
                product_uri=oc['product_uri'] if oc['product_uri'] is not None else '',
                gift_cert=oc['gift_certificate'],
                id=oc['id'],
                revoke=oc['revoke_entitlements'],
                vendor_source_id=oc['vendor_source_id'],
                billing_source=oc['billing_source'],
                is_seat_license=1 if oc['group_account_type_id'] == 'IL' else 0,
                group_account_type_id=oc['group_account_type_id'],
                is_address_required=oc['is_address_required'],
                start_date=oc['start_date'],
                end_date=oc['end_date'],
                amazon_appstore_sku='\'{0}\''.format(oc['amazon_appstore_sku']) if oc['amazon_appstore_sku'] else 'NULL'
            )
        )
        stmts.append('EXCEPTION')
        stmts.append('  WHEN NO_DATA_FOUND THEN')
        stmts.append('    {0}'.format(super(OfferChainStmt, cls).get_create_stmts(oc)[0]))
        stmts.append('END;')

        return tuple([stmts,
                      OfferChainEligibilityStmt.get_remove_stmts(),
                      OfferChainEligibilityStmt.get_create_stmts(oc.get('eligibility')),
                      OfferChainMetaDataStmt.get_remove_stmts(),
                      OfferChainMetaDataStmt.get_create_stmts(meta=oc.get('metadata'), elig=oc.get('eligibility'),
                                                              oc=oc),
                      OfferChainNotificationStmt.get_remove_stmts(),
                      OfferChainNotificationStmt.get_create_stmts(oc.get('notifications')),
                      tuple([OfferOfferChainStmt.get_create_stmts(o) for o in oc.get('offerings')])
        ])

    @property
    def _vals(self):
        return (
                   self._id, '{name}', '{description}', '{start_date}', '{end_date}', '{gift_certificate}',
                   '{product_uri}',
                   '{status}', '{revoke_entitlements}', '{vendor_source_id}',
                   '(SELECT ID FROM BILLING_SOURCE BS WHERE BS.NAME={billing_source})',
                   'decode({group_account_type_id},\'IL\',1,0)', '{group_account_type_id}', '{is_address_required}',
                   '{amazon_appstore_sku}') + BaseStmt.create_vals() + BaseStmt.update_vals()

    @property
    def _id(self):
        return str(self._opts.get('id', 'OC_ID_SEQ.NEXTVAL'))


class OfferChainEligibilityStmt(BaseStmt):
    _table = 'OFFER_CHAIN_ELIGIBILITY'
    _cols = ('ID', 'OFFER_CHAIN_ID', 'NAME', 'VALUE') + BaseStmt.create_cols()

    def insert(self, data):
        """Return an insert statement

        :kwargs:
          :data: dict of kwargs to use to replace the vals
        """
        if data.get('value') in (None, ''):
            return ''
        return super(OfferChainEligibilityStmt, self).insert(data)

    @property
    def _vals(self):
        return ('ELG_ID_SEQ.NEXTVAL', str(OfferChainStmt.offerChainId), '{key}', '{value}') + BaseStmt.create_vals()


class OfferChainMetaDataStmt(BaseStmt):
    _table = 'OFFER_CHAIN_META_DATA'
    _cols = ('ID', 'OFFER_CHAIN_ID', 'NAME', 'VALUE') + BaseStmt.create_cols()

    def insert(self, data):
        """Return an insert statement

        :kwargs:
          :data: dict of kwargs to use to replace the vals
        """
        if data.get('value') in (None, ''):
            return ''
        return super(OfferChainMetaDataStmt, self).insert(data)

    @property
    def _vals(self):
        return ('OCMD_ID_SEQ.NEXTVAL', str(OfferChainStmt.offerChainId), '{key}', '{value}') + BaseStmt.create_vals()

    @classmethod
    def get_create_stmts(cls, **kwargs):
        kwargs['meta'].append({'key': 'UID', 'value': cls.uuid(**kwargs)})
        return super(cls, OfferChainMetaDataStmt).get_create_stmts(kwargs['meta'])

    @classmethod
    def unique_pairs(cls, **kwargs):
        unique_pairs = set()
        # Get a set of values that describe this offerchain.  We will generate a unique key from this
        if kwargs.get('meta'):
            [unique_pairs.add(('meta', i['key'], i['value'])) for i in kwargs['meta']]
        if kwargs.get('elig'):
            [unique_pairs.add(('elig', i['key'], i['value'])) for i in kwargs['elig']]
        if kwargs.get('notifications'):
            [unique_pairs.add(('notify', i['key'], i['value'])) for i in kwargs['notifications']]
        if kwargs.get('oc'):
            [unique_pairs.add(('oc', k, v)) for k, v in kwargs['oc'].iteritems() if
             k not in ('eligibility', 'offerings', 'metadata', 'id', 'notifications')]
        if kwargs.get('oc').get('offerings'):
            offerings = kwargs['oc']['offerings']
            for offer in offerings:
                for offer_key, offer_value in offer.iteritems():
                    if offer_key != 'products':
                        unique_pairs.add(('o', offer_key, offer_value))
                    else:
                        products = offer['products']
                        [unique_pairs.add(('p', prod_key, prod_value)) for product in products for prod_key, prod_value
                         in product.iteritems() if prod_key not in ('metadata')]
        return unique_pairs

    @classmethod
    def uuid(cls, **kwargs):
        unique_pairs = cls.unique_pairs(**kwargs)
        return sha256(str(unique_pairs)).hexdigest()


class OfferChainNotificationStmt(BaseStmt):
    _table = 'OFFER_CHAIN_NOTIFICATION_TYPE'
    _cols = ('ID', 'OFFER_CHAIN_ID', 'NOTIFICATION_TYPE_ID', 'ACTION_ID') + BaseStmt.create_cols()

    @classmethod
    def get_create_stmts(cls, conf):
        """Create stmts for the notifications.  Ensure that the foreign key values exist as well.  Create if need be.
        """
        stmts = []
        if conf is None:
            return stmts

        for c in conf:
            stmts.append("BEGIN")
            stmts.append("  SELECT 1 INTO TMP_VAR FROM ACTION WHERE NAME = '{NAME}';".format(NAME=c['action']))
            stmts.append("EXCEPTION")
            stmts.append("  WHEN NO_DATA_FOUND THEN")
            stmts.append(
                "    INSERT INTO ACTION (ID, NAME, CREATE_DATE, CREATED_BY) VALUES (ACTION_ID_SEQ.NEXTVAL, '{NAME}', SYSDATE, '{USER}');".format(
                    NAME=c['action'], USER=cls.current_user()))
            stmts.append("END;")

            stmts.append("BEGIN")
            stmts.append("  SELECT 1 INTO TMP_VAR FROM CORE_OWNER.NOTIFICATION_TYPE WHERE VALUE = '{TYPE}';".format(
                TYPE=c['type']))
            stmts.append("EXCEPTION")
            stmts.append("  WHEN NO_DATA_FOUND THEN NULL;")
            stmts.append(
                "    INSERT INTO CORE_OWNER.NOTIFICATION_TYPE (ID, VALUE, TEMPLATE_URL) "
                "VALUES (CORE_OWNER.NOTTID_SEQ.NEXTVAL, '{TYPE}', 'N/A');"
                .format(TYPE=c['type']))
            stmts.append("END;")

        stmts.append(super(OfferChainNotificationStmt, cls).get_create_stmts(conf))
        return stmts

    @property
    def _vals(self):
        return ('OCET_ID_SEQ.NEXTVAL', str(OfferChainStmt.offerChainId),
                '(SELECT ID FROM CORE_OWNER.NOTIFICATION_TYPE WHERE VALUE = {type})',
                '(SELECT ID FROM ACTION WHERE NAME = {action})') + BaseStmt.create_vals()


class OfferStmt(BaseStmt):
    _table = 'OFFER'
    _cols = ('ID', 'OFFER_STATUS_ID', 'ENTITLEMENT_DURATION') + BaseStmt.create_cols() + BaseStmt.update_cols()

    @classmethod
    def get_create_stmts(cls, conf):
        DiscountStmt.add_auto_discounts(Decimal(conf.get('price')), conf.get('products'))
        return (
            super(OfferStmt, cls).get_create_stmts(conf),
            ProductOfferingStmt.get_create_stmts(conf.get('products'), offer=conf)
        )

    @property
    def _vals(self):
        return ('OFR_ID_SEQ.NEXTVAL', '1',
                "'P0Y0M{0}DT0H0M'".format(self._opts['duration'])) + BaseStmt.create_vals() + BaseStmt.update_vals()


class OfferOfferChainStmt(BaseStmt):
    _table = 'OFFER_OFFER_CHAIN'
    _cols = ('OFFER_ID', 'OFFER_CHAIN_ID', 'INDEX_VALUE',
             'NUM_RECURRENCES') + BaseStmt.create_cols() + BaseStmt.update_cols()

    @property
    def _vals(self):
        return ('OFR_ID_SEQ.CURRVAL', str(OfferChainStmt.offerChainId), '{index}',
                '{recurrences}') + BaseStmt.create_vals() + BaseStmt.update_vals()

    @classmethod
    def get_create_stmts(cls, conf):
        stmts = [
            "BEGIN",
            "  SELECT 1 INTO TMP_VAR FROM OFFER_OFFER_CHAIN WHERE OFFER_CHAIN_ID = {0} AND INDEX_VALUE = {1} AND ROWNUM <= 1;"
            .format(OfferChainStmt.offerChainId, conf['index']),
            "EXCEPTION",
            "  WHEN NO_DATA_FOUND THEN",
            OfferStmt.get_create_stmts(conf),
            super(OfferOfferChainStmt, cls).get_create_stmts(conf),
            "END;"
        ]
        return tuple(stmts)


class ProductStmt(BaseStmt):
    _table = 'PRODUCT'
    _cols = ('ID', 'NAME') + BaseStmt.create_cols()
    _vals = ('PRD_ID_SEQ.NEXTVAL', '{name}') + BaseStmt.create_vals()

    @classmethod
    def get_create_stmts(cls, opts):
        stmt = [
            "BEGIN",
            "  SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = '{0}' AND ROWNUM <= 1;"
            .format(opts['name']),
            "EXCEPTION",
            "  WHEN NO_DATA_FOUND THEN",
            "    {0}".format(super(ProductStmt, cls).get_create_stmts(opts)[0]),
            "    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = '{0}' AND ROWNUM <= 1;"
            .format(opts['name']),
            "  WHEN OTHERS THEN",
            "    RAISE;",
            "END;"
        ]
        return tuple(stmt)


class ProductOfferingStmt(BaseStmt):
    _table = 'PRODUCT_OFFERING'
    _cols = ('ID', 'PRODUCT_ID', 'TAX_POLICY_TYPE_ID', 'QUANTITY', 'UNIT_PRICE') + BaseStmt.create_cols()

    @property
    def _vals(self):
        return ('PO_ID_SEQ.NEXTVAL', 'CUR_PRD_ID', '{tax_policy_type_id}', '{quantity}',
                '{unit_price}') + BaseStmt.create_vals()

    @property
    def _prd_id(self):
        return 'PRD_ID_SEQ.CURRVAL' if self._opts.get('new') \
            else "(SELECT ID FROM PRODUCT WHERE NAME = '{0}' AND ROWNUM <= 1)" \
            .format(self._opts['name'])

    @classmethod
    def get_create_stmts(cls, conf, **kwargs):
        stmts = []
        for p in conf:
            product_stmts = [
                ProductStmt.get_create_stmts(p),
                super(ProductOfferingStmt, cls).get_create_stmts(p),
                OfferProductOfferingStmt.get_create_stmts(p),
                tuple([DiscountStmt.get_create_stmts(d) for d in p.get('discounts', tuple())])
            ]
            stmts.append(product_stmts)
        return tuple(stmts)


class OfferProductOfferingStmt(BaseStmt):
    _table = 'OFFER_PRODUCT_OFFERING'
    _cols = ('OFFER_ID', 'PRODUCT_OFFERING_ID') + BaseStmt.create_cols()
    _vals = ('OFR_ID_SEQ.CURRVAL', 'PO_ID_SEQ.CURRVAL') + BaseStmt.create_vals()


class DiscountStmt(BaseStmt):
    _table = 'DISCOUNT'
    _cols = ('ID', 'NAME', 'DESCRIPTION', 'FIXED_AMOUNT', 'PERCENT_AMOUNT', 'DISCOUNT_TYPE_ID') + BaseStmt.create_cols()
    _vals = ('DSC_ID_SEQ.NEXTVAL', '{name}', '{description}', '{fixed}', '{percent}', '1') + BaseStmt.create_vals()

    @classmethod
    def get_create_stmts(cls, conf):
        for k, v in conf.iteritems():
            if k in ('fixed', 'percent'):
                if v is None:
                    conf[k] = 0
        return \
            super(DiscountStmt, cls).get_create_stmts(conf), \
            DiscountProductOfferingStmt.get_create_stmts(conf)

    @classmethod
    def add_auto_discounts(cls, target_price, products):

        target_price = target_price

        for product in products:
            product['product_offering_price'] = Decimal(product.get('unit_price')) * product.get('quantity')

        full_price = sum([product.get('product_offering_price') for product in products])

        if full_price == 0:
            return tuple()

        percent_discount = (full_price - target_price) / full_price

        # Note: Due to "mysterious" bug in offer price calculate, round fixed_discount to 2 decimal places.
        #       Allow one discount to be massaged by a single penny to allow total offer price to end in .99.
        #       Without this, display price for offers can be "$0.99" but Invoices will be billed at "$1.00"
        for product in products:
            product['fixed_discount'] = Decimal(product.get('product_offering_price') * percent_discount) \
                .quantize(Decimal('.01'))

        computed_price = sum([product['product_offering_price'] - product['fixed_discount'] for product in products])

        if not DiscountStmt.compare(computed_price, target_price, .001):
            difference = computed_price - target_price
            DiscountStmt.adjust_first_discount(products, difference)

        computed_price = sum([product['product_offering_price'] - product['fixed_discount'] for product in products])

        if not DiscountStmt.compare(computed_price, target_price, .001):
            raise ValueError('Expected: {}, Computed: {}'.format(target_price, computed_price))

        for product in products:
            if product['fixed_discount'] != 0:

                # NOTE: Description field size in DB is very tiny
                description = 'Off: {offer_target}.' \
                              ' P.Disc: {product_discounted}.' \
                              ' P.Full: {product_full}' \
                    .format(offer_target=target_price,
                            offer_full=full_price,
                            product_discounted=product['product_offering_price'] - product['fixed_discount'],
                            product_full=product['product_offering_price'])

                product.setdefault('discounts', []).append(
                    dict(
                        name='Discount',
                        description=description,
                        percent=0,
                        fixed=str(product['fixed_discount'])
                    )
                )

    @staticmethod
    def adjust_first_discount(products, adjustment_amount):
        for product in products:
            if product['fixed_discount'] != 0:
                product['fixed_discount'] += adjustment_amount
                return

    @staticmethod
    def compare(a, b, threshold):
        return abs(a - b) < threshold


class DiscountProductOfferingStmt(BaseStmt):
    _table = 'DISCOUNT_PRODUCT_OFFERING'
    _cols = ('DISCOUNT_ID', 'PRODUCT_OFFERING_ID') + BaseStmt.create_cols()
    _vals = ('DSC_ID_SEQ.CURRVAL', 'PO_ID_SEQ.CURRVAL') + BaseStmt.create_vals()


if __name__ == '__main__':
    getcontext().prec = 6
    m = Maker()
    m.main()
