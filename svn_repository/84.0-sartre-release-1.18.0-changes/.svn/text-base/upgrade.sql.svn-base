
-- Custom NYTimes template
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK;


-- START CHANGE SCRIPT #20130711103301: 20130711103301-SAR-428-hermes-data-create-table.sql

CREATE TABLE notification_hermes_data (
  id NUMBER NOT NULL,
  copy VARCHAR(140) NOT NULL,
  link_ref VARCHAR(255),
  link_offset NUMBER DEFAULT 0,
  link_count NUMBER DEFAULT 0,
  CONSTRAINT notification_hermes_data_pk PRIMARY KEY (id)
) TABLESPACE CORE;

COMMENT ON COLUMN notification_hermes_data.id IS 'Use sequence notification_hermes_id_seq';
COMMENT ON COLUMN notification_hermes_data.copy IS 'Text to display in Hermes notification';
COMMENT ON COLUMN notification_hermes_data.link_ref IS 'URL of link to send';
COMMENT ON COLUMN notification_hermes_data.link_offset IS 'Index of first linked character in copy';
COMMENT ON COLUMN notification_hermes_data.link_count IS 'Length of linked text in copy';



INSERT INTO dbdeploy_changelog (change_number, complete_dt, applied_by, description)
VALUES (20130711103301, CURRENT_TIMESTAMP, USER, '20130711103301-SAR-428-hermes-data-create-table.sql');

COMMIT;

-- END CHANGE SCRIPT #20130711103301: 20130711103301-SAR-428-hermes-data-create-table.sql


-- START CHANGE SCRIPT #20130711103310: 20130711103310-SAR-428-alter-notify-table.sql

ALTER TABLE notification_type ADD (
  notification_hermes_data_id NUMBER,
  CONSTRAINT not_typ_hermes_fk FOREIGN KEY (notification_hermes_data_id) REFERENCES notification_hermes_data(id),
  assoc_hermes_id NUMBER,
  CONSTRAINT not_assoc_fk FOREIGN KEY (assoc_hermes_id) REFERENCES notification_type(id)
);
COMMENT ON COLUMN notification_type.notification_hermes_data_id
IS 'If not NULL, this type of notification should also generate a Hermes notification with the data in the referred-to row.';
COMMENT ON COLUMN notification_type.assoc_hermes_id
IS 'If not NULL, new notifications of this type will also insert hermes notifications of the associated type';



INSERT INTO dbdeploy_changelog (change_number, complete_dt, applied_by, description)
VALUES (20130711103310, CURRENT_TIMESTAMP, USER, '20130711103310-SAR-428-alter-notify-table.sql');

COMMIT;

-- END CHANGE SCRIPT #20130711103310: 20130711103310-SAR-428-alter-notify-table.sql


-- START CHANGE SCRIPT #20130711103320: 20130711103320-SAR-428-hermes-sequence.sql

CREATE SEQUENCE notification_hermes_id_seq;



INSERT INTO dbdeploy_changelog (change_number, complete_dt, applied_by, description)
VALUES (20130711103320, CURRENT_TIMESTAMP, USER, '20130711103320-SAR-428-hermes-sequence.sql');

COMMIT;

-- END CHANGE SCRIPT #20130711103320: 20130711103320-SAR-428-hermes-sequence.sql


-- START CHANGE SCRIPT #20130711103330: 20130711103330-SAR-428-hermes-insert-data.sql

-- DML for SAR-428

-- Credit Card Closed (CUPY)
INSERT INTO notification_hermes_data (
  id, copy
) VALUES (
  notification_hermes_id_seq.NEXTVAL, 'The credit card we have on file is no longer valid.'
);
INSERT INTO notification_type (
  id, value, template_url, notification_hermes_data_id, assoc_hermes_id
) VALUES (
  nottid_seq.NEXTVAL, 'hermes-card-expiration', 'N/A', notification_hermes_id_seq.CURRVAL, NULL
);
UPDATE notification_type SET (assoc_hermes_id) = nottid_seq.CURRVAL
WHERE value = 'card_expiration';

-- Transaction Failed (PRE-DUNNING)
INSERT INTO notification_hermes_data (
  id, copy
) VALUES (
  notification_hermes_id_seq.NEXTVAL, 'We are unable to process your subscription payment.'
);
INSERT INTO notification_type (
  id, value, template_url, notification_hermes_data_id, assoc_hermes_id
) VALUES (
  nottid_seq.NEXTVAL, 'hermes-sartre-pre-dunning-hard-decline', 'N/A', notification_hermes_id_seq.CURRVAL, NULL
);
UPDATE notification_type SET (assoc_hermes_id) = nottid_seq.CURRVAL
WHERE value = 'sartre-pre-dunning-hard-decline';

-- Grace Period (GRACE)
INSERT INTO notification_hermes_data (
  id, copy
) VALUES (
  notification_hermes_id_seq.NEXTVAL, 'Final notice:  Your subscription payment is past due.'
);
INSERT INTO notification_type (
  id, value, template_url, notification_hermes_data_id, assoc_hermes_id
) VALUES (
  nottid_seq.NEXTVAL, 'hermes-sartre-grace-ending-soon', 'N/A', notification_hermes_id_seq.CURRVAL, NULL
);
UPDATE notification_type SET (assoc_hermes_id) = nottid_seq.CURRVAL
WHERE value = 'sartre-grace-ending-soon';

