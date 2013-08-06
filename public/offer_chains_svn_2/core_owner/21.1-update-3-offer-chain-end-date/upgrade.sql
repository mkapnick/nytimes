WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK

UPDATE core_owner.offer_chain
SET adoptability_window_end_date = to_date('2099-12-31', 'yyyy-mm-dd'),
update_date = sysdate,
updated_by = 'JIRA SAR-250'
WHERE id in (3681562467, 173830776,965484810);

commit;
