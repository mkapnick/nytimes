WHENEVER SQLERROR EXIT ROLLBACK;

variable is_current_version_fine NUMBER;
variable change_version NUMBER;
variable bad_current_version VARCHAR2(1024);

exec :change_version := 128;
exec PROCS_SYSTEM_V9.CHECK_VERSION(:change_version - 1, :is_current_version_fine);
exec :bad_current_version := 'Current version is bad, please update your version to '||(:change_version-1);

BEGIN
  IF (:is_current_version_fine != 0) THEN
    RAISE_APPLICATION_ERROR(-20001, :bad_current_version);
  END IF;
END;
/

CREATE TABLE
        NOTIFICATION_STATUS
(
  ID NUMBER NOT NULL,
  VALUE VARCHAR2(32) NOT NULL,
  CONSTRAINT NOTS_PK PRIMARY KEY (ID) USING INDEX TABLESPACE CORE_IDX
) TABLESPACE CORE;
COMMENT ON TABLE NOTIFICATION_STATUS
IS
        'Alias: nots  SENT / PENDING / FAILED';
COMMENT ON COLUMN NOTIFICATION_STATUS.ID
IS
        'nots_id_seq';
COMMENT ON COLUMN NOTIFICATION_STATUS.VALUE
IS
        'SENT / PENDING / FAILED';

CREATE TABLE
        NOTIFICATION_TYPE
(
  ID NUMBER NOT NULL,
  VALUE VARCHAR2(255) NOT NULL,
  TEMPLATE_URL VARCHAR2(2048) NOT NULL,
  CONSTRAINT NOTT_PK PRIMARY KEY (ID) USING INDEX TABLESPACE CORE_IDX,
  CONSTRAINT NOTT_VALUE_U_IDX UNIQUE (VALUE) USING INDEX TABLESPACE CORE_IDX
) TABLESPACE CORE;
COMMENT ON TABLE NOTIFICATION_TYPE
IS
        'Alias: nott  reasons why email needs to be sent';
COMMENT ON COLUMN NOTIFICATION_TYPE.ID
IS
        'nottid_seq';
COMMENT ON COLUMN NOTIFICATION_TYPE.TEMPLATE_URL
IS
        'url of template to be mailed out';

CREATE TABLE
        NOTIFICATION
(
  ID NUMBER NOT NULL,
  ACCOUNT_ID NUMBER NOT NULL,
  GROUP_ID NUMBER,
  NOTIFICATION_TYPE_ID NUMBER NOT NULL,
  NOTIFICATION_STATUS_ID NUMBER NOT NULL,
  CREATE_DATE DATE NOT NULL,
  UPDATE_DATE DATE NOT NULL,
  EMAIL_TEMPLATE_PARAMS CLOB NOT NULL,
  DATE_TO_NOTIFY DATE,
  CONSTRAINT NOT_PK PRIMARY KEY (ID) USING INDEX TABLESPACE CORE_IDX,
  CONSTRAINT NOTS_NOT_FK FOREIGN KEY (NOTIFICATION_STATUS_ID) REFERENCES NOTIFICATION_STATUS
  (ID),
  CONSTRAINT NOTT_NOT_FK FOREIGN KEY (NOTIFICATION_TYPE_ID) REFERENCES NOTIFICATION_TYPE (ID)
) TABLESPACE CORE;
COMMENT ON TABLE NOTIFICATION
IS
        'Alias: not';
COMMENT ON COLUMN NOTIFICATION.ID
IS
        'not_id_seq';

CREATE TABLE
        NOTIFICATION_FAILURE
(
  ID NUMBER NOT NULL,
  NOTIFICATION_ID NUMBER NOT NULL,
  ERROR_MESSAGE VARCHAR2(2048) NOT NULL,
  CREATE_DATE DATE,
  CONSTRAINT NOTF_PK PRIMARY KEY (ID) USING INDEX TABLESPACE CORE_IDX,
  CONSTRAINT NOT_NOTF_FK FOREIGN KEY (NOTIFICATION_ID) REFERENCES NOTIFICATION (ID) ON
  DELETE
  CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE VALIDATE
) TABLESPACE CORE;
COMMENT ON TABLE NOTIFICATION_FAILURE
IS
        'Alias: notf';
COMMENT ON COLUMN NOTIFICATION_FAILURE.ID
IS
        'notf_id_seq';
COMMENT ON COLUMN NOTIFICATION_FAILURE.ERROR_MESSAGE
IS
        'message returned from the api';

CREATE TABLE
        PROCESS_RETRY_THROTTLE
(
  PROCESS_NAME VARCHAR2(100) NOT NULL,
  GENERIC_ID NUMBER NOT NULL,
  RETRY_COUNT NUMBER NOT NULL,
  CREATE_DATE DATE NOT NULL,
  UPDATE_DATE DATE NOT NULL,
  CONSTRAINT PFT_PK PRIMARY KEY (PROCESS_NAME, GENERIC_ID) USING INDEX TABLESPACE CORE_IDX
) TABLESPACE CORE;
COMMENT ON TABLE PROCESS_RETRY_THROTTLE
IS
        'Count the number of times a process retries to process an id';

CREATE INDEX
        NOTF_NOTIF_ID_IDX
ON
        NOTIFICATION_FAILURE
        (
                NOTIFICATION_ID
        );

CREATE INDEX
        NOT_NOTS_ID_IDX
ON
        NOTIFICATION
        (
                NOTIFICATION_STATUS_ID
        );

CREATE INDEX
        NOT_NOTT_ID_IDX
ON
        NOTIFICATION
        (
                NOTIFICATION_TYPE_ID
        );

CREATE INDEX
        PFT_CREATE_DATE_IDX
ON
        PROCESS_RETRY_THROTTLE
        (
                CREATE_DATE
        );

CREATE INDEX
        PFT_UPDATE_DATE_IDX
ON
        PROCESS_RETRY_THROTTLE
        (
                UPDATE_DATE
        );

CREATE SEQUENCE NOT_ID_SEQ START WITH 10000000;
CREATE SEQUENCE NOTF_ID_SEQ START WITH 10000000;
CREATE SEQUENCE NOTS_ID_SEQ START WITH 10000000;
CREATE SEQUENCE NOTTID_SEQ START WITH 10000000;

exec PROCS_SYSTEM_V9.INCREMENT_VERSION();
