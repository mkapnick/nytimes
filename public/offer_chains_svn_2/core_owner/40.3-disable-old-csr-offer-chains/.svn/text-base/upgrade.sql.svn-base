WHENEVER SQLERROR EXIT ROLLBACK;

update offer_chain set offer_chain_status_id = 2, update_date = sysdate, updated_by = 'SAR-245', adoptability_window_end_date = sysdate - 1 where id = 256605 or id = 126084;

COMMIT;