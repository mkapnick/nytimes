WHENEVER SQLERROR EXIT ROLLBACK;

alter trigger "CORE_OWNER"."TR_GIFT_CERTIFICATE_AUD" enable;

COMMIT;
