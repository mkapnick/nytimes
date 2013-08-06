WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK
SET SCAN OFF
SET DEFINE OFF

DECLARE
  CUR_PRD_ID NUMBER;
BEGIN
  INSERT INTO OFFER_CHAIN (ID, NAME, DESCRIPTION, ADOPTABILITY_WINDOW_START_DATE, ADOPTABILITY_WINDOW_END_DATE, IS_GIFT_CERTIFICATE, PRODUCT_URI, OFFER_CHAIN_STATUS_ID, created_by, create_date, updated_by, update_date) VALUES (446454, 'The New York Times Home Delivery', 'Unlimited access to The New York Times on the web, and access to the full apps on your iPhone, Blackberry or Android-powered phone.', '01-JAN-2011', '01-JAN-2099', NULL, NULL, 1, 'chris', SYSDATE, 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_ELIGIBILITY (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (ELG_ID_SEQ.NEXTVAL, 446454, 'IS_COMP', '1', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_ELIGIBILITY (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (ELG_ID_SEQ.NEXTVAL, 446454, 'MAX_CONCURRENT_SUBS', '1', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 446454, 'IS_COMP', '1', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 446454, 'BUNDLE', 'The New York Times Home Delivery', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 446454, 'SIEBEL_CAMPAIGN_CODE', 'TBD', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 446454, 'OFFER_TYPE', 'Complimentary', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 446454, 'BILLING_CYCLE', 'Monthly', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 446454, 'PRICE_DESCRIPTION', 'Complimentary Access for Home Delivery Subscribers', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 446454, 'SUBSCRIBER_TYPE', 'HD', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 446454, 'REFUND_POLICY', 'Complimentary Access: No refund.  Access removed within 6 hours if cancelled.', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 446454, 'BUNDLE_EXPLANATION', 'W+SP+Replica Edition (HD complimentary access)', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 446454, 'CIS_PRD_ID', 'S1', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 446454, 'UID', 'f225c4180dee1f663a84f40331f4ec9387dd58983ed20457fb9c9144688ff1f8', 'chris', SYSDATE);
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
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Web' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, created_by, create_date) VALUES (PRD_ID_SEQ.NEXTVAL, 'Web', NULL, 1, NULL, '0', 'chris', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Web' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, created_by, create_date) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, 1, '28', '0', '2', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/mm/:id:.json', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'capability', 'WEB', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": .2}', 'chris', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
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
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Smartphone' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, created_by, create_date) VALUES (PRD_ID_SEQ.NEXTVAL, 'Smartphone', NULL, 1, NULL, '0', 'chris', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Smartphone' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, created_by, create_date) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, 1, '28', '0', '2', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/msd/:id:.json', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": .2}', 'chris', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Tablet' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, created_by, create_date) VALUES (PRD_ID_SEQ.NEXTVAL, 'Tablet', NULL, 1, NULL, '0', 'chris', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Tablet' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, created_by, create_date) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, 1, '28', '0', '2', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/mtd/:id:.json', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": .2}', 'chris', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Replica' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, created_by, create_date) VALUES (PRD_ID_SEQ.NEXTVAL, 'Replica', NULL, 1, NULL, '0', 'chris', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Replica' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, created_by, create_date) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, 1, '28', '0', '2', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/rpl/:id:.json', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": .2}', 'chris', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Crosswords' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, created_by, create_date) VALUES (PRD_ID_SEQ.NEXTVAL, 'Crosswords', NULL, 1, NULL, '0', 'chris', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Crosswords' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, created_by, create_date) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, 1, '28', '0', '2', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/crosswords/:id:.json', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'capability', 'XWD', 'chris', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  INSERT INTO OFFER_OFFER_CHAIN (OFFER_ID, OFFER_CHAIN_ID, INDEX_VALUE, NUM_RECURRENCES, created_by, create_date, updated_by, update_date) VALUES (OFR_ID_SEQ.CURRVAL, 446454, '0', '-1', 'chris', SYSDATE, 'chris', SYSDATE);
END;
/
EXIT

