WHENEVER SQLERROR EXIT ROLLBACK;

INSERT INTO NOTIFICATION_TYPE (ID, VALUE, TEMPLATE_URL) VALUES (NOTTID_SEQ.NEXTVAL, 'sartre-cc-updater', 'N/A');

COMMIT;




