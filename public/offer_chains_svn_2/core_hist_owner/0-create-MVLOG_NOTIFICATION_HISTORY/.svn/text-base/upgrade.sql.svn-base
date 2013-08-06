CREATE MATERIALIZED VIEW LOG ON CORE_HIST_OWNER.NOTIFICATION_HISTORY TABLESPACE CORE_HIST
WITH PRIMARY KEY EXCLUDING NEW VALUES;

grant select on core_hist_owner.MLOG$_NOTIFICATION_HISTORY to core_owner;

grant select on core_hist_owner.notification_history to core_owner;