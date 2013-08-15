WHENEVER SQLERROR EXIT ROLLBACK;

update gift_certificate set expiration_date = to_date('2018-07-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), updated_by = 'SAR-480' where purchaser_group_id = 67513982;
commit;
update gift_certificate set expiration_date = to_date('2018-07-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), updated_by = 'SAR-480' where purchaser_group_id = 67513974;

COMMIT;
