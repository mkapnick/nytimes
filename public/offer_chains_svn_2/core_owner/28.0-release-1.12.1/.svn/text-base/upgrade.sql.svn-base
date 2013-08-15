WHENEVER SQLERROR EXIT ROLLBACK;

variable is_current_version_fine NUMBER;
variable change_version NUMBER;
variable bad_current_version VARCHAR2(1024);

exec :change_version := 134;
exec PROCS_SYSTEM_V16.CHECK_VERSION(:change_version - 1, :is_current_version_fine);
exec :bad_current_version := 'Current version is bad, please update your version to '||(:change_version-1);

BEGIN
  IF (:is_current_version_fine != 0) THEN
    RAISE_APPLICATION_ERROR(-20001, :bad_current_version);
  END IF;
END;
/

INSERT INTO CORE_OWNER.CC_UPDATE_REASON(ID,DESCRIPTION,CREATE_DATE,CREATED_BY) VALUES ('OTHER','Unknown reason obtain from Chase Report File',SYSDATE,'JIRA-SAR-375');
COMMIT;

CREATE INDEX CCU_UPDATE_DATE_IDX ON CC_UPDATE(UPDATE_DATE) TABLESPACE CORE_IDX;

EXEC PROCS_SYSTEM_V16.INCREMENT_VERSION();

