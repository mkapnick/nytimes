--------------------------------------------------------------------------------
-- DDL for package PROCS_HISTORY
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_HISTORY_V17" AS 

PROCEDURE CREATE_NOTIFICATION_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
  in_notification_id            IN NUMBER,
  in_account_id                 IN NUMBER,
  in_group_id                   IN NUMBER,
  notification_reason_type_id   IN NUMBER,
  notification_status_id        IN NUMBER,
  email_template_params         IN CLOB,
  in_create_date                IN DATE,
  in_date_to_notify             IN DATE
);

PROCEDURE CREATE_NOTIF_FAILURE_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
  in_error_messgae         IN VARCHAR2,
  in_notification_id       IN NUMBER,
  in_create_date           IN DATE
);

END PROCS_HISTORY_V17;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_HISTORY_V17" AS

PROCEDURE CREATE_NOTIFICATION_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
  in_notification_id            IN NUMBER,
  in_account_id                 IN NUMBER,
  in_group_id                   IN NUMBER,
  notification_reason_type_id   IN NUMBER,
  notification_status_id        IN NUMBER,
  email_template_params         IN CLOB,
  in_create_date                IN DATE,
  in_date_to_notify             IN DATE
) AS
SPROC_NAME CONSTANT VARCHAR2(27) := 'CREATE_NOTIFICATION_HISTORY';
BEGIN

  INSERT INTO NOTIFICATION_HISTORY (
    NOTIFICATION_ID,
    ACCOUNT_ID,
    GROUP_ID,
    NOTIFICATION_REASON_TYPE_ID,
    NOTIFICATION_STATUS_ID,
    EMAIL_TEMPLATE_PARAMS,
    CREATE_DATE,
    UPDATE_DATE,
    DATE_TO_NOTIFY 
  ) VALUES (
    in_notification_id,
    in_account_id,
    in_group_id,
    notification_reason_type_id,
    notification_status_id,
    email_template_params,
    in_create_date,
    sysdate,
    in_date_to_notify
  );
  
EXCEPTION
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR,
    SPROC_NAME||': Unknown error: '||SQLERRM);
END CREATE_NOTIFICATION_HISTORY;

/******************************************************************************/

PROCEDURE CREATE_NOTIF_FAILURE_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
  in_error_messgae         IN VARCHAR2,
  in_notification_id IN NUMBER,
  in_create_date           IN DATE
) AS
SPROC_NAME CONSTANT VARCHAR2(28) := 'CREATE_NOTIF_FAILURE_HISTORY';
BEGIN

  INSERT INTO NOTIFICATION_FAILURE_HISTORY (
    ERROR_MESSAGE,
    NOTIFICATION_ID,
    CREATE_DATE,
    UPDATE_DATE
  ) VALUES (
    in_error_messgae,
    in_notification_id,
    in_create_date,
    sysdate
  );

EXCEPTION
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR,
    SPROC_NAME||': Unknown error: '||SQLERRM);
END CREATE_NOTIF_FAILURE_HISTORY;

END PROCS_HISTORY_V17;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_PARTITIONS
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_PARTITIONS_V17" AS 

PROCEDURE GET_PARTITION_YEAR_MONTH (
  in_year   IN NUMBER,
  in_month  IN NUMBER,
  out_year  OUT NUMBER,
  out_month OUT NUMBER
);

PROCEDURE ADD_TABLE_PARTITION (
  in_tablename       IN VARCHAR2,
  in_partitionprefix IN VARCHAR2,
  in_year            IN NUMBER,
  in_month           IN NUMBER
);

PROCEDURE ADD_NOTIFICATION_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
);

PROCEDURE ADD_NOTIF_FAILURE_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
);

END PROCS_PARTITIONS_V17;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_PARTITIONS_V17" AS

PROCEDURE GET_PARTITION_YEAR_MONTH (
  in_year   IN NUMBER,
  in_month  IN NUMBER,
  out_year  OUT NUMBER,
  out_month OUT NUMBER
) AS
BEGIN
  IF in_month < 12 THEN
    out_month := in_month + 1;
    out_year  := in_year;
  ELSIF in_month = 12 THEN
    out_month := 1;
    out_year  := in_year + 1;
  ELSE
    out_month := in_month;
    out_year  := in_year;
  END IF;
END;

/**************************************************************/

PROCEDURE ADD_TABLE_PARTITION (
  in_tablename       IN VARCHAR2,
  in_partitionprefix IN VARCHAR2,
  in_year            IN NUMBER,
  in_month           IN NUMBER
) AS
-- VARIABLES
partision_year  NUMBER;
partision_month NUMBER;
-- CONSTANTS
const_max_prefix CONSTANT VARCHAR(3) := 'max';
BEGIN
  GET_PARTITION_YEAR_MONTH(in_year, in_month, partision_year, partision_month);
  EXECUTE IMMEDIATE 'ALTER TABLE '||in_tablename||' SPLIT PARTITION '||in_partitionprefix||'_'||const_max_prefix||' AT (date '''||partision_year||'-'||partision_month||'-01'') INTO (PARTITION '||in_partitionprefix||'_y'||in_year||'m'||in_month||', PARTITION '||in_partitionprefix||'_'||const_max_prefix||')';
