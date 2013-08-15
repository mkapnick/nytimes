WHENEVER SQLERROR EXIT ROLLBACK;

variable is_current_version_fine NUMBER;
variable change_version NUMBER;
variable bad_current_version VARCHAR2(1024);

exec :change_version := 127;
exec PROCS_SYSTEM_V14.CHECK_VERSION(:change_version - 1, :is_current_version_fine);
exec :bad_current_version := 'Current version is bad, please update your version to '||(:change_version-1);

BEGIN
  IF (:is_current_version_fine != 0) THEN
    RAISE_APPLICATION_ERROR(-20001, :bad_current_version);
  END IF;
END;
/

ALTER TABLE INVOICE_ADJUSTMENT ADD (UPDATE_DATE DATE, UPDATED_BY VARCHAR2(255));   
update INVOICE_ADJUSTMENT set UPDATE_DATE=CREATE_DATE, UPDATED_BY=CREATED_BY;

exec PROCS_SYSTEM_V14.INCREMENT_VERSION();
