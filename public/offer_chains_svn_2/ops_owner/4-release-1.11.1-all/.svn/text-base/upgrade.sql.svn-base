--------------------------------------------------------------------------------
-- DDL for package NOTIFICATION_STATUSES
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "NOTIFICATION_STATUSES_V17" AS 

----
-- NOTIFICATION STATUSES

NOTIFICATION_SENT    CONSTANT NUMBER := 1;
NOTIFICATION_PENDING CONSTANT NUMBER := 2;
NOTIFICATION_FAILED  CONSTANT NUMBER := 3;

END NOTIFICATION_STATUSES_V17;
.
/



--------------------------------------------------------------------------------
-- DDL for package PROCS_COMMON
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_COMMON_V17" AS 

FUNCTION GENERATE_EXCEPTION_MESSAGE(
  in_sproc_name       IN VARCHAR2,
  in_error_message    IN VARCHAR2,
  in_error_stacktrace IN VARCHAR2 DEFAULT NULL
) RETURN VARCHAR2;

PROCEDURE THROW_EXCEPTION(
  in_exception_code   IN NUMBER,
  in_sproc_name       IN VARCHAR2,
  in_error_message    IN VARCHAR2,
  in_error_stacktrace IN VARCHAR2 DEFAULT NULL
);

END PROCS_COMMON_V17;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_COMMON_V17" AS

FUNCTION GENERATE_EXCEPTION_MESSAGE(
  in_sproc_name       IN VARCHAR2,
  in_error_message    IN VARCHAR2,
  in_error_stacktrace IN VARCHAR2 DEFAULT NULL
) RETURN VARCHAR2 AS
BEGIN
  IF in_error_stacktrace IS NOT NULL THEN
    RETURN in_sproc_name || ': ' || in_error_message || ': ' || chr(10) || in_error_stacktrace;
  END IF;
  RETURN
    in_sproc_name || ': ' || in_error_message;
END GENERATE_EXCEPTION_MESSAGE;

/******************************************************************************/

PROCEDURE THROW_EXCEPTION(
  in_exception_code   IN NUMBER,
  in_sproc_name       IN VARCHAR2,
  in_error_message    IN VARCHAR2,
  in_error_stacktrace IN VARCHAR2 DEFAULT NULL
) AS
BEGIN
  RAISE_APPLICATION_ERROR(in_exception_code, GENERATE_EXCEPTION_MESSAGE(in_sproc_name, in_error_message, in_error_stacktrace));
END;

END PROCS_COMMON_V17;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_NOTIFICATION
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_NOTIFICATION_V17" AS 

PROCEDURE GET_NOTIFICATION_TYPE_BY_NAME (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V17.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
  in_notification_type_name IN VARCHAR2,
  out_notification_type_id  OUT NUMBER
);

PROCEDURE ADD_NOTIFICATION (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V17.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
  in_sender_account_id     IN NUMBER DEFAULT 0,
  in_recipient_group_id    IN NUMBER,
  in_notification_type_id  IN NUMBER,
  in_date_to_notify        IN DATE,
  in_email_template_params IN CLOB
);

