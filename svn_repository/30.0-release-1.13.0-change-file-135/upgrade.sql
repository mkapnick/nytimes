WHENEVER SQLERROR EXIT ROLLBACK;

variable is_current_version_fine NUMBER;
variable change_version NUMBER;
variable bad_current_version VARCHAR2(1024);

exec :change_version := 135;
exec PROCS_SYSTEM_V17.CHECK_VERSION(:change_version - 1, :is_current_version_fine);
exec :bad_current_version := 'Current version is bad, please update your version to '||(:change_version-1);

BEGIN
  IF (:is_current_version_fine != 0) THEN
    RAISE_APPLICATION_ERROR(-20001, :bad_current_version);
  END IF;
END;
/

CREATE INDEX PP_ACCOUNT_ID_IDX ON PAYPAL(ACCOUNT_ID) ONLINE TABLESPACE CORE_IDX; 

CREATE TABLE TRANSACTION_TYPE (
  CODE VARCHAR2(50) NOT NULL,
  CREATE_DATE DATE NOT NULL,
  CREATED_BY  VARCHAR2(255) NOT NULL,
  CONSTRAINT TRANSACTIONTYPE_PK PRIMARY KEY (CODE) USING INDEX TABLESPACE CORE_IDX
) TABLESPACE CORE;

ALTER TABLE TRANSACTION ADD (
    TRANSACTION_TYPE_CODE VARCHAR2(50),
    CONSTRAINT TRANSACTIONTYPE_FK FOREIGN KEY (TRANSACTION_TYPE_CODE) REFERENCES TRANSACTION_TYPE(CODE)
);

INSERT INTO TRANSACTION_TYPE (CODE, CREATE_DATE, CREATED_BY) VALUES ('START_SUBSCRIPTION', SYSDATE, 'SAR-188');
INSERT INTO TRANSACTION_TYPE (CODE, CREATE_DATE, CREATED_BY) VALUES ('GIFT_CERTIFICATE_PURCHASE', SYSDATE, 'SAR-188');
INSERT INTO TRANSACTION_TYPE (CODE, CREATE_DATE, CREATED_BY) VALUES ('REFUND', SYSDATE, 'SAR-188');
INSERT INTO TRANSACTION_TYPE (CODE, CREATE_DATE, CREATED_BY) VALUES ('RECURRING_BILLING', SYSDATE, 'SAR-188');
INSERT INTO TRANSACTION_TYPE (CODE, CREATE_DATE, CREATED_BY) VALUES ('RECURRING_BILLING_USER_UPDATE', SYSDATE, 'SAR-188');
INSERT INTO TRANSACTION_TYPE (CODE, CREATE_DATE, CREATED_BY) VALUES ('GRACE_PERIOD_USER_UPDATE', SYSDATE, 'SAR-188');
INSERT INTO TRANSACTION_TYPE (CODE, CREATE_DATE, CREATED_BY) VALUES ('GRACE_PERIOD_FINAL', SYSDATE, 'SAR-188');

INSERT INTO NOTIFICATION_TYPE (ID, VALUE, TEMPLATE_URL) VALUES (NOTTID_SEQ.NEXTVAL, 'sartre-grace-ending-soon', 'N/A');


-- SAR-22

INSERT INTO CORE_OWNER.SUBSCRIPTION_CANC_TYPE_STATUS (ID, VALUE, DESCRIPTION)
    VALUES (3, 'INTERNAL_ONLY', 'Cancellation reason only usable by internal system processes');

UPDATE CORE_OWNER.SUBSCRIPTION_CANC_TYPE_STATUS SET
    DESCRIPTION = 'Active cancellation reason, usable by user-facing tools'
WHERE VALUE = 'ACTIVE';

UPDATE CORE_OWNER.SUBSCRIPTION_CANC_TYPE_STATUS SET
    DESCRIPTION = 'Cancellation reason which is inactive and cannot be used'
WHERE VALUE = 'INACTIVE';

DECLARE
  max_id NUMBER;
BEGIN
  -- If there's a sub cancel reason sequence, I can't find it, but this should suffice
  SELECT MAX(ID) + 1 INTO max_id
  FROM subscription_cancel_reason;

  -- cf https://jira.em.nytimes.com/browse/SAR-314, acceptance criteria tab
  INSERT INTO subscription_cancel_reason (ID, VALUE, cancelation_status_id, description)
  VALUES (max_id + 1, 'Failed Start Subscription', 3, -- status internal-only
          'set by core when realtime subscription attempt fails and by billing job when non-realtime start subscription transaction attempt fails');

  INSERT INTO subscription_cancel_reason (ID, VALUE, cancelation_status_id, description)
  VALUES (max_id + 2, 'Failed Grace Period Final Recur', 3,
          'Set by billing job when final transaction attempt within grace period fails');

  INSERT INTO subscription_cancel_reason (ID, VALUE, cancelation_status_id, description)
  VALUES (max_id + 3, 'Past Grace Period End', 3,
          'Set by billing job when invoices are found with grace end dates in the past');

END;

COMMIT;


exec PROCS_SYSTEM_V17.INCREMENT_VERSION();
