WHENEVER SQLERROR EXIT ROLLBACK;

variable is_current_version_fine NUMBER;
variable change_version NUMBER;
variable bad_current_version VARCHAR2(1024);

exec :change_version := 144;
exec PROCS_SYSTEM_V16.CHECK_VERSION(:change_version - 1, :is_current_version_fine);
exec :bad_current_version := 'Current version is bad, please update your version to '||(:change_version-1);

UPDATE
  product p
SET
  (
    entitlement,
    is_shareable
  )
  =
  (
  SELECT
    DECODE(MAX(c.code), 'NONE', NULL, MAX(c.code)),
    MAX(c.shareable)
  FROM
      capability c,
      product_offering po
  WHERE
    po.product_id = p.id
    AND c.id = po.capability_id
  GROUP BY
    po.product_id);

-- products migrated from erights have null tax_category_id, setting it to 2 since everything but crosswords is 2
UPDATE
  product p
SET
  (
    tax_category_id
  )
  =
  (
  SELECT
    DECODE(MAX(tax_category_id), NULL, 2, MAX(tax_category_id))
  FROM
    product_offering po
  WHERE
    po.product_id = p.id
  GROUP BY
    po.product_id);

-- implicit commit
alter table product add constraint product_tax_category_fk foreign key (tax_category_id) references tax_category(id);

EXEC PROCS_SYSTEM_V16.INCREMENT_VERSION();