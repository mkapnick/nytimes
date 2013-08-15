grant execute on OPS_OWNER.NOTIFICATION_STATUSES_V14 to ops_aaa_app;
grant execute on OPS_OWNER.PROCS_NOTIFICATION_V14 to ops_aaa_app;
grant execute on OPS_OWNER.PROCS_SYSTEM_V14 to ops_aaa_app;

grant execute on OPS_OWNER.NOTIFICATION_STATUSES_V14 to ops_payment_app;
grant execute on OPS_OWNER.PROCS_NOTIFICATION_V14 to ops_payment_app;
grant execute on OPS_OWNER.PROCS_SYSTEM_V14 to ops_payment_app;

grant execute on OPS_OWNER.NOTIFICATION_STATUSES_V14 to ops_notif_app;
grant execute on OPS_OWNER.PROCS_NOTIFICATION_V14 to ops_notif_app;
grant execute on OPS_OWNER.PROCS_SYSTEM_V14 to ops_notif_app;

grant execute on OPS_OWNER.PUBLIC_PROCS_CLIENT_V14 to core_licensing_app;
grant execute on OPS_OWNER.PUBLIC_PROCS_CLIENT_V14 to core_billing_app;
grant execute on OPS_OWNER.PUBLIC_PROCS_CLIENT_V14 to core_app;
grant execute on OPS_OWNER.PUBLIC_PROCS_CLIENT_V14 to cupy_app;

grant execute on OPS_OWNER.PROCS_PROCESS_RETRY_V14 to core_owner;
grant execute on OPS_OWNER.PROCS_PROCESS_RETRY_V14 to core_app;
grant execute on OPS_OWNER.PROCS_PROCESS_RETRY_V14 to cupy_app;
grant execute on OPS_OWNER.PROCS_PROCESS_RETRY_V14 to core_billing_app;
grant execute on OPS_OWNER.PROCS_PROCESS_RETRY_V14 to core_licensing_app;
grant execute on OPS_OWNER.PROCS_PROCESS_RETRY_V14 to ops_notif_app;
grant execute on OPS_OWNER.PROCS_PROCESS_RETRY_V14 to etl_app;
grant execute on OPS_OWNER.PROCS_PROCESS_RETRY_V14 to core_subup_app;
grant execute on OPS_OWNER.PROCS_PROCESS_RETRY_V14 to core_poller_app;
grant execute on OPS_OWNER.PROCS_PROCESS_RETRY_V14 to core_subup_app;

grant select on OPS_OWNER.PROCESS_RETRY_THROTTLE to core_owner;
grant select on OPS_OWNER.PROCESS_RETRY_THROTTLE to core_app;
grant select on OPS_OWNER.PROCESS_RETRY_THROTTLE to cupy_app;
grant select on OPS_OWNER.PROCESS_RETRY_THROTTLE to core_billing_app;
grant select on OPS_OWNER.PROCESS_RETRY_THROTTLE to core_licensing_app;
grant select on OPS_OWNER.PROCESS_RETRY_THROTTLE to core_subup_app;

grant select on OPS_OWNER.NOTIFICATION_TYPE to core_owner;
grant select on OPS_OWNER.NOTIFICATION_TYPE to core_app;
grant select on OPS_OWNER.NOTIFICATION_TYPE to cupy_app;
grant select on OPS_OWNER.NOTIFICATION_TYPE to core_billing_app;
grant select on OPS_OWNER.NOTIFICATION_TYPE to core_licensing_app;

grant REFERENCES on OPS_OWNER.NOTIFICATION_TYPE to core_owner;
grant REFERENCES on OPS_OWNER.NOTIFICATION_TYPE to core_app;
grant REFERENCES on OPS_OWNER.NOTIFICATION_TYPE to cupy_app;
grant REFERENCES on OPS_OWNER.NOTIFICATION_TYPE to core_billing_app;
grant REFERENCES on OPS_OWNER.NOTIFICATION_TYPE to core_licensing_app;

grant select, insert, update, delete ON OPS_OWNER.NOTIFICATION_TYPE to core_owner;
grant select ON OPS_OWNER.NOTTID_SEQ to core_owner;
