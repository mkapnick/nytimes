WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK
SET SCAN OFF
SET DEFINE OFF


DECLARE
  TMP_VAR NUMBER;
  CUR_PRD_ID NUMBER;
  CUR_CAPABILITY_ID NUMBER;
BEGIN
  BEGIN
    SELECT 1 INTO TMP_VAR FROM OFFER_CHAIN WHERE ID = 3957271485 AND ROWNUM <= 1;
    UPDATE OFFER_CHAIN SET NAME='Global: All Digital Access', DESCRIPTION='Unlimited access to NYTimes.com, and the NYTimes smartphone and tablet apps.*', PRODUCT_URI='', VENDOR_SOURCE_ID='1', BILLING_SOURCE_ID=(SELECT ID FROM BILLING_SOURCE BS WHERE BS.NAME='Sartre'), IS_SEAT_LICENSE=0, GROUP_ACCOUNT_TYPE_ID='NO',IS_ADDRESS_REQUIRED=0, OFFER_CHAIN_STATUS_ID = 1, UPDATE_DATE = SYSDATE, UPDATED_BY = 'OFFERMAKER', IS_GIFT_CERTIFICATE='0', REVOKE_ENTITLEMENTS = '1', ADOPTABILITY_WINDOW_START_DATE = to_date('19-Dec-2012 00:00:00','DD-MON-YY HH24:MI:SS'), ADOPTABILITY_WINDOW_END_DATE = to_date('01-Jan-2999 00:00:00','DD-MON-YY HH24:MI:SS') WHERE ID = 3957271485;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO OFFER_CHAIN (ID, NAME, DESCRIPTION, ADOPTABILITY_WINDOW_START_DATE, ADOPTABILITY_WINDOW_END_DATE, IS_GIFT_CERTIFICATE, PRODUCT_URI, OFFER_CHAIN_STATUS_ID, REVOKE_ENTITLEMENTS, VENDOR_SOURCE_ID, BILLING_SOURCE_ID, IS_SEAT_LICENSE, GROUP_ACCOUNT_TYPE_ID, IS_ADDRESS_REQUIRED, CREATED_BY, CREATE_DATE, updated_by, update_date) VALUES (3957271485, 'Global: All Digital Access', 'Unlimited access to NYTimes.com, and the NYTimes smartphone and tablet apps.*', to_date('19-Dec-2012 00:00:00','DD-MON-YY HH24:MI:SS'), to_date('01-Jan-2999 00:00:00','DD-MON-YY HH24:MI:SS'), '0', NULL, '1', '1', '1', (SELECT ID FROM BILLING_SOURCE BS WHERE BS.NAME='Sartre'), decode('NO','IL',1,0), 'NO', '0', 'OFFERMAKER', SYSDATE, 'OFFERMAKER', SYSDATE);
  END;
  DELETE FROM OFFER_CHAIN_ELIGIBILITY WHERE offer_chain_id = 3957271485;
  INSERT INTO OFFER_CHAIN_ELIGIBILITY (ID, OFFER_CHAIN_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (ELG_ID_SEQ.NEXTVAL, 3957271485, 'REQUIRES_EMAIL_DOMAIN', 'pcfcorp.com,apacmail.com', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_CHAIN_ELIGIBILITY (ID, OFFER_CHAIN_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (ELG_ID_SEQ.NEXTVAL, 3957271485, 'IS_COMP', '1', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_CHAIN_ELIGIBILITY (ID, OFFER_CHAIN_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (ELG_ID_SEQ.NEXTVAL, 3957271485, 'MAX_CONCURRENT_SUBS', '1', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_CHAIN_ELIGIBILITY (ID, OFFER_CHAIN_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (ELG_ID_SEQ.NEXTVAL, 3957271485, 'INTERNAL_ONLY', '0', 'OFFERMAKER', SYSDATE);
  DELETE FROM OFFER_CHAIN_META_DATA WHERE offer_chain_id = 3957271485;
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (OCMD_ID_SEQ.NEXTVAL, 3957271485, 'BUNDLE_EXPLANATION', 'Web, smartphone and tablet, for APAC and PCF employees validated by email domain, good for one year', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (OCMD_ID_SEQ.NEXTVAL, 3957271485, 'PRICE_DESCRIPTION', 'Complimentary Access for APAC and PCF', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (OCMD_ID_SEQ.NEXTVAL, 3957271485, 'PRICE_SHORT_DESCRIPTION', 'Global ADA for APAC and PCF employees', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (OCMD_ID_SEQ.NEXTVAL, 3957271485, 'OFFER_TYPE', 'Complimentary', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (OCMD_ID_SEQ.NEXTVAL, 3957271485, 'OFFER_PRICE', 'Complimentary Access', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (OCMD_ID_SEQ.NEXTVAL, 3957271485, 'PROMO_PRICE_FOOTER_LABEL', 'Billing Cycle', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (OCMD_ID_SEQ.NEXTVAL, 3957271485, 'BILLING_CYCLE', 'every 4 weeks', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (OCMD_ID_SEQ.NEXTVAL, 3957271485, 'SUBSCRIBER_TYPE', 'Complimentary - Employee', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (OCMD_ID_SEQ.NEXTVAL, 3957271485, 'REFUND_POLICY', 'Complimentary Access: No refund.  Access removed within 6 hours if cancelled.', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (OCMD_ID_SEQ.NEXTVAL, 3957271485, 'REQUIRES_EMAIL_DOMAIN', 'pcfcorp.com', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (OCMD_ID_SEQ.NEXTVAL, 3957271485, 'REQUIRES_EMAIL_DOMAIN', 'apacmail.com', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (OCMD_ID_SEQ.NEXTVAL, 3957271485, 'CANCELABLE', '1', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (OCMD_ID_SEQ.NEXTVAL, 3957271485, 'UPGRADABLE_OFFER_CHAIN_IDS', '126084,256605', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (OCMD_ID_SEQ.NEXTVAL, 3957271485, 'BUNDLE', 'Bundle G (Global Digital All Access)', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (OCMD_ID_SEQ.NEXTVAL, 3957271485, 'ADX_BUNDLE', 'MM_EMP', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (OCMD_ID_SEQ.NEXTVAL, 3957271485, 'SIEBEL_CAMPAIGN_CODE', '37UYW', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (OCMD_ID_SEQ.NEXTVAL, 3957271485, 'IS_COMP', '1', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (OCMD_ID_SEQ.NEXTVAL, 3957271485, 'ANNUAL_PRICE', '0.00', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_CHAIN_META_DATA (ID, OFFER_CHAIN_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (OCMD_ID_SEQ.NEXTVAL, 3957271485, 'UID', 'b1cbac25e162988f4e3b441895ce0542749c236ba489a2063fcf4254d9b19dc2', 'OFFERMAKER', SYSDATE);
  DELETE FROM OFFER_CHAIN_NOTIFICATION_TYPE WHERE offer_chain_id = 3957271485;
  BEGIN
    SELECT 1 INTO TMP_VAR FROM OFFER_OFFER_CHAIN WHERE OFFER_CHAIN_ID = 3957271485 AND INDEX_VALUE = 0 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
  INSERT INTO OFFER (ID, OFFER_STATUS_ID, ENTITLEMENT_DURATION, CREATED_BY, CREATE_DATE, updated_by, update_date) VALUES (OFR_ID_SEQ.NEXTVAL, 1, 'P0Y0M365DT0H0M', 'OFFERMAKER', SYSDATE, 'OFFERMAKER', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Web' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, CREATED_BY, CREATE_DATE) VALUES (PRD_ID_SEQ.NEXTVAL, 'Web', '0', 1, NULL, '0', 'OFFERMAKER', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Web' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  SELECT ID INTO CUR_CAPABILITY_ID FROM CAPABILITY WHERE CODE IN LTRIM(RTRIM((UPPER('MM')))) AND ROWNUM <= 1;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, CAPABILITY_ID, CREATED_BY, CREATE_DATE) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, '1', '365', '0', '2', CUR_CAPABILITY_ID, 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/mm/:id:.json', 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": 0.0}', 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'capability', 'MM', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, CREATED_BY, CREATE_DATE) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'OFFERMAKER', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Mobile' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, CREATED_BY, CREATE_DATE) VALUES (PRD_ID_SEQ.NEXTVAL, 'Mobile', '0', 1, NULL, '0', 'OFFERMAKER', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Mobile' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  SELECT ID INTO CUR_CAPABILITY_ID FROM CAPABILITY WHERE CODE IN LTRIM(RTRIM((UPPER('MOW')))) AND ROWNUM <= 1;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, CAPABILITY_ID, CREATED_BY, CREATE_DATE) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, '1', '365', '0', '2', CUR_CAPABILITY_ID, 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/mow/:id:.json', 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": 0.0}', 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'capability', 'MOW', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, CREATED_BY, CREATE_DATE) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'OFFERMAKER', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Archive Article' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, CREATED_BY, CREATE_DATE) VALUES (PRD_ID_SEQ.NEXTVAL, 'Archive Article', '0', 1, NULL, '0', 'OFFERMAKER', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Archive Article' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  SELECT ID INTO CUR_CAPABILITY_ID FROM CAPABILITY WHERE CODE IN LTRIM(RTRIM((UPPER('AAA')))) AND ROWNUM <= 1;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, CAPABILITY_ID, CREATED_BY, CREATE_DATE) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, '1', '1200', '0', '2', CUR_CAPABILITY_ID, 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/archive/size/1200/:id:.json', 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": 0.0}', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, CREATED_BY, CREATE_DATE) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'OFFERMAKER', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'TimesMachine' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, CREATED_BY, CREATE_DATE) VALUES (PRD_ID_SEQ.NEXTVAL, 'TimesMachine', '0', 1, NULL, '0', 'OFFERMAKER', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'TimesMachine' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  SELECT ID INTO CUR_CAPABILITY_ID FROM CAPABILITY WHERE CODE IN LTRIM(RTRIM((UPPER('NONE')))) AND ROWNUM <= 1;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, CAPABILITY_ID, CREATED_BY, CREATE_DATE) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, '1', '365', '0', '2', CUR_CAPABILITY_ID, 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": 0.0}', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, CREATED_BY, CREATE_DATE) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'OFFERMAKER', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Smartphone' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, CREATED_BY, CREATE_DATE) VALUES (PRD_ID_SEQ.NEXTVAL, 'Smartphone', '0', 1, NULL, '0', 'OFFERMAKER', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Smartphone' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  SELECT ID INTO CUR_CAPABILITY_ID FROM CAPABILITY WHERE CODE IN LTRIM(RTRIM((UPPER('MSD')))) AND ROWNUM <= 1;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, CAPABILITY_ID, CREATED_BY, CREATE_DATE) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, '1', '365', '0', '2', CUR_CAPABILITY_ID, 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/msd/:id:.json', 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": 0.0}', 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'capability', 'MSD', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, CREATED_BY, CREATE_DATE) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'OFFERMAKER', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'IHTSmartphone' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, CREATED_BY, CREATE_DATE) VALUES (PRD_ID_SEQ.NEXTVAL, 'IHTSmartphone', '0', 1, NULL, '0', 'OFFERMAKER', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'IHTSmartphone' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  SELECT ID INTO CUR_CAPABILITY_ID FROM CAPABILITY WHERE CODE IN LTRIM(RTRIM((UPPER('GMSD')))) AND ROWNUM <= 1;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, CAPABILITY_ID, CREATED_BY, CREATE_DATE) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, '1', '365', '0', '2', CUR_CAPABILITY_ID, 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/gmsd/:id:.json', 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'capability', 'GMSD', 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": 0.0}', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, CREATED_BY, CREATE_DATE) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'OFFERMAKER', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Tablet' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, CREATED_BY, CREATE_DATE) VALUES (PRD_ID_SEQ.NEXTVAL, 'Tablet', '0', 1, NULL, '0', 'OFFERMAKER', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Tablet' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  SELECT ID INTO CUR_CAPABILITY_ID FROM CAPABILITY WHERE CODE IN LTRIM(RTRIM((UPPER('MTD')))) AND ROWNUM <= 1;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, CAPABILITY_ID, CREATED_BY, CREATE_DATE) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, '1', '365', '0', '2', CUR_CAPABILITY_ID, 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/mtd/:id:.json', 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": 0.0}', 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'capability', 'MTD', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, CREATED_BY, CREATE_DATE) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'OFFERMAKER', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'TimesReader' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, CREATED_BY, CREATE_DATE) VALUES (PRD_ID_SEQ.NEXTVAL, 'TimesReader', '0', 1, NULL, '0', 'OFFERMAKER', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'TimesReader' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  SELECT ID INTO CUR_CAPABILITY_ID FROM CAPABILITY WHERE CODE IN LTRIM(RTRIM((UPPER('TNR')))) AND ROWNUM <= 1;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, CAPABILITY_ID, CREATED_BY, CREATE_DATE) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, '1', '365', '0', '2', CUR_CAPABILITY_ID, 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/timesreader/:id:.json', 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'capability', 'TNR', 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": 0.0}', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, CREATED_BY, CREATE_DATE) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'OFFERMAKER', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'IHTTablet' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, CREATED_BY, CREATE_DATE) VALUES (PRD_ID_SEQ.NEXTVAL, 'IHTTablet', '0', 1, NULL, '0', 'OFFERMAKER', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'IHTTablet' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  SELECT ID INTO CUR_CAPABILITY_ID FROM CAPABILITY WHERE CODE IN LTRIM(RTRIM((UPPER('GMTD')))) AND ROWNUM <= 1;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, CAPABILITY_ID, CREATED_BY, CREATE_DATE) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, '1', '365', '0', '2', CUR_CAPABILITY_ID, 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/gmtd/:id:.json', 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'capability', 'GMTD', 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": 0.0}', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, CREATED_BY, CREATE_DATE) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'OFFERMAKER', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'IHTReader' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, CREATED_BY, CREATE_DATE) VALUES (PRD_ID_SEQ.NEXTVAL, 'IHTReader', '0', 1, NULL, '0', 'OFFERMAKER', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'IHTReader' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  SELECT ID INTO CUR_CAPABILITY_ID FROM CAPABILITY WHERE CODE IN LTRIM(RTRIM((UPPER('IHTR')))) AND ROWNUM <= 1;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, CAPABILITY_ID, CREATED_BY, CREATE_DATE) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, '2', '365', '0', '2', CUR_CAPABILITY_ID, 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/ihtreader/:id:.json', 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'capability', 'IHT', 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": 0.0}', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, CREATED_BY, CREATE_DATE) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'OFFERMAKER', SYSDATE);
  BEGIN
    SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Crosswords' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO PRODUCT (ID, NAME, PRODUCTION_COST, PRODUCT_STATUS_ID, PRODUCT_URI, UNIT_PRICE, CREATED_BY, CREATE_DATE) VALUES (PRD_ID_SEQ.NEXTVAL, 'Crosswords', '0', 1, NULL, '0', 'OFFERMAKER', SYSDATE);
      SELECT ID INTO CUR_PRD_ID FROM PRODUCT WHERE NAME = 'Crosswords' AND PRODUCT_STATUS_ID = 1 AND ROWNUM <= 1;
    WHEN OTHERS THEN
      RAISE;
  END;
  SELECT ID INTO CUR_CAPABILITY_ID FROM CAPABILITY WHERE CODE IN LTRIM(RTRIM((UPPER('XWD')))) AND ROWNUM <= 1;
  INSERT INTO PRODUCT_OFFERING (ID, PRODUCT_ID, TAX_POLICY_TYPE_ID, QUANTITY, UNIT_PRICE, TAX_CATEGORY_ID, CAPABILITY_ID, CREATED_BY, CREATE_DATE) VALUES (PO_ID_SEQ.NEXTVAL, CUR_PRD_ID, '1', '365', '0', '2', CUR_CAPABILITY_ID, 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'entitlement_uri', 'http://:hostname:/svc/user/entitlements/crosswords/:id:.json', 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'capability', 'XWD', 'OFFERMAKER', SYSDATE);
  INSERT INTO PRODUCT_OFFERING_META_DATA (ID, PRODUCT_OFFERING_ID, NAME, VALUE, CREATED_BY, CREATE_DATE) VALUES (PROMD_ID_SEQ.NEXTVAL, PO_ID_SEQ.CURRVAL, 'DEFAULT_VAT_RATE', '{"*": 0.0}', 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_PRODUCT_OFFERING (OFFER_ID, PRODUCT_OFFERING_ID, CREATED_BY, CREATE_DATE) VALUES (OFR_ID_SEQ.CURRVAL, PO_ID_SEQ.CURRVAL, 'OFFERMAKER', SYSDATE);
  INSERT INTO OFFER_OFFER_CHAIN (OFFER_ID, OFFER_CHAIN_ID, INDEX_VALUE, NUM_RECURRENCES, CREATED_BY, CREATE_DATE, updated_by, update_date) VALUES (OFR_ID_SEQ.CURRVAL, 3957271485, '0', '-1', 'OFFERMAKER', SYSDATE, 'OFFERMAKER', SYSDATE);
  END;
END;
/

COMMIT;
