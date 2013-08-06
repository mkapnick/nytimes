WHENEVER SQLERROR EXIT ROLLBACK;

variable is_current_version_fine NUMBER;
variable change_version NUMBER;
variable bad_current_version VARCHAR2(1024);

update sys_version set version = 19;

exec :change_version := 20;
exec PROCS_SYSTEM_V14.CHECK_VERSION(:change_version - 1, :is_current_version_fine);
exec :bad_current_version := 'Current version is bad, please update your version to '||(:change_version-1);

BEGIN
  IF (:is_current_version_fine != 0) THEN
    RAISE_APPLICATION_ERROR(-20001, :bad_current_version);
  END IF;
END;
/

CREATE TABLE "CORE_HIST_OWNER"."INVOICE_ADJUSTMENT_HISTORY"
 (    "INVOICE_ADJUSTMENT_ID" NUMBER,
      "INVOICE_ID" NUMBER,
      "IS_CREDIT" NUMBER,
      "CHARGE_ID" NUMBER,
      "ADJUSTMENT_DATE" VARCHAR2(20 BYTE),
      "CREATE_DATE" DATE,
      "CREATED_BY" VARCHAR2(255 BYTE),
      "INVOICE_ADJUSTMENT_REASON_ID" NUMBER,
      "UPDATE_DATE" DATE,
      "UPDATED_BY" VARCHAR2(255 BYTE)
 )
 PARTITION BY RANGE (CREATE_DATE)
  (
      PARTITION invoice_adjustment_max values less than (maxvalue) tablespace "CORE_HIST"
  );

exec PROCS_SYSTEM_V14.INCREMENT_VERSION();
