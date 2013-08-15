grant execute on CORE_OWNER.PROCS_ACCOUNT_V17 to core_app;
grant execute on CORE_OWNER.PROCS_ADX_V17 to core_app;
grant execute on CORE_OWNER.PROCS_CHARGE_V17 to core_app;
grant execute on CORE_OWNER.PROCS_COMMON_V17 to core_app;
grant execute on CORE_OWNER.PROCS_FIN_INSTRUMENTS_V17 to core_app;
grant execute on CORE_OWNER.PROCS_INVOICE_V17 to core_app;
grant execute on CORE_OWNER.PROCS_LICENSE_V17 to core_app;
grant execute on CORE_OWNER.PROCS_LINE_ITEMS_V17 to core_app;
grant execute on CORE_OWNER.PROCS_OFFER_CHAIN_V17 to core_app;
grant execute on CORE_OWNER.PROCS_PRODUCT_V17 to core_app;
grant execute on CORE_OWNER.PROCS_SUBSCRIPTION_V17 to core_app;
grant execute on CORE_OWNER.PROCS_SYSTEM_V17 to core_app;
grant execute on CORE_OWNER.PROCS_TEST_V17 to core_app;
grant execute on CORE_OWNER.PROCS_TRANSACTION_V17 to core_app;
grant execute on CORE_OWNER.PROCS_TAXES_V17 to core_app;
grant execute on CORE_OWNER.PROCS_LOCKING_V17 to core_app;
grant execute on CORE_OWNER.PROCS_ADJUSTMENTS_V17 to core_app;
grant execute on CORE_OWNER.PUBLIC_PROCS_BILLING_V17 to core_app;
grant execute on CORE_OWNER.PROCS_ADDRESS_V17 to core_app;
grant execute on CORE_OWNER.PROCS_GROUP_ACCOUNT_V17 to core_app;

grant execute on CORE_OWNER.PUBLIC_PROCS_BILLING_V17 to core_billing_app;
grant execute on CORE_OWNER.PUBLIC_PROCS_RENEWAL_V17 to core_licensing_app;
grant execute on CORE_OWNER.PROCS_GROUP_ACCOUNT_V17 to core_licensing_app;
grant execute on CORE_OWNER.PUBLIC_PROCS_NOTIFICATION_V17 to ops_notif_app;


grant execute on CORE_OWNER.PROCS_TAXES_V17 to core_tax_app;
grant execute on CORE_OWNER.PROCS_PRODUCT_V17 to core_tax_app;
grant execute on CORE_OWNER.PROCS_ACCOUNT_V17 to core_tax_app;

grant execute on CORE_OWNER.PROCS_POLLING_SYNC to core_poller_app;

grant execute on CORE_OWNER.PROCS_RECONCILIATION_CRU_V17 to etl_app;
grant execute on CORE_OWNER.PROCS_SUBSCRIPTION_V17 to etl_app;
grant execute on CORE_OWNER.PROCS_TRANSACTION_V17 to etl_app;
grant execute on CORE_OWNER.PROCS_REPORTING to etl_app;
grant execute on CORE_OWNER.PROCS_LOCKING_V17 to etl_app;
grant execute on CORE_OWNER.PROCS_ACCOUNT_V17 to etl_app;
grant execute on CORE_OWNER.PROCS_INVOICE_V17 to etl_app;

grant execute on CORE_OWNER.PROCS_ITUNES_RECEIPT_V17 to core_app;
grant execute on CORE_OWNER.PROCS_ITUNES_RECEIPT_V17 to core_subup_app;
grant execute on CORE_OWNER.PROCS_AMAZON_V17 to core_app;
grant execute on CORE_OWNER.PROCS_AMAZON_V17 to core_subup_app;
grant execute on CORE_OWNER.PROCS_LICENSE_V17 to core_subup_app;
grant execute on CORE_OWNER.PROCS_LOCKING_V17 to core_subup_app;

grant execute on CORE_OWNER.PROCS_SUBSCRIPTION_V17 to core_subup_app;
grant execute on CORE_OWNER.PROCS_GROUP_ACCOUNT_V17 to core_app;
grant execute on CORE_OWNER.PROCS_GROUP_ACCOUNT_CRU_V17 to core_app;
grant execute on CORE_OWNER.PROCS_ENTITLEMENT_V17 to core_app;

