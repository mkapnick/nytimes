WHENEVER SQLERROR EXIT ROLLBACK;

variable is_current_version_fine NUMBER;
variable change_version NUMBER;
variable bad_current_version VARCHAR2(1024);

exec :change_version := 24;
exec PROCS_SYSTEM_V17.CHECK_VERSION(:change_version - 1, :is_current_version_fine);
exec :bad_current_version := 'Current version is bad, please update your version to '||(:change_version-1);

BEGIN
  IF (:is_current_version_fine != 0) THEN
    RAISE_APPLICATION_ERROR(-20001, :bad_current_version);
  END IF;
END;
/

ALTER TABLE CORE_HIST_OWNER.TRANSACTION_HISTORY ADD (
    ORDER_ID VARCHAR2(255),
    CHARGE_ID NUMBER(22),
    IS_REFUND NUMBER(22),
    IS_SETTLED NUMBER(22),
    TRANSACTION_TYPE_CODE VARCHAR2(50)
);

exec PROCS_SYSTEM_V17.INCREMENT_VERSION();