END;

/**************************************************************/

PROCEDURE ADD_NOTIFICATION_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
) AS
-- CONSTANTS
CONST_TABLE_NAME       CONSTANT VARCHAR2(20) := 'NOTIFICATION_HISTORY';
CONST_PARTITION_PREFIX CONSTANT VARCHAR2(12)  := 'notification';
BEGIN
  ADD_TABLE_PARTITION(CONST_TABLE_NAME, CONST_PARTITION_PREFIX, in_year, in_month);
END ADD_NOTIFICATION_PARTITION;

/**************************************************************/

PROCEDURE ADD_NOTIF_FAILURE_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
) AS
-- CONSTANTS
CONST_TABLE_NAME       CONSTANT VARCHAR2(28) := 'NOTIFICATION_FAILURE_HISTORY';
CONST_PARTITION_PREFIX CONSTANT VARCHAR2(20) := 'notification_failure';
BEGIN
  ADD_TABLE_PARTITION(CONST_TABLE_NAME, CONST_PARTITION_PREFIX, in_year, in_month);
END ADD_NOTIF_FAILURE_PARTITION;

END PROCS_PARTITIONS_V17;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_SYSTEM
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_SYSTEM_V17" AS 

PROCEDURE INCREMENT_VERSION;

PROCEDURE CHECK_VERSION(
    in_vers    IN NUMBER,
    out_result OUT NUMBER
);

END PROCS_SYSTEM_V17;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_SYSTEM_V17" AS

PROCEDURE INCREMENT_VERSION
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
AS
BEGIN

  UPDATE SYS_VERSION SET version=version+1;
  
EXCEPTION
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR,
    'Unknown error');
END INCREMENT_VERSION;

/*************************************************************/

PROCEDURE CHECK_VERSION(
    in_vers    IN NUMBER,
    out_result OUT NUMBER
) AS
  current_version NUMBER;
BEGIN
  SELECT version INTO current_version FROM SYS_VERSION;
  IF(current_version != in_vers) THEN
    out_result := 1;
  ELSE
    out_result := 0;
  END IF;
  EXCEPTION
	WHEN OTHERS THEN
	NULL;
END CHECK_VERSION;

END PROCS_SYSTEM_V17;
.
/

--------------------------------------------------------------------------------
-- DDL for package PUBLIC_PROCS_OPS
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PUBLIC_PROCS_OPS_V17" AS 

PROCEDURE CREATE_NOTIFICATION_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
  in_notification_id            IN NUMBER,
  in_account_id                 IN NUMBER,
  in_group_id                   IN NUMBER,
  notification_reason_type_id   IN NUMBER,
  notification_status_id        IN NUMBER,
  email_template_params         IN CLOB,
  in_create_date                IN DATE,
  in_date_to_notify             IN DATE
);

PROCEDURE CREATE_NOTIF_FAILURE_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
  in_error_message         IN VARCHAR2,
  in_notification_id       IN NUMBER,
  in_create_date           IN DATE
);

END PUBLIC_PROCS_OPS_V17;
.
/

CREATE OR REPLACE PACKAGE BODY "PUBLIC_PROCS_OPS_V17" AS

PROCEDURE CREATE_NOTIFICATION_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
  in_notification_id            IN NUMBER,
  in_account_id                 IN NUMBER,
  in_group_id                   IN NUMBER,
  notification_reason_type_id   IN NUMBER,
  notification_status_id        IN NUMBER,
  email_template_params         IN CLOB,
  in_create_date                IN DATE,
  in_date_to_notify             IN DATE
) AS
BEGIN
  PROCS_HISTORY_V17.CREATE_NOTIFICATION_HISTORY(
    in_notification_id,
    in_account_id,
    in_group_id,
    notification_reason_type_id,
    notification_status_id,
    email_template_params,
    in_create_date,
    in_date_to_notify
  );
END CREATE_NOTIFICATION_HISTORY;

/******************************************************/

PROCEDURE CREATE_NOTIF_FAILURE_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
  in_error_message         IN VARCHAR2,
  in_notification_id       IN NUMBER,
  in_create_date           IN DATE
) AS
BEGIN
  PROCS_HISTORY_V17.CREATE_NOTIF_FAILURE_HISTORY(
    in_error_message,
    in_notification_id,
    in_create_date
  );
END CREATE_NOTIF_FAILURE_HISTORY;

END PUBLIC_PROCS_OPS_V17;
.
/

GRANT EXECUTE ON PUBLIC_PROCS_OPS_V17 TO ops_owner;
GRANT EXECUTE ON PUBLIC_PROCS_OPS_V17 TO ops_aaa_app;
GRANT EXECUTE ON PUBLIC_PROCS_OPS_V17 TO ops_payment_app;
GRANT EXECUTE ON PUBLIC_PROCS_OPS_V17 TO ops_notif_app;

grant select on OPS_HIST_OWNER.NOTIFICATION_FAILURE_HISTORY to core_hist_owner;
grant select on OPS_HIST_OWNER.NOTIFICATION_HISTORY to core_hist_owner;