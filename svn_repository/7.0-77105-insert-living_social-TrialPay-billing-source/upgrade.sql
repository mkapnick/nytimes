-- Bugzilla ticket:  76067 & 77105
WHENEVER SQLERROR EXIT ROLLBACK;

BEGIN
  INSERT INTO billing_source (id, name) VALUES (14,'DD-LivingSocial');
EXCEPTION
  WHEN dup_val_on_index
    THEN
      NULL; -- Intentionally ignore duplicates
END;
/
COMMIT;

BEGIN
  INSERT INTO billing_source (id, name) VALUES (15,'DD-TrialPay');
EXCEPTION
  WHEN dup_val_on_index
    THEN
      NULL; -- Intentionally ignore duplicates
END;
/
COMMIT;




