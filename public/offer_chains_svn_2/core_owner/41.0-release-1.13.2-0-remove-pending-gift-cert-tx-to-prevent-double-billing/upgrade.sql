whenever sqlerror exit rollback;

update invoice
set invoice_status_id = 3,
updated_by = 'JIRA-SAR-483',
update_date = sysdate
where id in (
  select invoice_id from charge 
  where transaction_id in (15494422, 15494418, 16741183, 15658484, 17402236, 17402237, 15545431, 15657959, 15598777)
  and charge_status_id = 1
)
and invoice_status_id = 1;

update transaction
set 
  transaction_status_id = 2,
  updated_by = 'JIRA-SAR-483',
  update_date = sysdate
where id in (15494422, 15494418, 16741183, 15658484, 17402236, 17402237, 15545431, 15657959, 15598777)
and transaction_status_id = 1;

update charge 
set 
  charge_status_id = 3,
  updated_by = 'JIRA-SAR-483',
  update_date = sysdate
where transaction_id in (15494422, 15494418, 16741183, 15658484, 17402236, 17402237, 15545431, 15657959, 15598777)
and charge_status_id = 1;

commit;
