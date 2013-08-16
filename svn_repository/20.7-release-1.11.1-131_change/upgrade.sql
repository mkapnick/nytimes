WHENEVER SQLERROR EXIT ROLLBACK;

variable is_current_version_fine NUMBER;
variable change_version NUMBER;
variable bad_current_version VARCHAR2(1024);

exec :change_version := 131;
exec PROCS_SYSTEM_V9.CHECK_VERSION(:change_version - 1, :is_current_version_fine);
exec :bad_current_version := 'Current version is bad, please update your version to '||(:change_version-1);

BEGIN
  IF (:is_current_version_fine != 0) THEN
    RAISE_APPLICATION_ERROR(-20001, :bad_current_version);
  END IF;
END;
/

truncate table core_owner.NOTIFICATION;
truncate table core_owner.NOTIFICATION_FAILURE;
truncate table core_owner.PROCESS_RETRY_THROTTLE;
insert into core_owner.NOTIFICATION select * from ops_owner.NOTIFICATION;
insert into core_owner.NOTIFICATION_FAILURE select * from ops_owner.NOTIFICATION_FAILURE;
insert into core_owner.PROCESS_RETRY_THROTTLE select * from ops_owner.PROCESS_RETRY_THROTTLE;

commit;

exec PROCS_SYSTEM_V9.INCREMENT_VERSION();
