WHENEVER SQLERROR EXIT ROLLBACK;

variable is_current_version_fine NUMBER;
variable change_version NUMBER;
variable bad_current_version VARCHAR2(1024);

exec :change_version := 139;
exec PROCS_SYSTEM_V19.CHECK_VERSION(:change_version - 1, :is_current_version_fine);
exec :bad_current_version := 'Current version is bad, please update your version to '||(:change_version-1);

BEGIN
  IF (:is_current_version_fine != 0) THEN
    RAISE_APPLICATION_ERROR(-20001, :bad_current_version);
  END IF;
END;
/


INSERT INTO SUBSCRIPTION_CANCEL_REASON (ID, VALUE, CANCELATION_STATUS_ID, DESCRIPTION)
VALUES (45, 'Failed Grace Period Final Recur', 3,
    'Set by billing job when final transaction attempt within grace period fails');

INSERT INTO SUBSCRIPTION_CANCEL_REASON (ID, VALUE, CANCELATION_STATUS_ID, DESCRIPTION)
VALUES (46, 'Past Grace Period End', 3,
    'Set by billing job when invoices are found with grace end dates in the past');

INSERT INTO SUBSCRIPTION_CANCEL_REASON (ID, VALUE, CANCELATION_STATUS_ID, DESCRIPTION)
VALUES (47, 'Failed Start Subscription', 3,
    'Set by billing job when final attempt fails for a START_SUBSCRIPTION transaction');

COMMIT;


exec PROCS_SYSTEM_V19.INCREMENT_VERSION();
