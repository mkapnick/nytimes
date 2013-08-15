WHENEVER SQLERROR EXIT ROLLBACK;

variable is_current_version_fine NUMBER;
variable change_version NUMBER;
variable bad_current_version VARCHAR2(1024);

exec :change_version := 132;
exec PROCS_SYSTEM_V9.CHECK_VERSION(:change_version - 1, :is_current_version_fine);
exec :bad_current_version := 'Current version is bad, please update your version to '||(:change_version-1);

BEGIN
  IF (:is_current_version_fine != 0) THEN
    RAISE_APPLICATION_ERROR(-20001, :bad_current_version);
  END IF;
END;
/

ALTER TABLE
    offer_chain_notification_type DROP CONSTRAINT OPS_NT_OCHNT_FK;

ALTER TABLE
    OFFER_CHAIN_NOTIFICATION_TYPE ADD CONSTRAINT NT_OCHNT_FK FOREIGN KEY(NOTIFICATION_TYPE_ID) REFERENCES CORE_OWNER.NOTIFICATION_TYPE(ID) ENABLE;

commit;

exec PROCS_SYSTEM_V9.INCREMENT_VERSION();
