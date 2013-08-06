
BEGIN
  INSERT INTO CORE_OWNER.NOTIFICATION_TYPE (ID, VALUE, TEMPLATE_URL) VALUES (CORE_OWNER.NOTTID_SEQ.NEXTVAL, 'card_expiration', 'N/A');
EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;
WHEN OTHERS THEN RAISE;
END;
/

BEGIN
  INSERT INTO CORE_OWNER.NOTIFICATION_TYPE (ID, VALUE, TEMPLATE_URL) VALUES (CORE_OWNER.NOTTID_SEQ.NEXTVAL, 'redeemer-access-livingsocial', 'N/A');
EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;
WHEN OTHERS THEN RAISE;
END;
/

BEGIN
  INSERT INTO CORE_OWNER.NOTIFICATION_TYPE (ID, VALUE, TEMPLATE_URL) VALUES (CORE_OWNER.NOTTID_SEQ.NEXTVAL, 'sartre-cancel', 'N/A');
EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;
WHEN OTHERS THEN RAISE;
END;
/

BEGIN
  INSERT INTO CORE_OWNER.NOTIFICATION_TYPE (ID, VALUE, TEMPLATE_URL) VALUES (CORE_OWNER.NOTTID_SEQ.NEXTVAL, 'sartre-decline', 'N/A');
EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;
WHEN OTHERS THEN RAISE;
END;
/

BEGIN
  INSERT INTO CORE_OWNER.NOTIFICATION_TYPE (ID, VALUE, TEMPLATE_URL) VALUES (CORE_OWNER.NOTTID_SEQ.NEXTVAL, 'sartre-purchase', 'N/A');
EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;
WHEN OTHERS THEN RAISE;
END;
/

BEGIN
  INSERT INTO CORE_OWNER.NOTIFICATION_TYPE (ID, VALUE, TEMPLATE_URL) VALUES (CORE_OWNER.NOTTID_SEQ.NEXTVAL, 'sartre-sub-expired-livingsocial', 'N/A');
EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;
WHEN OTHERS THEN RAISE;
END;
/

BEGIN
  INSERT INTO CORE_OWNER.NOTIFICATION_TYPE (ID, VALUE, TEMPLATE_URL) VALUES (CORE_OWNER.NOTTID_SEQ.NEXTVAL, 'sartre-upsell-sub-activation-livingsocial', 'N/A');
EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;
WHEN OTHERS THEN RAISE;
END;
/

COMMIT;
