WHENEVER SQLERROR EXIT ROLLBACK;

variable is_current_version_fine NUMBER;
variable change_version NUMBER;
variable bad_current_version VARCHAR2(1024);

exec :change_version := 137;
exec PROCS_SYSTEM_V16.CHECK_VERSION(:change_version - 1, :is_current_version_fine);
exec :bad_current_version := 'Current version is bad, please update your version to '||(:change_version-1);

BEGIN
  IF (:is_current_version_fine != 0) THEN
    RAISE_APPLICATION_ERROR(-20001, :bad_current_version);
  END IF;
END;
/

CREATE TABLE AMAZON_APPSTORE_ITEM_TYPE (
  ID          VARCHAR2(30) NOT NULL,
  DESCRIPTION VARCHAR2(1000) NOT NULL,
  CREATE_DATE DATE NOT NULL,
  CREATED_BY  VARCHAR2(255) NOT NULL,
  CONSTRAINT AAS_ITEM_TYPE_ID_PK PRIMARY KEY (ID) USING INDEX TABLESPACE CORE_IDX
) TABLESPACE CORE;

INSERT INTO AMAZON_APPSTORE_ITEM_TYPE VALUES ('ENTITLED',    'Amazon App Store Entititlement',SYSDATE,'JIRA-SAR-274');
INSERT INTO AMAZON_APPSTORE_ITEM_TYPE VALUES ('CONSUMABLE',  'Amazon App Store Consumable',   SYSDATE,'JIRA-SAR-274');
INSERT INTO AMAZON_APPSTORE_ITEM_TYPE VALUES ('SUBSCRIPTION','Amazon App Store Subscription', SYSDATE,'JIRA-SAR-274');
COMMIT;

CREATE TABLE AMAZON_APPSTORE (
  ID NUMBER NOT NULL,
  SUBSCRIPTION_ID NUMBER NOT NULL,
  USER_ID VARCHAR2(4000) NOT NULL,
  ITEM_TYPE VARCHAR2(30) NOT NULL,
  START_DATE DATE NOT NULL,
  END_DATE DATE,
  SKU VARCHAR2(4000) NOT NULL,
  PURCHASE_TOKEN VARCHAR2(4000) NOT NULL,
  CREATE_DATE DATE NOT NULL,
  CREATED_BY VARCHAR2(255) NOT NULL,
  UPDATE_DATE DATE NOT NULL,
  UPDATED_BY VARCHAR2(255) NOT NULL,
  CONSTRAINT AAS_PK PRIMARY KEY (ID) USING INDEX TABLESPACE CORE_IDX,
  CONSTRAINT AAS_SUBSCRIPTION_ID_FK FOREIGN KEY (SUBSCRIPTION_ID) REFERENCES SUBSCRIPTION(ID),
  CONSTRAINT AAS_ITEM_TYPE_FK       FOREIGN KEY (ITEM_TYPE) REFERENCES AMAZON_APPSTORE_ITEM_TYPE(ID)
) TABLESPACE CORE;

CREATE INDEX AAS_USER_ID_IDX ON AMAZON_APPSTORE(USER_ID) TABLESPACE CORE_IDX;
CREATE INDEX AAS_SKU_IDX ON AMAZON_APPSTORE(SKU) TABLESPACE CORE_IDX;
CREATE UNIQUE INDEX AAS_PURCHASE_TOKEN_IDX ON AMAZON_APPSTORE(PURCHASE_TOKEN) TABLESPACE CORE_IDX;
CREATE UNIQUE INDEX AAS_SUBSCRIPTION_ID_IDX ON AMAZON_APPSTORE(SUBSCRIPTION_ID) TABLESPACE CORE_IDX;
CREATE SEQUENCE AAS_ID_SEQ;

COMMENT ON COLUMN AMAZON_APPSTORE.ID IS 'Use sequence AAS_ID_SEQ';
COMMENT ON COLUMN AMAZON_APPSTORE.END_DATE IS 'This column is allow to be null b/c that is how the amazon verification service indicates that the subscription is still active';

ALTER TABLE OFFER_CHAIN ADD (
  AMAZON_APPSTORE_SKU VARCHAR2(4000) NULL,
  ITUNES_PRODUCT_ID   VARCHAR2(4000) NULL
);

CREATE UNIQUE INDEX OC_AMAZON_APPSTORE_SKU_IDX ON OFFER_CHAIN(AMAZON_APPSTORE_SKU) TABLESPACE CORE_IDX;
CREATE UNIQUE INDEX OC_ITUNES_PRODUCT_ID_IDX ON OFFER_CHAIN(ITUNES_PRODUCT_ID) TABLESPACE CORE_IDX;

INSERT INTO NOTIFICATION_TYPE (ID, VALUE, TEMPLATE_URL) VALUES (NOTTID_SEQ.NEXTVAL, 'sartre-chase-no-response', 'N/A');
COMMIT;

EXEC PROCS_SYSTEM_V16.INCREMENT_VERSION();

