WHENEVER SQLERROR EXIT ROLLBACK;

variable is_current_version_fine NUMBER;
variable change_version NUMBER;
variable bad_current_version VARCHAR2(1024);

exec :change_version := 140;
exec PROCS_SYSTEM_V16.CHECK_VERSION(:change_version - 1, :is_current_version_fine);
exec :bad_current_version := 'Current version is bad, please update your version to '||(:change_version-1);

INSERT INTO NOTIFICATION_TYPE (ID, VALUE, TEMPLATE_URL)
VALUES (NOTTID_SEQ.NEXTVAL, 'sartre-paypal-expiring-soon', 'N/A');

COMMIT;

update offer_chain set GROUP_ACCOUNT_TYPE_ID = 'FL', UPDATE_DATE = sysdate, UPDATED_BY = 'SAR-439' where id in
(1000002,
1000281,
1000221,
1000231,
1000241,
1000251,
1000481,
1001531,
1001561,
1005731,
1005761,
5801360121,
1036781);

commit;

EXEC PROCS_SYSTEM_V16.INCREMENT_VERSION();
