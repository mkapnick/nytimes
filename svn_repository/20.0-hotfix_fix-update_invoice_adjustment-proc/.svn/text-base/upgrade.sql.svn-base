CREATE OR REPLACE PACKAGE BODY "PROCS_ADJUSTMENTS_V16" AS

PROCEDURE CREATE_INVOICE_ADJUSTMENT (
  in_invoice_id             IN NUMBER,
  in_adjustment_reason      IN VARCHAR2,
  in_is_credit              IN NUMBER,
  in_charge_id              IN NUMBER,
  in_business_date          IN DATE,
  in_created_by             IN VARCHAR2,
  out_invoice_adjustment_id OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(25) := 'CREATE_INVOICE_ADJUSTMENT';
-- VARIABLES
var_current_date      DATE := SYSDATE;
var_new_entity_id     NUMBER;
var_inv_adj_reason_id NUMBER;
-- EXCEPTIONS
BAD_IN_IS_CREDIT_VALUE EXCEPTION;
DAB_ADJUSTMENT_REASON  EXCEPTION;
BEGIN

  IF in_is_credit != GLOBAL_CONSTANTS_V16.TRUE AND in_is_credit != GLOBAL_CONSTANTS_V16.FALSE THEN
    RAISE BAD_IN_IS_CREDIT_VALUE;
  END IF;
  
  BEGIN
    SELECT
      ID into var_inv_adj_reason_id
    FROM
      INVOICE_ADJUSTMENT_REASON
    WHERE
      UPPER(VALUE) = UPPER(in_adjustment_reason);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE DAB_ADJUSTMENT_REASON;
  END;

  SELECT
    INV_ADJ_ID_SEQ.nextVal into var_new_entity_id
  FROM
    DUAL;
    
  INSERT INTO INVOICE_ADJUSTMENT (
    ID,
    INVOICE_ID,
    INVOICE_ADJUSTMENT_REASON_ID,
    IS_CREDIT,
    CHARGE_ID,
    ADJUSTMENT_DATE,
    CREATE_DATE,
    CREATED_BY, 
    UPDATE_DATE,
    UPDATED_BY
  )
  VALUES (
    var_new_entity_id,
    in_invoice_id,
    var_inv_adj_reason_id,
    in_is_credit,
    in_charge_id,
    in_business_date,
    var_current_date,
    in_created_by,
    var_current_date,
    in_created_by
  );
  
  out_invoice_adjustment_id := var_new_entity_id;

EXCEPTION
WHEN BAD_IN_IS_CREDIT_VALUE THEN
  PROCS_COMMON_V16.THROW_EXCEPTION(APP_EXCEPTION_CODES_V16.INVALID_PARAMETER,
    SPROC_NAME, 'Bad in_is_credit value');
WHEN DAB_ADJUSTMENT_REASON THEN
  PROCS_COMMON_V16.THROW_EXCEPTION(APP_EXCEPTION_CODES_V16.INVALID_PARAMETER,
    SPROC_NAME, 'Bad adjustment reason');
WHEN OTHERS THEN
  PROCS_COMMON_V16.THROW_EXCEPTION(APP_EXCEPTION_CODES_V16.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_INVOICE_ADJUSTMENT;

/******************************************************************************/

PROCEDURE UPDATE_INVOICE_ADJUSTMENT (
    in_invoice_id             IN NUMBER,
    in_original_charge_id     IN NUMBER,
    in_charge_id              IN NUMBER,
    in_updated_by             IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'UPDATE_INVOICE_ADJUSTMENT';
var_invoice_adjustment_id NUMBER;
BEGIN
  SELECT
    id into var_invoice_adjustment_id
  FROM
    INVOICE_ADJUSTMENT
  WHERE INVOICE_ID = in_invoice_id
        AND CHARGE_ID = in_original_charge_id;
    
  --create history
  PROCS_HISTORY_V16.CREATE_INVOICE_ADJ_HISTORY(
    in_invoice_adjustment_id    => var_invoice_adjustment_id,
    in_system_activity_reason_id => GLOBAL_ENUMS_V16.SAC_SYSTEM_APPLIED_RULE
  );
  
  UPDATE INVOICE_ADJUSTMENT 
  SET CHARGE_ID = in_charge_id, UPDATE_DATE=sysdate, UPDATED_BY=in_updated_by  
  WHERE ID = var_invoice_adjustment_id;
    
EXCEPTION
WHEN NO_DATA_FOUND THEN
      NULL;
END UPDATE_INVOICE_ADJUSTMENT;

/******************************************************************************/

PROCEDURE CREATE_LINE_ITEM_ADJUSTMENT (
  in_line_item_id             IN NUMBER,
  in_invoice_adjustment_id    IN NUMBER,
  in_amount                   IN NUMBER,
  in_tax                      IN NUMBER,
  in_discount                 IN NUMBER,
  in_created_by               IN VARCHAR2,
  out_line_item_adjustment_id OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(30) := 'CREATE_LINE_ITEM_ADJUSTMENT';
-- VARIABLES
var_current_date DATE := SYSDATE;
var_new_entity_id NUMBER;
BEGIN

  SELECT
    LI_ADJ_ID_SEQ.nextVal into var_new_entity_id
  FROM
    DUAL;

  INSERT INTO LINE_ITEM_ADJUSTMENT (
    ID,
    LINE_ITEM_ID,
    INVOICE_ADJUSTMENT_ID,
    AMOUNT,
    TAX,
    DISCOUNT,
    CREATE_DATE,
    CREATED_BY
  )
  VALUES (
    var_new_entity_id,
    in_line_item_id,
    in_invoice_adjustment_id,
    in_amount,
    in_tax,
    in_discount,
    var_current_date,
    in_created_by
  );
  
  out_line_item_adjustment_id := var_new_entity_id;

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V16.THROW_EXCEPTION(APP_EXCEPTION_CODES_V16.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_LINE_ITEM_ADJUSTMENT;

/******************************************************************************/

PROCEDURE CREATE_TAX_ADJUSTMENT (
  in_tax_id                  IN NUMBER,
  in_line_item_adjustment_id IN NUMBER,
  in_amount                  IN NUMBER,
  in_created_by              IN VARCHAR2,
  out_tax_adjustment_id      OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(30) := 'CREATE_TAX_ADJUSTMENT';
-- VARIABLES
var_current_date DATE := SYSDATE;
var_new_entity_id NUMBER;
BEGIN

  SELECT
    TAXADJ_ID_SEQ.nextVal into var_new_entity_id
  FROM
    DUAL;

  INSERT INTO TAX_ADJUSTMENT (
    ID,
    TAX_ID,
    LINE_ITEM_ADJUSTMENT_ID,
    AMOUNT,
    CREATE_DATE,
    CREATED_BY
  )
  VALUES (
    var_new_entity_id,
    in_tax_id,
    in_line_item_adjustment_id,
    in_amount,
    var_current_date,
    in_created_by
  );
  
  out_tax_adjustment_id := var_new_entity_id;

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V16.THROW_EXCEPTION(APP_EXCEPTION_CODES_V16.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_TAX_ADJUSTMENT;

/******************************************************************************/

PROCEDURE CREATE_DISCOUNT_LI_ADJUSTMENT (
  in_discount_id             NUMBER,
  in_line_item_id            NUMBER,
  in_line_item_adjustment_id IN NUMBER,
  in_amount                  IN NUMBER,
  in_created_by              IN VARCHAR2,
  out_discount_li_id         OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'CREATE_DISCOUNT_LI_ADJUSTMENT';
-- VARIABLES
var_current_date DATE := SYSDATE;
var_new_entity_id NUMBER;
BEGIN

  SELECT
    DLIADJ_ID_SEQ.nextVal into var_new_entity_id
  FROM
    DUAL;

  INSERT INTO DISCOUNT_LINEITEM_ADJUSTMENT (
    ID,
    DISCOUNT_ID,
    LINE_ITEM_ID,
    LINE_ITEM_ADJUSTMENT_ID,
    AMOUNT,
    CREATE_DATE,
    CREATED_BY
  )
  VALUES (
    var_new_entity_id,
    in_discount_id,
    in_line_item_id,
    in_line_item_adjustment_id,
    in_amount,
    var_current_date,
    in_created_by
  );
  
  out_discount_li_id := var_new_entity_id;

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V16.THROW_EXCEPTION(APP_EXCEPTION_CODES_V16.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_DISCOUNT_LI_ADJUSTMENT;

END PROCS_ADJUSTMENTS_V16;
.
/

