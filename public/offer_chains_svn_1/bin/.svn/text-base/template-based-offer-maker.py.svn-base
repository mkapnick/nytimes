from __future__ import with_statement
from __future__ import print_function


import sys
import os
import string

sys.path.append(os.path.join(os.path.realpath(os.path.dirname(sys.argv[0])), '..', 'lib'))


import yaml
import binascii
import airspeed
from decimal import Decimal, InvalidOperation
from hashlib import sha256


class Printer(object):
    def print(self, msg):
        if msg.strip() == "I":
            pass
        print(msg)


class Maker(object):
    printer = Printer()

    def addOfferChainType(self, offerChain):
        for metadata in offerChain['metadata']:
            if metadata['key'] == 'IS_COMP' and metadata['value'] == '1':
                offerChain['type'] = 'COMP'
                return
            elif metadata['key'] == 'SUBSCRIBER_TYPE' and metadata['value'].upper() in ['APPLE', 'KINDLE', 'KINDLE_FIRE']:
                offerChain['type'] = 'BILL_EXTERNAL'
                return
        offerChain['type'] = 'BILL_INTERNAL'

    def generateBundle(self, offerChain):
        offering = offerChain['offerings'][-1]
        products = offering['products']
        first = True

        name = ''
        nameRegex = ''
        totalProductsUnitPrice = 0

        for product in products:
            if not first:
                nameRegex += '|'
                name += ','
            nameRegex += product['name'] + ',?'
            name += product['name']
            first = False

            totalProductsUnitPrice += float(product['unit_price'])

        nameRegex = '(' + nameRegex + '){' + str(len(products)) + '}'

        bundle = dict(
            name_regex=nameRegex,
            name=name,
            price=offering['price'],
            unit_price=totalProductsUnitPrice,
            products=products)
        offerChain['bundle'] = bundle

    def calculatePricesAndDiscountsAndAllocations(self, offerChain):
        bundlePrice = float(offerChain['bundle']['price'])
        bundleUnitPrice = offerChain['bundle']['unit_price']
        for offering in offerChain['offerings']:
            products = offering['products']

            productsTotalPrice = 0
            for product in products:
                productFullPrice = float(product['unit_price']) * product['quantity']
                product['full_price'] = productFullPrice
                productsTotalPrice += productFullPrice

            if productsTotalPrice > 0:
                relativeDiscount = (productsTotalPrice - bundlePrice) / productsTotalPrice

                for product in products:
                    productFullPrice = product['full_price']
                    product['allocation'] = round((1 - (bundleUnitPrice - float(product['unit_price'])) / bundleUnitPrice) * 100, 2)
                    product['fixed_discount'] = round(product['full_price'] * relativeDiscount, 2)
                    product['discount_text'] = "Target offer price %(bundlePrice)s " \
                                               "given offer total price %(productsTotalPrice)s " \
                                               "and product price %(productFullPrice)s" % locals()
            else:
                for product in products:
                    product['allocation'] = 0



    def main(self):
        with open(sys.argv[1]) as offerYamlFile:
            offerYaml = yaml.load(offerYamlFile.read())

        offerChains = offerYaml['offer_chains']

        for offerChain in offerChains:
            assert offerChain.get('id'), 'offer chain id must always be present'
            self.addOfferChainType(offerChain)
            self.generateBundle(offerChain)
            self.calculatePricesAndDiscountsAndAllocations(offerChain)

        with open(sys.argv[2]) as templateFile:
            template = airspeed.Template(templateFile.read())

        print (template.merge(locals()))


if __name__ == '__main__':

    m = Maker()
    m.main()