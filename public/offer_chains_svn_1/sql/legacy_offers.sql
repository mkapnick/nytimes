WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK
SET SCAN OFF
SET DEFINE OFF

DECLARE
  TMP_VAR NUMBER;
  CUR_PRD_ID NUMBER;
BEGIN
  BEGIN
    SELECT 1 INTO TMP_VAR FROM OFFER_CHAIN WHERE ID = 100001 AND ROWNUM <= 1;
    UPDATE OFFER_CHAIN SET NAME='Gift Subscription to Crosswords - Annual', DESCRIPTION='Purchase an Annual Crosswords gift subscription', PRODUCT_URI='', UPDATE_DATE = SYSDATE, UPDATED_BY = 'OFFERMAKER' WHERE ID = 100001;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO OFFER_CHAIN (ID, NAME, DESCRIPTION, ADOPTABILITY_WINDOW_START_DATE, ADOPTABILITY_WINDOW_END_DATE, IS_GIFT_CERTIFICATE, PRODUCT_URI, OFFER_CHAIN_STATUS_ID, created_by, create_date, updated_by, update_date) VALUES (100001, 'Gift Subscription to Crosswords - Annual', 'Purchase an Annual Crosswords gift subscription', '29-OCT-2010', '29-OCT-2110', '1', NULL, '1', 'chris', SYSDATE, 'chris', SYSDATE);
  END;
  DELETE FROM OFFER_CHAIN_ELIGIBILITY WHERE offer_chain_id = 100001;
  INSERT INTO OFFER_CHAIN_ELIGIBILITY (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (ELG_ID_SEQ.NEXTVAL, 100001, 'IS_COMP', '0', 'chris', SYSDATE);
  DELETE FROM OFFER_CHAIN_META_DATA WHERE offer_chain_id = 100001;
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100001, 'IS_COMP', '0', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100001, 'redemption offer chain id', '100002', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100001, 'UID', '091cece68e70908ebd43d4bcdb8b9e0fc1853dc3773e625e4c4bcda0f9db84c2', 'chris', SYSDATE);
  BEGIN
    SELECT 1 INTO TMP_VAR FROM OFFER_OFFER_CHAIN WHERE OFFER_CHAIN_ID = 100001 AND INDEX_VALUE = 0 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
  INSERT INTO OFFER (ID, OFFER_STATUS_ID, ENTITLEMENT_DURATION, created_by, create_date, updated_by, update_date) VALUES (OFR_ID_SEQ.NEXTVAL, 1, 'P0Y0M365DT0H0M', 'chris', SYSDATE, 'chris', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Crosswords' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, created_by, create_date) VALUES (PRD_ID_SEQ.NEXTVAL, 'Crosswords', '0', 1, NULL, '0.24', 'chris', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Crosswords' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, created_by, create_date) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, 1, '365', '0.24', '2', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/crosswords/:id:.json', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'capability', 'XWD', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": 0.0}', 'chris', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  INSERT INTO DISCOUNT (ID, NAME, DESCRIPTION, FIXED_AMOUNT, PERCENT_AMOUNT, DISCOUNT_TYPE_ID, created_by, create_date) VALUES (DSC_ID_SEQ.NEXTVAL, 'Auto Discount', 'Automatically generated to target price 39.95 given base price 87.6', '0', '54.3949771689', 1, 'chris', SYSDATE);
  INSERT INTO DISCOUNT_PRODUCT_OFFERING (DISCOUNT_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (DSC_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  INSERT INTO OFFER_OFFER_CHAIN (OFFER_ID, OFFER_CHAIN_ID, INDEX_VALUE, NUM_RECURRENCES, created_by, create_date, updated_by, update_date) VALUES (OFR_ID_SEQ.CURRVAL, 100001, '0', '1', 'chris', SYSDATE, 'chris', SYSDATE);
  END;
  BEGIN
    SELECT 1 INTO TMP_VAR FROM OFFER_CHAIN WHERE ID = 100002 AND ROWNUM <= 1;
    UPDATE OFFER_CHAIN SET NAME='Redeem Gift Subscription to Crosswords - Annual', DESCRIPTION='Redeem an Annual Crosswords gift subscription', PRODUCT_URI='', UPDATE_DATE = SYSDATE, UPDATED_BY = 'OFFERMAKER' WHERE ID = 100002;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO OFFER_CHAIN (ID, NAME, DESCRIPTION, ADOPTABILITY_WINDOW_START_DATE, ADOPTABILITY_WINDOW_END_DATE, IS_GIFT_CERTIFICATE, PRODUCT_URI, OFFER_CHAIN_STATUS_ID, created_by, create_date, updated_by, update_date) VALUES (100002, 'Redeem Gift Subscription to Crosswords - Annual', 'Redeem an Annual Crosswords gift subscription', '29-OCT-2010', '29-OCT-2110', '0', NULL, '1', 'chris', SYSDATE, 'chris', SYSDATE);
  END;
  DELETE FROM OFFER_CHAIN_ELIGIBILITY WHERE offer_chain_id = 100002;
  INSERT INTO OFFER_CHAIN_ELIGIBILITY (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (ELG_ID_SEQ.NEXTVAL, 100002, 'gift certificate required', 'True', 'chris', SYSDATE);
  DELETE FROM OFFER_CHAIN_META_DATA WHERE offer_chain_id = 100002;
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100002, 'IS_COMP', '0', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100002, 'UID', '834b4a19d27d4c014befe406148f98e5a8b7dc917ea74929a0ac0cf54daec25d', 'chris', SYSDATE);
  BEGIN
    SELECT 1 INTO TMP_VAR FROM OFFER_OFFER_CHAIN WHERE OFFER_CHAIN_ID = 100002 AND INDEX_VALUE = 0 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
  INSERT INTO OFFER (ID, OFFER_STATUS_ID, ENTITLEMENT_DURATION, created_by, create_date, updated_by, update_date) VALUES (OFR_ID_SEQ.NEXTVAL, 1, 'P0Y0M365DT0H0M', 'chris', SYSDATE, 'chris', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Crosswords' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, created_by, create_date) VALUES (PRD_ID_SEQ.NEXTVAL, 'Crosswords', '0', 1, NULL, '0.24', 'chris', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Crosswords' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, created_by, create_date) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, 1, '365', '0.24', '2', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/crosswords/:id:.json', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'capability', 'XWD', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": 0.0}', 'chris', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  INSERT INTO DISCOUNT (ID, NAME, DESCRIPTION, FIXED_AMOUNT, PERCENT_AMOUNT, DISCOUNT_TYPE_ID, created_by, create_date) VALUES (DSC_ID_SEQ.NEXTVAL, 'Auto Discount', 'Automatically generated to target price 39.95 given base price 87.6', '0', '54.3949771689', 1, 'chris', SYSDATE);
  INSERT INTO DISCOUNT_PRODUCT_OFFERING (DISCOUNT_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (DSC_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  INSERT INTO OFFER_OFFER_CHAIN (OFFER_ID, OFFER_CHAIN_ID, INDEX_VALUE, NUM_RECURRENCES, created_by, create_date, updated_by, update_date) VALUES (OFR_ID_SEQ.CURRVAL, 100002, '0', '1', 'chris', SYSDATE, 'chris', SYSDATE);
  END;
  BEGIN
    SELECT 1 INTO TMP_VAR FROM OFFER_CHAIN WHERE ID = 100201 AND ROWNUM <= 1;
    UPDATE OFFER_CHAIN SET NAME='Crosswords - Annual', DESCRIPTION='Subscription to Crosswords', PRODUCT_URI='', UPDATE_DATE = SYSDATE, UPDATED_BY = 'OFFERMAKER' WHERE ID = 100201;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO OFFER_CHAIN (ID, NAME, DESCRIPTION, ADOPTABILITY_WINDOW_START_DATE, ADOPTABILITY_WINDOW_END_DATE, IS_GIFT_CERTIFICATE, PRODUCT_URI, OFFER_CHAIN_STATUS_ID, created_by, create_date, updated_by, update_date) VALUES (100201, 'Crosswords - Annual', 'Subscription to Crosswords', '29-OCT-2010', '29-OCT-2110', '0', NULL, '1', 'chris', SYSDATE, 'chris', SYSDATE);
  END;
  DELETE FROM OFFER_CHAIN_ELIGIBILITY WHERE offer_chain_id = 100201;
  INSERT INTO OFFER_CHAIN_ELIGIBILITY (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (ELG_ID_SEQ.NEXTVAL, 100201, 'IS_COMP', '0', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_ELIGIBILITY (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (ELG_ID_SEQ.NEXTVAL, 100201, 'MAX_CONCURRENT_SUBS', '1', 'chris', SYSDATE);
  DELETE FROM OFFER_CHAIN_META_DATA WHERE offer_chain_id = 100201;
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100201, 'IS_COMP', '0', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100201, 'CANCELABLE', '1', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100201, 'REFUNDABLE', '1', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100201, 'FULL_REFUND_DAYS_LIMIT', '30', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100201, 'PRORATED_REFUND_DAYS_LIMIT', '335', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100201, 'OPEN_TO_ANONYMOUS', '1', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100201, 'UID', '74e1f8cf8426a83a89c0a4a71d3f38936793bf07533955881d7d3147aff24e83', 'chris', SYSDATE);
  BEGIN
    SELECT 1 INTO TMP_VAR FROM OFFER_OFFER_CHAIN WHERE OFFER_CHAIN_ID = 100201 AND INDEX_VALUE = 0 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
  INSERT INTO OFFER (ID, OFFER_STATUS_ID, ENTITLEMENT_DURATION, created_by, create_date, updated_by, update_date) VALUES (OFR_ID_SEQ.NEXTVAL, 1, 'P0Y0M365DT0H0M', 'chris', SYSDATE, 'chris', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Crosswords' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, created_by, create_date) VALUES (PRD_ID_SEQ.NEXTVAL, 'Crosswords', '0', 1, NULL, '0.24', 'chris', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Crosswords' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, created_by, create_date) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, 1, '365', '0.24', '2', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/crosswords/:id:.json', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'capability', 'XWD', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": 0.0}', 'chris', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  INSERT INTO DISCOUNT (ID, NAME, DESCRIPTION, FIXED_AMOUNT, PERCENT_AMOUNT, DISCOUNT_TYPE_ID, created_by, create_date) VALUES (DSC_ID_SEQ.NEXTVAL, 'Auto Discount', 'Automatically generated to target price 39.95 given base price 87.6', '0', '54.3949771689', 1, 'chris', SYSDATE);
  INSERT INTO DISCOUNT_PRODUCT_OFFERING (DISCOUNT_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (DSC_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  INSERT INTO OFFER_OFFER_CHAIN (OFFER_ID, OFFER_CHAIN_ID, INDEX_VALUE, NUM_RECURRENCES, created_by, create_date, updated_by, update_date) VALUES (OFR_ID_SEQ.CURRVAL, 100201, '0', '1', 'chris', SYSDATE, 'chris', SYSDATE);
  END;
  BEGIN
    SELECT 1 INTO TMP_VAR FROM OFFER_CHAIN WHERE ID = 100202 AND ROWNUM <= 1;
    UPDATE OFFER_CHAIN SET NAME='Crosswords - Monthly', DESCRIPTION='Subscription to Crosswords', PRODUCT_URI='', UPDATE_DATE = SYSDATE, UPDATED_BY = 'OFFERMAKER' WHERE ID = 100202;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO OFFER_CHAIN (ID, NAME, DESCRIPTION, ADOPTABILITY_WINDOW_START_DATE, ADOPTABILITY_WINDOW_END_DATE, IS_GIFT_CERTIFICATE, PRODUCT_URI, OFFER_CHAIN_STATUS_ID, created_by, create_date, updated_by, update_date) VALUES (100202, 'Crosswords - Monthly', 'Subscription to Crosswords', '29-OCT-2010', '29-OCT-2110', '0', NULL, '1', 'chris', SYSDATE, 'chris', SYSDATE);
  END;
  DELETE FROM OFFER_CHAIN_ELIGIBILITY WHERE offer_chain_id = 100202;
  INSERT INTO OFFER_CHAIN_ELIGIBILITY (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (ELG_ID_SEQ.NEXTVAL, 100202, 'IS_COMP', '0', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_ELIGIBILITY (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (ELG_ID_SEQ.NEXTVAL, 100202, 'MAX_CONCURRENT_SUBS', '1', 'chris', SYSDATE);
  DELETE FROM OFFER_CHAIN_META_DATA WHERE offer_chain_id = 100202;
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100202, 'IS_COMP', '0', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100202, 'CANCELABLE', '1', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100202, 'REFUNDABLE', '0', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100202, 'OPEN_TO_ANONYMOUS', '1', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100202, 'UID', '025bd4a2b7fcc46eaef49321186bd6cebcca957bf60c63433ba05c7b2ecf5cc6', 'chris', SYSDATE);
  BEGIN
    SELECT 1 INTO TMP_VAR FROM OFFER_OFFER_CHAIN WHERE OFFER_CHAIN_ID = 100202 AND INDEX_VALUE = 0 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
  INSERT INTO OFFER (ID, OFFER_STATUS_ID, ENTITLEMENT_DURATION, created_by, create_date, updated_by, update_date) VALUES (OFR_ID_SEQ.NEXTVAL, 1, 'P0Y0M30DT0H0M', 'chris', SYSDATE, 'chris', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Crosswords' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, created_by, create_date) VALUES (PRD_ID_SEQ.NEXTVAL, 'Crosswords', '0', 1, NULL, '0.24', 'chris', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Crosswords' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, created_by, create_date) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, 1, '365', '0.24', '2', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/crosswords/:id:.json', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'capability', 'XWD', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": 0.0}', 'chris', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  INSERT INTO DISCOUNT (ID, NAME, DESCRIPTION, FIXED_AMOUNT, PERCENT_AMOUNT, DISCOUNT_TYPE_ID, created_by, create_date) VALUES (DSC_ID_SEQ.NEXTVAL, 'Auto Discount', 'Automatically generated to target price 6.95 given base price 87.6', '0', '92.0662100457', 1, 'chris', SYSDATE);
  INSERT INTO DISCOUNT_PRODUCT_OFFERING (DISCOUNT_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (DSC_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  INSERT INTO OFFER_OFFER_CHAIN (OFFER_ID, OFFER_CHAIN_ID, INDEX_VALUE, NUM_RECURRENCES, created_by, create_date, updated_by, update_date) VALUES (OFR_ID_SEQ.CURRVAL, 100202, '0', '1', 'chris', SYSDATE, 'chris', SYSDATE);
  END;
  BEGIN
    SELECT 1 INTO TMP_VAR FROM OFFER_CHAIN WHERE ID = 100101 AND ROWNUM <= 1;
    UPDATE OFFER_CHAIN SET NAME='Single Article', DESCRIPTION='Access a single archive article', PRODUCT_URI='', UPDATE_DATE = SYSDATE, UPDATED_BY = 'OFFERMAKER' WHERE ID = 100101;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO OFFER_CHAIN (ID, NAME, DESCRIPTION, ADOPTABILITY_WINDOW_START_DATE, ADOPTABILITY_WINDOW_END_DATE, IS_GIFT_CERTIFICATE, PRODUCT_URI, OFFER_CHAIN_STATUS_ID, created_by, create_date, updated_by, update_date) VALUES (100101, 'Single Article', 'Access a single archive article', '29-OCT-2010', '29-OCT-2110', '0', NULL, '1', 'chris', SYSDATE, 'chris', SYSDATE);
  END;
  DELETE FROM OFFER_CHAIN_ELIGIBILITY WHERE offer_chain_id = 100101;
  INSERT INTO OFFER_CHAIN_ELIGIBILITY (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (ELG_ID_SEQ.NEXTVAL, 100101, 'IS_COMP', '0', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_ELIGIBILITY (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (ELG_ID_SEQ.NEXTVAL, 100101, 'MAX_CONCURRENT_SUBS', 'UNLIMITED', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_ELIGIBILITY (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (ELG_ID_SEQ.NEXTVAL, 100101, 'requires_unexpired_unused_articles', 'http://:hostname:/svc/user/entitlements/archive_bundle/:id:.json', 'chris', SYSDATE);
  DELETE FROM OFFER_CHAIN_META_DATA WHERE offer_chain_id = 100101;
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100101, 'IS_COMP', '0', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100101, 'CANCELABLE', '0', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100101, 'REFUNDABLE', '0', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100101, 'OPEN_TO_ANONYMOUS', '1', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100101, 'UID', 'b7e00ace8b2332eb19725110a9444c9ca65bd0c85a4c9a1cabfdd5f05261bc36', 'chris', SYSDATE);
  BEGIN
    SELECT 1 INTO TMP_VAR FROM OFFER_OFFER_CHAIN WHERE OFFER_CHAIN_ID = 100101 AND INDEX_VALUE = 0 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
  INSERT INTO OFFER (ID, OFFER_STATUS_ID, ENTITLEMENT_DURATION, created_by, create_date, updated_by, update_date) VALUES (OFR_ID_SEQ.NEXTVAL, 1, 'P0Y0M30DT0H0M', 'chris', SYSDATE, 'chris', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Archive Article' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, created_by, create_date) VALUES (PRD_ID_SEQ.NEXTVAL, 'Archive Article', '0', 1, NULL, '3.95', 'chris', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Archive Article' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, created_by, create_date) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, 1, '1', '3.95', '2', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/archive/size/1/:id:.json', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'capability', 'AAA', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": 0.0}', 'chris', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  INSERT INTO DISCOUNT (ID, NAME, DESCRIPTION, FIXED_AMOUNT, PERCENT_AMOUNT, DISCOUNT_TYPE_ID, created_by, create_date) VALUES (DSC_ID_SEQ.NEXTVAL, 'Auto Discount', 'Automatically generated to target price 3.95 given base price 3.95', '0', '0.0', 1, 'chris', SYSDATE);
  INSERT INTO DISCOUNT_PRODUCT_OFFERING (DISCOUNT_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (DSC_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  INSERT INTO OFFER_OFFER_CHAIN (OFFER_ID, OFFER_CHAIN_ID, INDEX_VALUE, NUM_RECURRENCES, created_by, create_date, updated_by, update_date) VALUES (OFR_ID_SEQ.CURRVAL, 100101, '0', '1', 'chris', SYSDATE, 'chris', SYSDATE);
  END;
  BEGIN
    SELECT 1 INTO TMP_VAR FROM OFFER_CHAIN WHERE ID = 100102 AND ROWNUM <= 1;
    UPDATE OFFER_CHAIN SET NAME='10-Article Pack', DESCRIPTION='10 Pack of Archive article access', PRODUCT_URI='', UPDATE_DATE = SYSDATE, UPDATED_BY = 'OFFERMAKER' WHERE ID = 100102;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO OFFER_CHAIN (ID, NAME, DESCRIPTION, ADOPTABILITY_WINDOW_START_DATE, ADOPTABILITY_WINDOW_END_DATE, IS_GIFT_CERTIFICATE, PRODUCT_URI, OFFER_CHAIN_STATUS_ID, created_by, create_date, updated_by, update_date) VALUES (100102, '10-Article Pack', '10 Pack of Archive article access', '29-OCT-2010', '29-OCT-2110', '0', NULL, '1', 'chris', SYSDATE, 'chris', SYSDATE);
  END;
  DELETE FROM OFFER_CHAIN_ELIGIBILITY WHERE offer_chain_id = 100102;
  INSERT INTO OFFER_CHAIN_ELIGIBILITY (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (ELG_ID_SEQ.NEXTVAL, 100102, 'IS_COMP', '0', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_ELIGIBILITY (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (ELG_ID_SEQ.NEXTVAL, 100102, 'MAX_CONCURRENT_SUBS', 'UNLIMITED', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_ELIGIBILITY (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (ELG_ID_SEQ.NEXTVAL, 100102, 'requires_unexpired_unused_articles', 'http://:hostname:/svc/user/entitlements/archive_bundle/:id:.json', 'chris', SYSDATE);
  DELETE FROM OFFER_CHAIN_META_DATA WHERE offer_chain_id = 100102;
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100102, 'IS_COMP', '0', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100102, 'CANCELABLE', '0', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100102, 'REFUNDABLE', '0', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100102, 'OPEN_TO_ANONYMOUS', '1', 'chris', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, created_by, create_date) VALUES (OCMD_ID_SEQ.NEXTVAL, 100102, 'UID', '2ffc2ed417a6c160d69bebc29d4ea16437896d8c9a5e9804fe0e298915dd4b32', 'chris', SYSDATE);
  BEGIN
    SELECT 1 INTO TMP_VAR FROM OFFER_OFFER_CHAIN WHERE OFFER_CHAIN_ID = 100102 AND INDEX_VALUE = 0 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
  INSERT INTO OFFER (ID, OFFER_STATUS_ID, ENTITLEMENT_DURATION, created_by, create_date, updated_by, update_date) VALUES (OFR_ID_SEQ.NEXTVAL, 1, 'P0Y0M30DT0H0M', 'chris', SYSDATE, 'chris', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Archive Article' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, created_by, create_date) VALUES (PRD_ID_SEQ.NEXTVAL, 'Archive Article', '0', 1, NULL, '3.95', 'chris', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Archive Article' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, created_by, create_date) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, 1, '10', '3.95', '2', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/archive/size/10/:id:.json', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'capability', 'AAA', 'chris', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, created_by, create_date) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": 0.0}', 'chris', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  INSERT INTO DISCOUNT (ID, NAME, DESCRIPTION, FIXED_AMOUNT, PERCENT_AMOUNT, DISCOUNT_TYPE_ID, created_by, create_date) VALUES (DSC_ID_SEQ.NEXTVAL, 'Auto Discount', 'Automatically generated to target price 15.95 given base price 39.5', '0', '59.6202531646', 1, 'chris', SYSDATE);
  INSERT INTO DISCOUNT_PRODUCT_OFFERING (DISCOUNT_ID, PRODUCT_OFFERING_ID, created_by, create_date) VALUES (DSC_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'chris', SYSDATE);
  INSERT INTO OFFER_OFFER_CHAIN (OFFER_ID, OFFER_CHAIN_ID, INDEX_VALUE, NUM_RECURRENCES, created_by, create_date, updated_by, update_date) VALUES (OFR_ID_SEQ.CURRVAL, 100102, '0', '1', 'chris', SYSDATE, 'chris', SYSDATE);
  END;
END;
/
EXIT

