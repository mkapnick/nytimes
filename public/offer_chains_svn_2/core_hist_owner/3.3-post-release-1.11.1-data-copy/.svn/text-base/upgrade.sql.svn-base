WHENEVER SQLERROR EXIT ROLLBACK;

truncate table core_hist_owner.NOTIFICATION_FAILURE_HISTORY;
truncate table core_hist_owner.NOTIFICATION_HISTORY;

insert into core_hist_owner.NOTIFICATION_FAILURE_HISTORY select * from ops_hist_owner.NOTIFICATION_FAILURE_HISTORY;
insert into core_hist_owner.NOTIFICATION_HISTORY select * from ops_hist_owner.NOTIFICATION_HISTORY;
commit;