PROCEDURE GET_PENDING_NOTIFICATIONS (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE UPDATE_NOTIFICATION_TIMESTAMP (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V17.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
  in_notification_id IN NUMBER
);

PROCEDURE SET_NOTIFICATION_STATUS (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V17.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
  in_notification_id        IN NUMBER,
  in_notification_status_id IN NUMBER,
  in_error_message          IN VARCHAR2
);

PROCEDURE ADD_NOTIFICATION_FAILURE (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V17.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
  in_notification_id IN NUMBER,
  in_error_message   IN VARCHAR2
);

PROCEDURE LOCK_PENDING_NOTIFICATION (
/*
Result: 1 if notification locked
2 - else
*/
  in_notification_id IN NUMBER,
  out_lock_status    OUT NUMBER
);

PROCEDURE GET_NOTIFICATION_DATA (
  in_notification_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
);

END PROCS_NOTIFICATION_V17;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_NOTIFICATION_V17" AS

PROCEDURE GET_NOTIFICATION_TYPE_BY_NAME (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V17.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
  in_notification_type_name IN VARCHAR2,
  out_notification_type_id  OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_NOTIFICATION_TYPE_BY_NAME';
BEGIN
  SELECT
    NOTIFICATION_TYPE.ID into out_notification_type_id
  FROM
    NOTIFICATION_TYPE
  WHERE
    NOTIFICATION_TYPE.VALUE = in_notification_type_name;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V17.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V17.NOT_FOUND,
    SPROC_NAME, 'No such type');
WHEN OTHERS THEN
  PROCS_COMMON_V17.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_NOTIFICATION_TYPE_BY_NAME;

/******************************************************************/

PROCEDURE ADD_NOTIFICATION (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V17.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
  in_sender_account_id     IN NUMBER DEFAULT 0,
  in_recipient_group_id    IN NUMBER,
  in_notification_type_id  IN NUMBER,
  in_date_to_notify        IN DATE,
  in_email_template_params IN CLOB
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'ADD_NOTIFICATION';
-- VARIABLES
temp_type_count NUMBER;
var_create_date DATE := SYSDATE;
-- EXCEPTIONS
BAD_NOTIFICATION_TYPE_ID EXCEPTION;
CAN_NOT_CREATE_HISTORY   EXCEPTION;
EXCEPTION_MESSAGE        VARCHAR2(1024);
BEGIN

  SELECT
    COUNT(*) into temp_type_count
  FROM
    NOTIFICATION_TYPE
  WHERE
    NOTIFICATION_TYPE.ID = in_notification_type_id;
    
  IF temp_type_count = 0 THEN
    RAISE BAD_NOTIFICATION_TYPE_ID;
  END IF;

  INSERT INTO NOTIFICATION (
    ID,
    ACCOUNT_ID,
    GROUP_ID,
    NOTIFICATION_TYPE_ID,
    NOTIFICATION_STATUS_ID,
    EMAIL_TEMPLATE_PARAMS,
    UPDATE_DATE,
    CREATE_DATE,
    DATE_TO_NOTIFY
  ) VALUES (
    NOT_ID_SEQ.nextVal,
    in_sender_account_id, 
    in_recipient_group_id,
    in_notification_type_id,
    NOTIFICATION_STATUSES_V17.NOTIFICATION_PENDING,
    in_email_template_params,
    var_create_date,
    var_create_date,
    in_date_to_notify
  );
  
  --BEGIN
  --  OPS_HIST_OWNER.PUBLIC_PROCS_OPS_V17.CREATE_NOTIFICATION_HISTORY (
  --    in_account_id               => 0, -- ACCOUNT_ID. Can we delete it?
  --    in_group_id                 => in_recipient_group_id,
  --    notification_reason_type_id => in_notification_type_id,
  --    notification_status_id      => NOTIFICATION_STATUSES_V17.NOTIFICATION_PENDING,
  --    email_template_params       => in_email_template_params,
  --    in_create_date              => var_create_date
  --  );
  --  EXCEPTION
  --    WHEN OTHERS THEN
  --      EXCEPTION_MESSAGE := SQLERRM;
  --      RAISE CAN_NOT_CREATE_HISTORY;
  --END;
  
EXCEPTION
WHEN BAD_NOTIFICATION_TYPE_ID THEN
  PROCS_COMMON_V17.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V17.NOT_FOUND,
    SPROC_NAME, 'No such notification status');
WHEN CAN_NOT_CREATE_HISTORY THEN
  PROCS_COMMON_V17.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V17.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create history', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V17.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END ADD_NOTIFICATION;

/******************************************************************************/

PROCEDURE GET_PENDING_NOTIFICATIONS (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_PENDING_NOTIFICATIONS';
-- CONSTANTS
C_NOTIFICATION_COUNT_LIMIT CONSTANT NUMBER := 500;
BEGIN
  OPEN out_result_set FOR
SELECT * FROM
(
  SELECT
    NOTIFICATION.ID
  FROM
    NOTIFICATION
    INNER JOIN NOTIFICATION_TYPE ON NOTIFICATION.NOTIFICATION_TYPE_ID = NOTIFICATION_TYPE.ID
  WHERE
    ROWNUM <= C_NOTIFICATION_COUNT_LIMIT*10
    AND NOT EXISTS (
      SELECT NULL
      FROM OPS_OWNER.PROCESS_RETRY_THROTTLE
      WHERE GENERIC_ID = NOTIFICATION.ID AND PROCESS_NAME = SPROC_NAME
    )
    AND (
      NOTIFICATION.NOTIFICATION_STATUS_ID = NOTIFICATION_STATUSES_V17.NOTIFICATION_PENDING
      OR NOTIFICATION.NOTIFICATION_STATUS_ID = NOTIFICATION_STATUSES_V17.NOTIFICATION_FAILED
    )
    AND (
      NOTIFICATION.DATE_TO_NOTIFY IS NULL OR SYSDATE > NOTIFICATION.DATE_TO_NOTIFY
    )ORDER BY dbms_random.value
) WHERE
  ROWNUM <= C_NOTIFICATION_COUNT_LIMIT;

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V17.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_PENDING_NOTIFICATIONS;

/******************************************************************************/

PROCEDURE UPDATE_NOTIFICATION_TIMESTAMP (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V17.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
  in_notification_id IN NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'UPDATE_NOTIFICATION_TIMESTAMP';
-- VARIABLES
temp_notification_id NUMBER;
-- EXCEPTIONS
BAD_NOTIFICATION_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      NOTIFICATION.ID into temp_notification_id
    FROM
      NOTIFICATION
    WHERE
      NOTIFICATION.ID = in_notification_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_NOTIFICATION_ID;
  END;
  
  UPDATE
    NOTIFICATION
  SET
    NOTIFICATION.UPDATE_DATE = sysdate
  WHERE
    NOTIFICATION.ID = in_notification_id;

EXCEPTION
WHEN BAD_NOTIFICATION_ID THEN
  PROCS_COMMON_V17.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V17.NOT_FOUND,
    SPROC_NAME, 'No such notification');
WHEN OTHERS THEN
  PROCS_COMMON_V17.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END UPDATE_NOTIFICATION_TIMESTAMP;

/******************************************************************************/

PROCEDURE SET_NOTIFICATION_STATUS (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V17.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
  in_notification_id        IN NUMBER,
  in_notification_status_id IN NUMBER,
  in_error_message          IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'SET_NOTIFICATION_STATUS';
-- VARIABLES
var_group_id              NUMBER;
var_account_id            NUMBER;
var_notification_type_id  NUMBER;
var_email_template_params CLOB;
var_create_history_date   DATE := SYSDATE;
var_notification_status_id   NUMBER;
var_date_to_notify        DATE;
max_fails   NUMBER := 5;
num_fails   NUMBER;
-- EXCEPTIONS
BAD_NOTIFICATION_ID        EXCEPTION;
BAD_NOTIFICATION_STATUS_ID EXCEPTION;
CAN_NOT_CREATE_HISTORY     EXCEPTION;
EXCEPTION_MESSAGE          VARCHAR2(1024);
BEGIN

  IF in_notification_status_id != NOTIFICATION_STATUSES_V17.NOTIFICATION_SENT
    AND in_notification_status_id != NOTIFICATION_STATUSES_V17.NOTIFICATION_PENDING
    AND in_notification_status_id != NOTIFICATION_STATUSES_V17.NOTIFICATION_FAILED THEN
    RAISE BAD_NOTIFICATION_STATUS_ID;
  END IF;

  BEGIN
    SELECT
      NOTIFICATION.GROUP_ID,
      NOTIFICATION.ACCOUNT_ID,
      NOTIFICATION.NOTIFICATION_TYPE_ID,
      NOTIFICATION.NOTIFICATION_STATUS_ID,
      NOTIFICATION.EMAIL_TEMPLATE_PARAMS,
      NOTIFICATION.DATE_TO_NOTIFY
      into
      var_group_id,
      var_account_id,
      var_notification_type_id,
      var_notification_status_id,
      var_email_template_params,
      var_date_to_notify
    FROM
      NOTIFICATION
    WHERE
      NOTIFICATION.ID = in_notification_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_NOTIFICATION_ID;
  END;

  BEGIN
    OPS_HIST_OWNER.PUBLIC_PROCS_OPS_V17.CREATE_NOTIFICATION_HISTORY (
      in_notification_id          => in_notification_id,
      in_account_id               => var_account_id,
      in_group_id                 => var_group_id,
      notification_reason_type_id => var_notification_type_id,
      notification_status_id      => var_notification_status_id,
      email_template_params       => var_email_template_params,
      in_create_date              => var_create_history_date,
      in_date_to_notify           => var_date_to_notify
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_HISTORY;
  END;

  UPDATE
    NOTIFICATION
  SET
    NOTIFICATION.NOTIFICATION_STATUS_ID = in_notification_status_id,
    NOTIFICATION.UPDATE_DATE = sysdate
  WHERE
    NOTIFICATION.ID = in_notification_id;

  IF ( in_error_message IS NOT NULL ) THEN
    ADD_NOTIFICATION_FAILURE(
      in_notification_id => in_notification_id,
      in_error_message => in_error_message
    );
  END IF;

  SELECT COUNT(1) INTO num_fails
  FROM NOTIFICATION_FAILURE
  WHERE NOTIFICATION_ID = in_notification_id;

  IF (in_notification_status_id = NOTIFICATION_STATUSES_V17.NOTIFICATION_SENT OR num_fails >= max_fails) then
    FOR REC IN (
        SELECT ID, NOTIFICATION_ID, ERROR_MESSAGE, CREATE_DATE
        FROM NOTIFICATION_FAILURE
        WHERE NOTIFICATION_ID = in_notification_id
        ) LOOP
        BEGIN
          OPS_HIST_OWNER.PUBLIC_PROCS_OPS_V17.CREATE_NOTIF_FAILURE_HISTORY(
            in_error_message         => REC.ERROR_MESSAGE,
            in_notification_id       => REC.NOTIFICATION_ID,
            in_create_date           => REC.CREATE_DATE
          );
          EXCEPTION
            WHEN OTHERS THEN
              EXCEPTION_MESSAGE := SQLERRM;
              RAISE CAN_NOT_CREATE_HISTORY;
        END;
    END LOOP;
    DELETE FROM NOTIFICATION_FAILURE WHERE NOTIFICATION_ID = in_notification_id;

    BEGIN
      SELECT
        NOTIFICATION.GROUP_ID,
        NOTIFICATION.ACCOUNT_ID,
        NOTIFICATION.NOTIFICATION_TYPE_ID,
        NOTIFICATION.NOTIFICATION_STATUS_ID,
        NOTIFICATION.EMAIL_TEMPLATE_PARAMS,
        NOTIFICATION.DATE_TO_NOTIFY
        into
        var_group_id,
        var_account_id,
        var_notification_type_id,
        var_notification_status_id,
        var_email_template_params,
        var_date_to_notify
      FROM
        NOTIFICATION
      WHERE
        NOTIFICATION.ID = in_notification_id;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          RAISE BAD_NOTIFICATION_ID;
    END;

    BEGIN
      OPS_HIST_OWNER.PUBLIC_PROCS_OPS_V17.CREATE_NOTIFICATION_HISTORY (
        in_notification_id          => in_notification_id,
        in_account_id               => var_account_id,
        in_group_id                 => var_group_id,
        notification_reason_type_id => var_notification_type_id,
        notification_status_id      => var_notification_status_id,
        email_template_params       => var_email_template_params,
        in_create_date              => var_create_history_date,
        in_date_to_notify           => var_date_to_notify
      );
      EXCEPTION
        WHEN OTHERS THEN
          EXCEPTION_MESSAGE := SQLERRM;
          RAISE CAN_NOT_CREATE_HISTORY;
    END;
 
    DELETE FROM NOTIFICATION WHERE ID = in_notification_id;
    
  END IF;
  commit;

EXCEPTION
WHEN BAD_NOTIFICATION_STATUS_ID THEN
  PROCS_COMMON_V17.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V17.NOT_FOUND,
    SPROC_NAME, 'Bad notification status');
WHEN BAD_NOTIFICATION_ID THEN
  PROCS_COMMON_V17.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V17.NOT_FOUND,
    SPROC_NAME, 'No such notification');
WHEN CAN_NOT_CREATE_HISTORY THEN
  PROCS_COMMON_V17.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V17.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create history', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V17.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END SET_NOTIFICATION_STATUS;

/******************************************************************************/

PROCEDURE ADD_NOTIFICATION_FAILURE (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V17.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
  in_notification_id IN NUMBER,
  in_error_message   IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'ADD_NOTIFICATION_FAILURE';
-- VARIABLES
temp_notification_id NUMBER;
var_create_date      DATE := SYSDATE;
-- EXCEPTIONS
BAD_NOTIFICATION_ID        EXCEPTION;
CAN_NOT_CREATE_HISTORY     EXCEPTION;
EXCEPTION_MESSAGE          VARCHAR2(1024);
BEGIN

  BEGIN
    SELECT
      NOTIFICATION.ID into temp_notification_id
    FROM
      NOTIFICATION
    WHERE
      NOTIFICATION.ID = in_notification_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_NOTIFICATION_ID;
  END;
  
  INSERT INTO NOTIFICATION_FAILURE (
    ID,
    NOTIFICATION_ID,
    ERROR_MESSAGE,
    CREATE_DATE
  ) VALUES (
    NOTF_ID_SEQ.nextVal,
    in_notification_id,
    in_error_message,
    sysdate
  );
  
  --BEGIN
  --  OPS_HIST_OWNER.PUBLIC_PROCS_OPS_V17.CREATE_NOTIF_FAILURE_HISTORY(
  --    in_error_message         => in_error_message,
  --    in_notification_queue_id => in_notification_id,
  --    in_create_date           => var_create_date
  --  );
  --  EXCEPTION
  --    WHEN OTHERS THEN
  --      EXCEPTION_MESSAGE := SQLERRM;
  --      RAISE CAN_NOT_CREATE_HISTORY;
  --END;
  
EXCEPTION
WHEN BAD_NOTIFICATION_ID THEN
  PROCS_COMMON_V17.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V17.NOT_FOUND,
    SPROC_NAME, 'No such notification');
WHEN CAN_NOT_CREATE_HISTORY THEN
  PROCS_COMMON_V17.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V17.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create history', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V17.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END ADD_NOTIFICATION_FAILURE;

/******************************************************************************/

PROCEDURE LOCK_PENDING_NOTIFICATION (
/*
Result: GLOBAL_STATUSES.TRUE if notification locked
GLOBA_STATUSES.FALSE - else
*/
  in_notification_id IN NUMBER,
  out_lock_status    OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(25) := 'LOCK_PENDING_NOTIFICATION';
-- VARIABLE
temp_notification_id NUMBER;
BEGIN
  SELECT
    NOTIFICATION.ID into temp_notification_id
  FROM
    NOTIFICATION
  WHERE
    NOTIFICATION.ID = in_notification_id
    AND (
      NOTIFICATION.NOTIFICATION_STATUS_ID = NOTIFICATION_STATUSES_V17.NOTIFICATION_PENDING
      OR NOTIFICATION.NOTIFICATION_STATUS_ID = NOTIFICATION_STATUSES_V17.NOTIFICATION_FAILED
    )
  FOR UPDATE;

  out_lock_status := 1;

EXCEPTION
WHEN NO_DATA_FOUND THEN
  out_lock_status := 0;
WHEN OTHERS THEN
  PROCS_COMMON_V17.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END LOCK_PENDING_NOTIFICATION;

/******************************************************************************/

PROCEDURE GET_NOTIFICATION_DATA (
  in_notification_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(21) := 'GET_NOTIFICATION_DATA';
BEGIN
  OPEN out_result_set FOR
  SELECT
    NOTIFICATION.ID,
    NOTIFICATION.GROUP_ID,
    NOTIFICATION.EMAIL_TEMPLATE_PARAMS,
    NOTIFICATION.NOTIFICATION_STATUS_ID,
    NOTIFICATION.CREATE_DATE,
    NOTIFICATION.UPDATE_DATE,
    NOTIFICATION.NOTIFICATION_TYPE_ID,
    NOTIFICATION_TYPE.VALUE as "TYPE_VALUE",
    NOTIFICATION_TYPE.TEMPLATE_URL
  FROM
    NOTIFICATION
    INNER JOIN NOTIFICATION_TYPE ON NOTIFICATION.NOTIFICATION_TYPE_ID = NOTIFICATION_TYPE.ID
  WHERE
    NOTIFICATION.ID = in_notification_id;

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V17.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_NOTIFICATION_DATA;

END PROCS_NOTIFICATION_V17;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_PROCESS_RETRY_THROTTLE
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_PROCESS_RETRY_V17" AS

PROCEDURE LOG_RETRY(
    in_process_name IN VARCHAR2,
    in_generic_id   IN NUMBER,
    in_date         IN VARCHAR2,
    out_success      OUT NUMBER
);

PROCEDURE LOG_RETRY_DATE(
    in_process_name IN VARCHAR2,
    in_generic_id   IN NUMBER,
    in_date         IN DATE,
    out_success      OUT NUMBER
);

PROCEDURE DELETE_RETRY(
    in_process_name IN VARCHAR2,
    in_remove_minutes  IN NUMBER
);

PROCEDURE GET_SYSDATE (
    out_date OUT VARCHAR2
);

END PROCS_PROCESS_RETRY_V17;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_PROCESS_RETRY_V17" AS

PROCEDURE LOG_RETRY(
    in_process_name IN VARCHAR2,
    in_generic_id   IN NUMBER,
    in_date         IN VARCHAR2,
    out_success      OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'PROCS_PROCESS_RETRY_V17';
BEGIN

  out_success := 1;
  INSERT into PROCESS_RETRY_THROTTLE(process_name, generic_id, RETRY_count, create_date, update_date)
  VALUES (in_process_name, in_generic_id, 1, to_date(in_date, 'DD-Mon-YYYY HH24:MI:SS'), sysdate);
  commit;
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
  rollback;
  out_success := 0;
WHEN OTHERS THEN
  rollback;
  PROCS_COMMON_V17.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);

END;

PROCEDURE LOG_RETRY_DATE(
    in_process_name IN VARCHAR2,
    in_generic_id   IN NUMBER,
    in_date         IN DATE,
    out_success      OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'PROCS_PROCESS_RETRY_V17';
BEGIN

  out_success := 1;
  INSERT into PROCESS_RETRY_THROTTLE(process_name, generic_id, RETRY_count, create_date, update_date)
  VALUES (in_process_name, in_generic_id, 1, in_date, sysdate);
  commit;
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
  rollback;
  out_success := 0;
WHEN OTHERS THEN
  rollback;
  PROCS_COMMON_V17.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);

END;

PROCEDURE DELETE_RETRY(
    in_process_name IN VARCHAR2,
    in_remove_minutes  IN NUMBER
) AS
BEGIN

delete from PROCESS_RETRY_THROTTLE
where
  process_name = in_process_name and
  create_date <= sysdate-in_remove_minutes/1440;
commit;
END;

PROCEDURE GET_SYSDATE (
  out_date  OUT VARCHAR2
) AS
BEGIN
  SELECT to_char(SYSDATE, 'DD-Mon-YYYY HH24:MI:SS') into out_date from dual;
END;

END PROCS_PROCESS_RETRY_V17;
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
-- DDL for package PUBLIC_PROCS_CLIENT
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PUBLIC_PROCS_CLIENT_V17" AS 

PROCEDURE GET_NOTIFICATION_TYPE_BY_NAME (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V17.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
  in_notification_type_name IN VARCHAR2,
  out_notification_type_id  OUT NUMBER
);

PROCEDURE ADD_NOTIFICATION (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V17.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
  in_sender_account_id     IN NUMBER DEFAULT 0,
  in_recipient_group_id    IN NUMBER,
  in_notification_type_id  IN NUMBER,
  in_date_to_notify        IN DATE,
  in_email_template_params IN CLOB
);

END PUBLIC_PROCS_CLIENT_V17;
.
/

CREATE OR REPLACE PACKAGE BODY "PUBLIC_PROCS_CLIENT_V17" AS

PROCEDURE GET_NOTIFICATION_TYPE_BY_NAME (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V17.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
  in_notification_type_name IN VARCHAR2,
  out_notification_type_id  OUT NUMBER
) AS
BEGIN
  PROCS_NOTIFICATION_V17.GET_NOTIFICATION_TYPE_BY_NAME (
    in_notification_type_name,
    out_notification_type_id
  );
END;

/*****************************************************************/

PROCEDURE ADD_NOTIFICATION (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V17.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V17.UNKNOWN_ERROR
*/
  in_sender_account_id     IN NUMBER DEFAULT 0,
  in_recipient_group_id    IN NUMBER,
  in_notification_type_id  IN NUMBER,
  in_date_to_notify        IN DATE,
  in_email_template_params IN CLOB
) AS
BEGIN
  PROCS_NOTIFICATION_V17.ADD_NOTIFICATION (
    in_sender_account_id,
    in_recipient_group_id,
    in_notification_type_id,
    in_date_to_notify,
    in_email_template_params
  );
END;

END PUBLIC_PROCS_CLIENT_V17;
.
/

grant execute on OPS_OWNER.NOTIFICATION_STATUSES_V17 to ops_aaa_app;
grant execute on OPS_OWNER.PROCS_NOTIFICATION_V17 to ops_aaa_app;
grant execute on OPS_OWNER.PROCS_SYSTEM_V17 to ops_aaa_app;

grant execute on OPS_OWNER.NOTIFICATION_STATUSES_V17 to ops_payment_app;
grant execute on OPS_OWNER.PROCS_NOTIFICATION_V17 to ops_payment_app;
grant execute on OPS_OWNER.PROCS_SYSTEM_V17 to ops_payment_app;

grant execute on OPS_OWNER.NOTIFICATION_STATUSES_V17 to ops_notif_app;
grant execute on OPS_OWNER.PROCS_NOTIFICATION_V17 to ops_notif_app;
grant execute on OPS_OWNER.PROCS_SYSTEM_V17 to ops_notif_app;

grant execute on OPS_OWNER.PUBLIC_PROCS_CLIENT_V17 to core_licensing_app;
grant execute on OPS_OWNER.PUBLIC_PROCS_CLIENT_V17 to core_billing_app;
grant execute on OPS_OWNER.PUBLIC_PROCS_CLIENT_V17 to core_app;
grant execute on OPS_OWNER.PUBLIC_PROCS_CLIENT_V17 to cupy_app;

grant execute on OPS_OWNER.PROCS_PROCESS_RETRY_V17 to core_owner;
grant execute on OPS_OWNER.PROCS_PROCESS_RETRY_V17 to core_app;
grant execute on OPS_OWNER.PROCS_PROCESS_RETRY_V17 to cupy_app;
grant execute on OPS_OWNER.PROCS_PROCESS_RETRY_V17 to core_billing_app;
grant execute on OPS_OWNER.PROCS_PROCESS_RETRY_V17 to core_licensing_app;
grant execute on OPS_OWNER.PROCS_PROCESS_RETRY_V17 to ops_notif_app;
grant execute on OPS_OWNER.PROCS_PROCESS_RETRY_V17 to etl_app;
grant execute on OPS_OWNER.PROCS_PROCESS_RETRY_V17 to core_subup_app;
grant execute on OPS_OWNER.PROCS_PROCESS_RETRY_V17 to core_poller_app;
grant execute on OPS_OWNER.PROCS_PROCESS_RETRY_V17 to core_subup_app;

grant select on OPS_OWNER.PROCESS_RETRY_THROTTLE to core_owner;
grant select on OPS_OWNER.PROCESS_RETRY_THROTTLE to core_app;
grant select on OPS_OWNER.PROCESS_RETRY_THROTTLE to cupy_app;
grant select on OPS_OWNER.PROCESS_RETRY_THROTTLE to core_billing_app;
grant select on OPS_OWNER.PROCESS_RETRY_THROTTLE to core_licensing_app;
grant select on OPS_OWNER.PROCESS_RETRY_THROTTLE to core_subup_app;

grant select on OPS_OWNER.NOTIFICATION_TYPE to core_owner;
grant select on OPS_OWNER.NOTIFICATION_TYPE to core_app;
grant select on OPS_OWNER.NOTIFICATION_TYPE to cupy_app;
grant select on OPS_OWNER.NOTIFICATION_TYPE to core_billing_app;
grant select on OPS_OWNER.NOTIFICATION_TYPE to core_licensing_app;

grant REFERENCES on OPS_OWNER.NOTIFICATION_TYPE to core_owner;
grant REFERENCES on OPS_OWNER.NOTIFICATION_TYPE to core_app;
grant REFERENCES on OPS_OWNER.NOTIFICATION_TYPE to cupy_app;
grant REFERENCES on OPS_OWNER.NOTIFICATION_TYPE to core_billing_app;
grant REFERENCES on OPS_OWNER.NOTIFICATION_TYPE to core_licensing_app;

grant select, insert, update, delete ON OPS_OWNER.NOTIFICATION_TYPE to core_owner;
grant select ON OPS_OWNER.NOTTID_SEQ to core_owner;

grant select on OPS_OWNER.NOTIFICATION to core_owner;
grant select on OPS_OWNER.NOTIFICATION_FAILURE to core_owner;
grant select on OPS_OWNER.NOTIFICATION_STATUS to core_owner;
