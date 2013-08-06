WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK

UPDATE
   GIFT_CERTIFICATE
 SET
   EXPIRATION_DATE = CREATE_DATE -1,
   CANCELATION_DATE = sysdate,
   UPDATED_BY = 'bugzilla_75915',
   UPDATE_DATE = sysdate,
   GIFT_CERTIFICATE_STATUS_ID = 3 
WHERE
   EXPIRATION_DATE > sysdate
   and CANCELATION_DATE is NULL
   and REDEMPTION_DATE is NULL
   and CODE in (
   '1a04d4f6c8a910',
   '858db48b30ca9d',
   '1be7ae8ebe3be8',
   '73ef2baed09223',
   '24f57842ecc7f3',
   '5ebf2111b74367',
   'c2da0b887bbb2e',
   'bbe01dced4ee46',
   'a01fa3747dc7a0',
   'afe2b8bc713b18',
   '09659c7bd8a372',
   '68e8d948954fd3',
   '975d6d3b906d37',
   '2ff09d4fd6696f',
   '5ba6ae8ca4115d',
   '5a6cf750212f8d',
   'd4703985b2fade',
   '41dc4ef91e446c',
   'fdf238964a947b',
   'd84634acba8973',
   '7b44db94d2cfb6',
   '853a9fd0eeba12'    
);

COMMIT;

