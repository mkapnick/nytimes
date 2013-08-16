-- START CHANGE SCRIPT #20130801152708: 20130801152708-alter_ar_balance_indexes.sql

delete from
ar_balance_applies a
where
a.rowid >
any (select b.rowid
	from
	ar_balance_applies b
	where
	a.charge_id = b.charge_id
	and
	a.invoice_id = B.invoice_id
)
;
commit;

ALTER TABLE AR_BALANCE_APPLIES ADD CONSTRAINT AR_APPLIES_PK PRIMARY KEY (CHARGE_ID, INVOICE_ID) ;
ALTER TABLE AR_BALANCE_APPLIES ADD CONSTRAINT AR_APPLIES_CHARGEID_FK FOREIGN KEY (CHARGE_ID) REFERENCES CHARGE (ID);
ALTER TABLE AR_BALANCE_APPLIES ADD CONSTRAINT AR_APPLIES_INVID_FK FOREIGN KEY (INVOICE_ID) REFERENCES INVOICE (ID);
CREATE INDEX AR_BAL_APPLIES_CID_IDX ON AR_BALANCE_APPLIES (CHARGE_ID) TABLESPACE CORE_IDX;
CREATE INDEX AR_BAL_APPLIES_IID_IDX ON AR_BALANCE_APPLIES (INVOICE_ID) TABLESPACE CORE_IDX;



INSERT INTO dbdeploy_changelog (change_number, complete_dt, applied_by, description)
VALUES (20130801152708, CURRENT_TIMESTAMP, USER, '20130801152708-alter_ar_balance_indexes.sql');

COMMIT;

-- END CHANGE SCRIPT #20130801152708: 20130801152708-alter_ar_balance_indexes.sql


-- START CHANGE SCRIPT #20130801152742: 20130801152742-alter_charge_status_indexes.sql

ALTER TABLE CHARGE_STATUS_LOG ADD CONSTRAINT CHARGE_STATUS_LOG_PK PRIMARY KEY (ID);
ALTER TABLE CHARGE_STATUS_LOG ADD CONSTRAINT CHARGE_STATUS_LOG_CRG_ID_FK FOREIGN KEY (CHARGE_ID) REFERENCES CHARGE (ID);
ALTER TABLE CHARGE_STATUS_LOG ADD CONSTRAINT CHARGE_STATUS_LOG_CSSTAT_ID_FK FOREIGN KEY (CHARGE_STATUS_ID) REFERENCES CHARGE_STATUS (ID);
CREATE INDEX CHARGE_STATUS_LOG_CID_IDX ON CHARGE_STATUS_LOG (CHARGE_ID) TABLESPACE CORE_IDX;



INSERT INTO dbdeploy_changelog (change_number, complete_dt, applied_by, description)
VALUES (20130801152742, CURRENT_TIMESTAMP, USER, '20130801152742-alter_charge_status_indexes.sql');

COMMIT;

-- END CHANGE SCRIPT #20130801152742: 20130801152742-alter_charge_status_indexes.sql

