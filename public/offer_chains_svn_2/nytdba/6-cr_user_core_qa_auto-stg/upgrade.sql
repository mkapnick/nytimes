create user core_qa_auto identified by values 'S:8BC8B37A33AE68BE0661AFA483C67CA6BBDF4A33A349530446357F9F3AA0' default tablespace users temporary tablespace temp profile default account unlock;

alter user core_qa_auto quota 0 on users;

grant create session to core_qa_auto;

