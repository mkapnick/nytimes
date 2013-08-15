whenever sqlerror exit rollback;

update group_account 
set seat_ttl_in_hours = 24,
update_date = sysdate,
updated_by = 'jira-sy-2465'
where id in (
  107787, 107771, 107961, 107790, 107776, 107772,
  107774, 107962, 107788, 107791, 107786, 107789,
  107775, 107785, 107770
);

commit;
