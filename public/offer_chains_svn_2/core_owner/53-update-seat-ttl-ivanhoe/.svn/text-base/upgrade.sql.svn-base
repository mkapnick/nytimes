whenever sqlerror exit rollback;

update group_account 
set seat_ttl_in_hours = 24,
update_date = sysdate,
updated_by = 'jira-ora-831'
where id = 109395;

commit;
