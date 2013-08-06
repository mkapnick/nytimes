WHENEVER SQLERROR EXIT ROLLBACK;

alter table notification_failure disable constraint NOT_NOTF_FK;
truncate table core_owner.NOTIFICATION_FAILURE;
truncate table core_owner.NOTIFICATION;
truncate table core_owner.PROCESS_RETRY_THROTTLE;
insert into core_owner.NOTIFICATION select * from ops_owner.NOTIFICATION;
insert into core_owner.NOTIFICATION_FAILURE select * from ops_owner.NOTIFICATION_FAILURE;
insert into core_owner.PROCESS_RETRY_THROTTLE select * from ops_owner.PROCESS_RETRY_THROTTLE;
alter table notification_failure enable constraint NOT_NOTF_FK;

commit;

