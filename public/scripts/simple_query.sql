"SPOOL /Users/205463/nytimes/public/files/result2.dat";
SELECT id FROM OFFER_CHAIN WHERE ROWNUM < 20 ORDER BY CREATE_DATE DESC;
"SPOOL OFF";