WHENEVER SQLERROR EXIT ROLLBACK;

variable is_current_version_fine NUMBER;
variable change_version NUMBER;
variable bad_current_version VARCHAR2(1024);

exec :change_version := 130;
exec PROCS_SYSTEM_V9.CHECK_VERSION(:change_version - 1, :is_current_version_fine);
exec :bad_current_version := 'Current version is bad, please update your version to '||(:change_version-1);

BEGIN
  IF (:is_current_version_fine != 0) THEN
    RAISE_APPLICATION_ERROR(-20001, :bad_current_version);
  END IF;
END;
/

insert into core_owner.NOTIFICATION_STATUS select * from ops_owner.NOTIFICATION_STATUS;
insert into core_owner.NOTIFICATION_TYPE select * from ops_owner.NOTIFICATION_TYPE;

commit;

exec PROCS_SYSTEM_V9.INCREMENT_VERSION();
