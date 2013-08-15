-- create role to view locks
drop role view_locks;
create role view_locks;

grant select on gv_$lock to view_locks;
grant select on v_$lock to view_locks;
grant select on gv_$session to view_locks;
grant select on v_$session to view_locks;
grant select on gv_$enqueue_lock to view_locks;
grant select on v_$enqueue_lock to view_locks;

