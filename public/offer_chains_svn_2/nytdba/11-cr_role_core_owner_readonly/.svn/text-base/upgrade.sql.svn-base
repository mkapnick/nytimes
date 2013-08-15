-- code to create a role with read only privileges on <object_owner>'s objects and then grant that role to <grantee>

set serveroutput on termout on verify off 
-- since nomad turns off define before calling sql scripts, you need to explicitly turn define back on, as done in the command below
set define on
define rol=CORE_OWNER_READONLY
WHENEVER OSERROR EXIT
WHENEVER SQLERROR CONTINUE

/* drop  role */
drop role &rol;

WHENEVER SQLERROR EXIT ROLLBACK

declare

      role varchar2(30) := '&rol';
      object_owner varchar2(30) := 'CORE_OWNER';

begin
    /* create role */
    dbms_output.put_line ('create role '||role);
    execute immediate 'create role '||role;

    /* grant select privileges on object_owner's tables to role */
    for x in (select table_name from dba_tables  where owner = object_owner and table_name not like 'RUPD$_%' and table_name not like 'MLOG$_%') 
    loop

	/* enclose the table_name in double quotes, as some tables such as schema_version in ecdv6 are stored in the db in lower case, instead of using the standard uppercase convention! */
         dbms_output.put_line ('grant select on ' ||object_owner||'.'||'"'||x.table_name||'"'||' to '||role);
         execute immediate 'grant select on ' ||object_owner||'.'||'"'||x.table_name||'"'||' to '||role;
    end loop;

    /* grant select privileges on object_owner's views to role */
    for x in (select view_name from dba_views  where owner = object_owner )
    loop
         dbms_output.put_line ('grant select on ' ||object_owner||'.'||'"'|| x.view_name ||'"'|| ' to '||role);
         execute immediate 'grant select on ' ||object_owner||'.'||'"'||x.view_name||'"'||' to '||role;
    end loop;

end;
/

