-- SAR-261: Extend expiration of all generated gift codes for Offer Chain ID 5801360120
WHENEVER SQLERROR EXIT ROLLBACK;
UPDATE
  Gift_Certificate
SET
  Expiration_Date = Add_Months(Create_Date, 60),
  Updated_By      = 'SAR-261',
  Update_Date     = Sysdate
WHERE
  Offer_Chain_Id               = 5801360120
AND Gift_Certificate_Status_Id = 1;

COMMIT;
