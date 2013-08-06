WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK
SET SCAN OFF
SET DEFINE OFF

DECLARE
  CUR_PRD_ID NUMBER;
BEGIN
  INSERT INTO OFFER_CHAIN (ID, NAME, DESCRIPTION, ADOPTABILITY_WINDOW_START_DATE, ADOPTABILITY_WINDOW_END_DATE, IS_GIFT_CERTIFICATE, PRODUCT_URI, OFFER_CHAIN_STATUS_ID, created_by, create_date, updated_by, update_date) VALUES (228761, 'NYTimes: Web+Smartphone', 'Unlimited access to The New York Times on the web, and access to the full apps on your iPhone, Blackberry or Android-powered phone.', '01-JAN-2011', '01-JAN-2099', NULL, NULL, 1, 'chris', SYSDATE, 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_ELIGIBILITY (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (ELG_ID_SEQ.NEXTVAL, 228761, 'IS_COMP', '0', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_ELIGIBILITY (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (ELG_ID_SEQ.NEXTVAL, 228761, 'MAX_CONCURRENT_SUBS', '1', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_ELIGIBILITY (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (ELG_ID_SEQ.NEXTVAL, 228761, 'REQUIRES_EMAIL_DOMAIN', '.edu', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 228761, 'IS_COMP', '0', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 228761, 'BUNDLE', 'NYTimes: Web+Smartphone', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 228761, 'SIEBEL_CAMPAIGN_CODE', 'TBD', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 228761, 'OFFER_TYPE', '25% OFF for the Year', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 228761, 'BILLING_CYCLE', 'Monthly', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 228761, 'PRICE_DESCRIPTION', '25% OFF EDU lOffer US = $15.00 every 4 weeks', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 228761, 'SUBSCRIBER_TYPE', 'Regular', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 228761, 'REFUND_POLICY', 'Monthly Billing: No refund.  Users will maintain access for the remainder of the billing period.  Users will not be billed in the next billing cycle.', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 228761, 'BUNDLE_EXPLANATION', 'W+SP (EDU Tier 3 readership 25% discounted offer)', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 228761, 'UID', '483e4614c708616a8836d74e97237473deb9e71cd7bc0c65126a9af108325fdf', 'chris', SYSDATE);
  INSERT INTO OFFER (ID, OFFER_STATUS_ID, ENTITLEMENT_DURATION, created_by, create_date, updated_by, update_date) VALUES (OFR_ID_SEQ.NEXTVAL, 1, 'P0Y0M28DT0H0M', 'chris', SYSDATE, 'chris', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'TimesMachine' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, created_by, create_date) VALUES (PRD_ID_SEQ.NEXTVAL, 'TimesMachine', NULL, 1, NULL, '0', 'chris', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'TimesMachine' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, created_by, create_date) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, 1, '100', '0', '2', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/mm/:id:.json', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": .2}', 'chris', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  INSERT INTO DISCOUNT (ID, NAME, DESCRIPTION, FIXED_AMOUNT, PERCENT_AMOUNT, DISCOUNT_TYPE_ID, created_by, create_date) VALUES (DSC_ID_SEQ.NEXTVAL, 'Auto Discount', 'Automatically generated to target price 15 given base price 16.24', NULL, '92.3645320197', 1, 'chris', SYSDATE);
  INSERT INTO DISCOUNT_PRODUCT_OFFERING (DISCOUNT_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (DSC_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Web' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, created_by, create_date) VALUES (PRD_ID_SEQ.NEXTVAL, 'Web', NULL, 1, NULL, '0.33', 'chris', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Web' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, created_by, create_date) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, 1, '28', '0.33', '2', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/mm/:id:.json', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'capability', 'WEB', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": .2}', 'chris', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  INSERT INTO DISCOUNT (ID, NAME, DESCRIPTION, FIXED_AMOUNT, PERCENT_AMOUNT, DISCOUNT_TYPE_ID, created_by, create_date) VALUES (DSC_ID_SEQ.NEXTVAL, 'Auto Discount', 'Automatically generated to target price 15 given base price 16.24', NULL, '92.3645320197', 1, 'chris', SYSDATE);
  INSERT INTO DISCOUNT_PRODUCT_OFFERING (DISCOUNT_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (DSC_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Archive Article' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, created_by, create_date) VALUES (PRD_ID_SEQ.NEXTVAL, 'Archive Article', NULL, 1, NULL, '0', 'chris', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Archive Article' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, created_by, create_date) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, 1, '100', '0', '2', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/archive/size/100/:id:.json', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'capability', 'AAA', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": .2}', 'chris', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  INSERT INTO DISCOUNT (ID, NAME, DESCRIPTION, FIXED_AMOUNT, PERCENT_AMOUNT, DISCOUNT_TYPE_ID, created_by, create_date) VALUES (DSC_ID_SEQ.NEXTVAL, 'Auto Discount', 'Automatically generated to target price 15 given base price 16.24', NULL, '92.3645320197', 1, 'chris', SYSDATE);
  INSERT INTO DISCOUNT_PRODUCT_OFFERING (DISCOUNT_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (DSC_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Mobile' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, created_by, create_date) VALUES (PRD_ID_SEQ.NEXTVAL, 'Mobile', NULL, 1, NULL, '0', 'chris', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Mobile' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, created_by, create_date) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, 1, '28', '0', '2', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/mow/:id:.json', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": .2}', 'chris', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  INSERT INTO DISCOUNT (ID, NAME, DESCRIPTION, FIXED_AMOUNT, PERCENT_AMOUNT, DISCOUNT_TYPE_ID, created_by, create_date) VALUES (DSC_ID_SEQ.NEXTVAL, 'Auto Discount', 'Automatically generated to target price 15 given base price 16.24', NULL, '92.3645320197', 1, 'chris', SYSDATE);
  INSERT INTO DISCOUNT_PRODUCT_OFFERING (DISCOUNT_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (DSC_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Smartphone' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, created_by, create_date) VALUES (PRD_ID_SEQ.NEXTVAL, 'Smartphone', NULL, 1, NULL, '0.25', 'chris', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Smartphone' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, created_by, create_date) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, 1, '28', '0.25', '2', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/msd/:id:.json', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": .2}', 'chris', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  INSERT INTO DISCOUNT (ID, NAME, DESCRIPTION, FIXED_AMOUNT, PERCENT_AMOUNT, DISCOUNT_TYPE_ID, created_by, create_date) VALUES (DSC_ID_SEQ.NEXTVAL, 'Auto Discount', 'Automatically generated to target price 15 given base price 16.24', NULL, '92.3645320197', 1, 'chris', SYSDATE);
  INSERT INTO DISCOUNT_PRODUCT_OFFERING (DISCOUNT_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (DSC_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  INSERT INTO OFFER_OFFER_CHAIN (OFFER_ID, OFFER_CHAIN_ID, INDEX_VALUE, NUM_RECURRENCES, created_by, create_date, updated_by, update_date) VALUES (OFR_ID_SEQ.CURRVAL, 228761, '0', '12', 'chris', SYSDATE, 'chris', SYSDATE);
END;
/
EXIT