-- Entitlement Cancelled
INSERT INTO notification_hermes_data (
  id, copy
) VALUES (
  notification_hermes_id_seq.NEXTVAL, 'Your subscription has been canceled due to non-payment.'
);
INSERT INTO notification_type (
  id, value, template_url, notification_hermes_data_id, assoc_hermes_id
) VALUES (
  nottid_seq.NEXTVAL, 'hermes-close-subscription', 'N/A', notification_hermes_id_seq.CURRVAL, NULL
);

-- cf https://jira.em.nytimes.com/browse/SAR-876
UPDATE notification_type
SET assoc_hermes_id = (
  SELECT id
  FROM notification_type
  WHERE value = 'hermes-close-subscription'
)
WHERE id IN (
  SELECT UNIQUE n.id
  FROM offer_chain_notification_type o
  INNER JOIN notification_type n
  ON o.notification_type_id = n.id
  INNER JOIN action a
  ON o.action_id = a.id
  WHERE a.name = 'CLOSE_SUBSCRIPTION'
);




INSERT INTO dbdeploy_changelog (change_number, complete_dt, applied_by, description)
VALUES (20130711103330, CURRENT_TIMESTAMP, USER, '20130711103330-SAR-428-hermes-insert-data.sql');

COMMIT;

-- END CHANGE SCRIPT #20130711103330: 20130711103330-SAR-428-hermes-insert-data.sql


-- START CHANGE SCRIPT #20130801150223: 20130801150223-ar_balance_applies_create.sql

CREATE TABLE AR_BALANCE_APPLIES (
	  charge_id  NUMBER NOT NULL,
	  invoice_id NUMBER NOT NULL,
	  amount NUMBER NOT NULL,
	  create_date DATE NOT NULL,
	  created_by VARCHAR2(255) NOT NULL
)
TABLESPACE CORE;



INSERT INTO dbdeploy_changelog (change_number, complete_dt, applied_by, description)
VALUES (20130801150223, CURRENT_TIMESTAMP, USER, '20130801150223-ar_balance_applies_create.sql');

COMMIT;

-- END CHANGE SCRIPT #20130801150223: 20130801150223-ar_balance_applies_create.sql


-- START CHANGE SCRIPT #20130801150252: 20130801150252-new_charge_status.sql

INSERT INTO "CORE_OWNER"."CHARGE_STATUS" (ID, VALUE) VALUES (4, 'CAPTURED');
INSERT INTO "CORE_OWNER"."CHARGE_STATUS" (ID, VALUE) VALUES (5, 'FAILED');
INSERT INTO "CORE_OWNER"."CHARGE_STATUS" (ID, VALUE) VALUES (6, 'SETTLED');
INSERT INTO "CORE_OWNER"."CHARGE_STATUS" (ID, VALUE) VALUES (7, 'CHARGEBACK_CLAIM');
INSERT INTO "CORE_OWNER"."CHARGE_STATUS" (ID, VALUE) VALUES (8, 'CHARGEBACK_SETTLED');
INSERT INTO "CORE_OWNER"."CHARGE_STATUS" (ID, VALUE) VALUES (9, 'VOID');



INSERT INTO dbdeploy_changelog (change_number, complete_dt, applied_by, description)
VALUES (20130801150252, CURRENT_TIMESTAMP, USER, '20130801150252-new_charge_status.sql');

COMMIT;

-- END CHANGE SCRIPT #20130801150252: 20130801150252-new_charge_status.sql


-- START CHANGE SCRIPT #20130801150405: 20130801150405-charge_status_log_create.sql

CREATE SEQUENCE CHARGE_STATUS_LOG_ID_SEQ;

CREATE TABLE CHARGE_STATUS_LOG (
	  id NUMBER NOT NULL,
	  charge_id  NUMBER NOT NULL,
	  charge_status_id NUMBER NOT NULL,
	  create_date DATE NOT NULL,
	  created_by VARCHAR2(255) NOT NULL
)
TABLESPACE CORE;



INSERT INTO dbdeploy_changelog (change_number, complete_dt, applied_by, description)
VALUES (20130801150405, CURRENT_TIMESTAMP, USER, '20130801150405-charge_status_log_create.sql');

COMMIT;

-- END CHANGE SCRIPT #20130801150405: 20130801150405-charge_status_log_create.sql


-- START CHANGE SCRIPT #20130801150502: 20130801150502-new_instrument_type.sql

INSERT INTO   "CORE_OWNER"."INSTRUMENT_TYPE" (ID,VALUE) VALUES (6,'Credit');



INSERT INTO dbdeploy_changelog (change_number, complete_dt, applied_by, description)
VALUES (20130801150502, CURRENT_TIMESTAMP, USER, '20130801150502-new_instrument_type.sql');

COMMIT;

-- END CHANGE SCRIPT #20130801150502: 20130801150502-new_instrument_type.sql


-- START CHANGE SCRIPT #20130801150609: 20130801150609-alter_charge_instrument_type_nullable.sql

ALTER TABLE CHARGE modify (instrument_id null);



INSERT INTO dbdeploy_changelog (change_number, complete_dt, applied_by, description)
VALUES (20130801150609, CURRENT_TIMESTAMP, USER, '20130801150609-alter_charge_instrument_type_nullable.sql');

COMMIT;

-- END CHANGE SCRIPT #20130801150609: 20130801150609-alter_charge_instrument_type_nullable.sql
