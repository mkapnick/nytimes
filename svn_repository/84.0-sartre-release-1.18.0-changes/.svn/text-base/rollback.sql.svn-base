-- START UNDO OF CHANGE SCRIPT #20130801150609: 20130801150609-alter_charge_instrument_type_nullable.sql


ALTER TABLE CHARGE modify (instrument_id not null);


DELETE FROM dbdeploy_changelog WHERE change_number = 20130801150609;

COMMIT;

-- END UNDO OF CHANGE SCRIPT #20130801150609: 20130801150609-alter_charge_instrument_type_nullable.sql


-- START UNDO OF CHANGE SCRIPT #20130801150502: 20130801150502-new_instrument_type.sql

delete from INSTRUMENT_TYPE where id=6;


DELETE FROM dbdeploy_changelog WHERE change_number = 20130801150502;

COMMIT;

-- END UNDO OF CHANGE SCRIPT #20130801150502: 20130801150502-new_instrument_type.sql


-- START UNDO OF CHANGE SCRIPT #20130801150405: 20130801150405-charge_status_log_create.sql

drop table CHARGE_STATUS_LOG;
drop sequence CHARGE_STATUS_LOG_ID_SEQ;


DELETE FROM dbdeploy_changelog WHERE change_number = 20130801150405;

COMMIT;

-- END UNDO OF CHANGE SCRIPT #20130801150405: 20130801150405-charge_status_log_create.sql


-- START UNDO OF CHANGE SCRIPT #20130801150252: 20130801150252-new_charge_status.sql

delete from CHARGE_STATUS where id=4;
delete from CHARGE_STATUS where id=5;
delete from CHARGE_STATUS where id=6;
delete from CHARGE_STATUS where id=7;
delete from CHARGE_STATUS where id=8;
delete from CHARGE_STATUS where id=9;


DELETE FROM dbdeploy_changelog WHERE change_number = 20130801150252;

COMMIT;

-- END UNDO OF CHANGE SCRIPT #20130801150252: 20130801150252-new_charge_status.sql


-- START UNDO OF CHANGE SCRIPT #20130801150223: 20130801150223-ar_balance_applies_create.sql

DROP TABLE AR_BALANCE_APPLIES;


DELETE FROM dbdeploy_changelog WHERE change_number = 20130801150223;

COMMIT;

-- END UNDO OF CHANGE SCRIPT #20130801150223: 20130801150223-ar_balance_applies_create.sql


-- START UNDO OF CHANGE SCRIPT #20130711103330: 20130711103330-SAR-428-hermes-insert-data.sql


UPDATE notification_type SET (assoc_hermes_id) = NULL;

DELETE FROM notification_type WHERE value IN (
  'hermes-card-expiration', 'hermes-sartre-pre-dunning-hard-decline',
  'hermes-sartre-grace-ending-soon', 'hermes-close-subscription');

DELETE FROM notification_hermes_data;


DELETE FROM dbdeploy_changelog WHERE change_number = 20130711103330;

COMMIT;

-- END UNDO OF CHANGE SCRIPT #20130711103330: 20130711103330-SAR-428-hermes-insert-data.sql


-- START UNDO OF CHANGE SCRIPT #20130711103320: 20130711103320-SAR-428-hermes-sequence.sql


DROP SEQUENCE notification_hermes_id_seq;


DELETE FROM dbdeploy_changelog WHERE change_number = 20130711103320;

COMMIT;

-- END UNDO OF CHANGE SCRIPT #20130711103320: 20130711103320-SAR-428-hermes-sequence.sql


-- START UNDO OF CHANGE SCRIPT #20130711103310: 20130711103310-SAR-428-alter-notify-table.sql


ALTER TABLE notification_type DROP CONSTRAINT not_typ_hermes_fk;
ALTER TABLE notification_type DROP CONSTRAINT not_assoc_fk;
ALTER TABLE notification_type DROP COLUMN notification_hermes_data_id;
ALTER TABLE notification_type DROP COLUMN assoc_hermes_id;


DELETE FROM dbdeploy_changelog WHERE change_number = 20130711103310;

COMMIT;

-- END UNDO OF CHANGE SCRIPT #20130711103310: 20130711103310-SAR-428-alter-notify-table.sql


-- START UNDO OF CHANGE SCRIPT #20130711103301: 20130711103301-SAR-428-hermes-data-create-table.sql


DROP TABLE notification_hermes_data;


DELETE FROM dbdeploy_changelog WHERE change_number = 20130711103301;

COMMIT;

-- END UNDO OF CHANGE SCRIPT #20130711103301: 20130711103301-SAR-428-hermes-data-create-table.sql

