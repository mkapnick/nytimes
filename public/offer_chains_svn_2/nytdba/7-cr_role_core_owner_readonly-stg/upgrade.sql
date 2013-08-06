-- code to create a role with read only privileges on <object_owner>'s objects and then grant that role to <grantee>

set serveroutput on termout off

declare

      role varchar2(30) := 'CORE_OWNER_READONLY';
      grantee varchar2(30):= 'CORE_QA_AUTO';
      object_owner varchar2(30) := 'CORE_OWNER';

begin

    /* create role */
    execute immediate 'create role '||role;

    /* grant select privileges on object_owner's tables to role */
    for x in (select table_name from dba_tables  where owner = object_owner) 
    loop
         execute immediate 'grant select on ' ||object_owner||'.'|| x.table_name || ' to '||role;
         dbms_output.put_line ('grant select on ' ||object_owner||'.'|| x.table_name || ' to '||role);
    end loop;

    /* grant select privileges on object_owner's views to role */
    for x in (select view_name from dba_views  where owner = object_owner )
    loop
         execute immediate 'grant select on ' ||object_owner||'.'|| x.view_name || ' to '||role;
         dbms_output.put_line ('grant select on ' ||object_owner||'.'|| x.view_name || ' to '||role);
    end loop;

    /* grant role */
    execute immediate 'grant '||role||' to '||grantee;
end;
/

