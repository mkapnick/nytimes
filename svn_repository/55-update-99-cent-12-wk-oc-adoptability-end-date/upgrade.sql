UPDATE
  offer_chain
SET
  adoptability_window_end_date = to_date('2069-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),
  update_date = SYSDATE,
  updated_by = 'PMOM-22'
WHERE
  id IN (1883293023,
         512404814,
         2251423298);
commit;