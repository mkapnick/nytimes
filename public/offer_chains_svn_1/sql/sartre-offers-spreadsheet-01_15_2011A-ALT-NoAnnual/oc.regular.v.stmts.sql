WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK
SET SCAN OFF
SET DEFINE OFF

DECLARE
  CUR_PRD_ID NUMBER;
BEGIN
  INSERT INTO OFFER_CHAIN (ID, NAME, DESCRIPTION, ADOPTABILITY_WINDOW_START_DATE, ADOPTABILITY_WINDOW_END_DATE, IS_GIFT_CERTIFICATE, PRODUCT_URI, OFFER_CHAIN_STATUS_ID, created_by, create_date, updated_by, update_date) VALUES (468963, 'All Digital Access', 'Unlimited access to The New York Times on all your devices, including the web and apps on your computer, smartphone and tablet devices.', '01-JAN-2011', '01-JAN-2099', NULL, NULL, 1, 'chris', SYSDATE, 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_ELIGIBILITY (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (ELG_ID_SEQ.NEXTVAL, 468963, 'IS_COMP', '1', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_ELIGIBILITY (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (ELG_ID_SEQ.NEXTVAL, 468963, 'MAX_CONCURRENT_SUBS', '1', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_ELIGIBILITY (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (ELG_ID_SEQ.NEXTVAL, 468963, 'REQUIRES_EMAIL_DOMAIN', 'nytimes.com', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 468963, 'IS_COMP', '1', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 468963, 'BUNDLE', 'All Digital Access', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 468963, 'SIEBEL_CAMPAIGN_CODE', 'TBD', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 468963, 'OFFER_TYPE', 'Complimentary', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 468963, 'BILLING_CYCLE', 'Monthly', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 468963, 'PRICE_DESCRIPTION', 'Complimentary Access for Employees', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 468963, 'SUBSCRIBER_TYPE', 'Complimentary - Employee', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 468963, 'REFUND_POLICY', 'Complimentary Access: No refund.  Access removed within 6 hours if cancelled.', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 468963, 'BUNDLE_EXPLANATION', 'Web, smartphone and tablet, for NYTCO employees validated by email domain', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 468963, 'UID', 'c65ef7a6010cd2f18749febf5c534b5a88bebbe73a26b32c9d7d5ca6194be7f8', 'chris', SYSDATE);
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
  INSERT INTO OFFER_OFFER_CHAIN (OFFER_ID, OFFER_CHAIN_ID, INDEX_VALUE, NUM_RECURRENCES, created_by, create_date, updated_by, update_date) VALUES (OFR_ID_SEQ.CURRVAL, 468963, '0', '12', 'chris', SYSDATE, 'chris', SYSDATE);
END;
/
EXIT

