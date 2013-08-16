whenever sqlerror exit rollback;

update group_account 
set seat_ttl_in_hours = 24,
update_date = sysdate,
updated_by = 'jira-sar-934'
where seat_ttl_in_hours = 0;

commit;