grant execute on CORE_OWNER.PROCS_CUPY to cupy_app;
grant execute on CORE_OWNER.PROCS_LOCKING_V17 to cupy_app;

grant execute on CORE_OWNER.NOTIFICATION_STATUSES_V17 to ops_aaa_app;
grant execute on CORE_OWNER.PROCS_NOTIFICATION_V17 to ops_aaa_app;
grant execute on CORE_OWNER.PROCS_SYSTEM_V17 to ops_aaa_app;

grant execute on CORE_OWNER.NOTIFICATION_STATUSES_V17 to ops_payment_app;
grant execute on CORE_OWNER.PROCS_NOTIFICATION_V17 to ops_payment_app;
grant execute on CORE_OWNER.PROCS_SYSTEM_V17 to ops_payment_app;

grant execute on CORE_OWNER.NOTIFICATION_STATUSES_V17 to ops_notif_app;
grant execute on CORE_OWNER.PROCS_NOTIFICATION_V17 to ops_notif_app;
grant execute on CORE_OWNER.PROCS_SYSTEM_V17 to ops_notif_app;

grant execute on CORE_OWNER.PUBLIC_PROCS_CLIENT_V17 to core_licensing_app;
grant execute on CORE_OWNER.PUBLIC_PROCS_CLIENT_V17 to core_billing_app;
grant execute on CORE_OWNER.PUBLIC_PROCS_CLIENT_V17 to core_app;
grant execute on CORE_OWNER.PUBLIC_PROCS_CLIENT_V17 to cupy_app;

grant execute on CORE_OWNER.PROCS_PROCESS_RETRY_V17 to cupy_app;
grant execute on CORE_OWNER.PROCS_PROCESS_RETRY_V17 to core_owner;
grant execute on CORE_OWNER.PROCS_PROCESS_RETRY_V17 to core_app;
grant execute on CORE_OWNER.PROCS_PROCESS_RETRY_V17 to core_billing_app;
grant execute on CORE_OWNER.PROCS_PROCESS_RETRY_V17 to core_licensing_app;
grant execute on CORE_OWNER.PROCS_PROCESS_RETRY_V17 to ops_notif_app;
grant execute on CORE_OWNER.PROCS_PROCESS_RETRY_V17 to etl_app;
grant execute on CORE_OWNER.PROCS_PROCESS_RETRY_V17 to core_subup_app;
grant execute on CORE_OWNER.PROCS_PROCESS_RETRY_V17 to core_poller_app;
grant execute on CORE_OWNER.PROCS_PROCESS_RETRY_V17 to core_subup_app;

grant select on CORE_OWNER.PROCESS_RETRY_THROTTLE to cupy_app;
grant select on CORE_OWNER.PROCESS_RETRY_THROTTLE to core_owner;
grant select on CORE_OWNER.PROCESS_RETRY_THROTTLE to core_app;
grant select on CORE_OWNER.PROCESS_RETRY_THROTTLE to core_billing_app;
grant select on CORE_OWNER.PROCESS_RETRY_THROTTLE to core_licensing_app;
grant select on CORE_OWNER.PROCESS_RETRY_THROTTLE to core_subup_app;

grant select on CORE_OWNER.NOTIFICATION_TYPE to cupy_app;
grant select on CORE_OWNER.NOTIFICATION_TYPE to core_owner;
grant select on CORE_OWNER.NOTIFICATION_TYPE to core_app;
grant select on CORE_OWNER.NOTIFICATION_TYPE to core_billing_app;
grant select on CORE_OWNER.NOTIFICATION_TYPE to core_licensing_app;

grant REFERENCES on CORE_OWNER.NOTIFICATION_TYPE to cupy_app;
grant REFERENCES on CORE_OWNER.NOTIFICATION_TYPE to core_owner;
grant REFERENCES on CORE_OWNER.NOTIFICATION_TYPE to core_app;
grant REFERENCES on CORE_OWNER.NOTIFICATION_TYPE to core_billing_app;
grant REFERENCES on CORE_OWNER.NOTIFICATION_TYPE to core_licensing_app;

grant select, insert, update, delete ON CORE_OWNER.NOTIFICATION_TYPE to core_owner;
grant select ON CORE_OWNER.NOTTID_SEQ to core_owner;
