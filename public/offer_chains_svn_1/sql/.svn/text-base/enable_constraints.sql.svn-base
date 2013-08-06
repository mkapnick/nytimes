BEGIN
  FOR cons_rec IN
    (
        SELECT
            table_name,
            constraint_name
        FROM
            user_constraints
        WHERE
            constraint_type = 'R'
    )
    LOOP
        EXECUTE immediate 'alter table '|| cons_rec.table_name ||' enable constraint '||
        cons_rec.constraint_name ;
  END LOOP;
END;
/
