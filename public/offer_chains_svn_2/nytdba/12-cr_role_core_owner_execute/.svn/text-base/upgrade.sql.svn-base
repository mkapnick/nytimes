-- code to drop/create a role with execute privileges on <object_owner>'s packages
-- if you drop an existing role that is granted to anther user, make sure to grant it back to that user after the role is recreated.

set serveroutput on termout on verify off 
-- since nomad turns off define before calling sql scripts, you need to explicitly turn define back on, as done in teh command below
set define on
define rol=CORE_OWNER_EXECUTE
WHENEVER OSERROR EXIT
WHENEVER SQLERROR CONTINUE

drop role &rol;

WHENEVER SQLERROR EXIT ROLLBACK

declare

      role varchar2(30) := '&rol';
      object_owner varchar2(30) := 'CORE_OWNER';

begin
    /* create role */
    execute immediate 'create role '||role;

    /* grant execute  privileges on object_owner's tables to role */
    for x in (select object_name from dba_objects  where object_type = 'PACKAGE' and owner = object_owner) 
    loop
         dbms_output.put_line ('grant execute on ' ||object_owner||'.'|| x.object_name || ' to '||role);
         execute immediate 'grant  execute on ' ||object_owner||'.'|| x.object_name || ' to '||role;
    end loop;
    
end;
/

