WHENEVER SQLERROR EXIT ROLLBACK;

variable is_current_version_fine NUMBER;
variable change_version NUMBER;
variable bad_current_version VARCHAR2(1024);

exec :change_version := 145;
exec PROCS_SYSTEM_V16.CHECK_VERSION(:change_version - 1, :is_current_version_fine);
exec :bad_current_version := 'Current version is bad, please update your version to '||(:change_version-1);

alter table product drop (production_cost, product_uri, unit_price);
alter table product_offering drop (tax_category_id, capability_id);
drop table product_eligibility;
drop table product_offering_meta_data;
drop table capability;

EXEC PROCS_SYSTEM_V16.INCREMENT_VERSION();
