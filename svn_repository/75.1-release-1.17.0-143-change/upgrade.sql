WHENEVER SQLERROR EXIT ROLLBACK;

variable is_current_version_fine NUMBER;
variable change_version NUMBER;
variable bad_current_version VARCHAR2(1024);

exec :change_version := 143;
exec PROCS_SYSTEM_V16.CHECK_VERSION(:change_version - 1, :is_current_version_fine);
exec :bad_current_version := 'Current version is bad, please update your version to '||(:change_version-1);

-- two copies of crosswords product, differ only in unit_price, which is not used
update product_offering set product_id = 6 where product_id = 2;
-- two copies of archive article product, exactly the same
update product_offering set product_id = 3 where product_id = 4;
truncate table product_eligibility;
delete from product where id = 2;
delete from product where id = 4;

-- fixing three product_offerings that have NONE capability due to hack for MEU
update product_offering set capability_id = 9 where product_id = 73 and capability_id = 0;

alter table product add entitlement varchar2(32);
alter table product add is_shareable number default 0 not null;
alter table product add tax_category_id number default 0 not null;
alter table product add default_vat_rate varchar2(32);

-- set default_vat_rate to 0.2 for crosswords and archive articles, 0 for everything else
update product set default_vat_rate = '{"*": 0.0}';
update product set default_vat_rate = '{"*": .2}' where id in (3, 6);
alter table product modify default_vat_rate constraint vat_not_null not null;

EXEC PROCS_SYSTEM_V16.INCREMENT_VERSION();