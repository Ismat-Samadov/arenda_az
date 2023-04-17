/*1.2.ƏMƏKDAŞIN KART HESABLARINDAN MƏRC OYUNLARI, INTERNET PUL KISƏLƏRI V.S. 
BU ƏQDLƏRI ƏHATƏ EDƏN SAHƏLƏR ÜZRƏ ÖDƏNIŞLƏRININ AYLIQ MƏBLƏĞLƏRI 100 (BIR YÜZ) MANAT MƏBLƏĞINI AŞARSA.*/

WITH TRANZAKSIYA AS
 (SELECT T.PAN,
         T.ACCOUNTNOONE,
         T.TERM,
         T.TERMLOCATION,
         T.OBJECTUID,
         T.VALUE_TIME,
         T.MCC,
         SUM(T.LCY_AMOUNT) AS TOTAL_MEBLEG
    FROM CMS.F_TRANSACTION_DETAILS T
   WHERE t.value_date BETWEEN  '01-Feb-23' AND  '28-Feb-23'
   GROUP BY T.PAN,
            T.ACCOUNTNOONE,
            T.TERM,
            T.TERMLOCATION,
            T.OBJECTUID,
            T.VALUE_TIME,
             T.MCC
  /*HAVING SUM(T.LCY_AMOUNT) > 100*/)
SELECT T.PAN AS KART_PANI,
       T.ACCOUNTNOONE AS KART_HESABI,
       T.TERM AS TERMINAL,
       T.TERMLOCATION,
       T.OBJECTUID,
       T.VALUE_TIME AS EMELIYYATIN_VAXTI,
       T.TOTAL_MEBLEG,
       D.MINISTRY_CODE AS KOD,
       D.MINISTRY_NAME AS AD,
       d.finprofile_name,
       D.CMS_ID,
       D.CIF,
       cc.full_name,
       D.STATUS AS KART_STATUS
  FROM TRANZAKSIYA T
  JOIN CMS.D_CARD D
    ON D.OBJECTUID = T.OBJECTUID
    join cms.d_customer cc on cc.cif = d.cif
 WHERE T.ACCOUNTNOONE In 
       (SELECT C.ACCOUNT
          FROM CMS.D_CARD C
         WHERE C.STATUS = '1'
               AND
               C.CMS_ID IN
               (SELECT j.cms_id
                  FROM CMS.D_customer j
                 WHERE j.pin in (select z.fin from fraud.emp_2 z))
                  AND T.MCC IN ('5816',
                       '7801',
                       '7800',
                       '7802',
                       '7995',
                       '9406',
                       '9754',
                       '7993',
                       '7994'))
 ORDER BY T.TOTAL_MEBLEG DESC;
 

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

WITH CAL AS
(SELECT A.PREVIOUSWORKDAY
FROM DWH.D_CALENDAR A
WHERE A.CALENDAR_DATE=TRUNC(SYSDATE)),
TRANZAKSIYA AS
 (SELECT T.PAN,
         T.ACCOUNTNOONE,
         T.TERM,
         T.TERMLOCATION,
         T.OBJECTUID,
         T.VALUE_TIME,
         T.MCC,
         SUM(T.LCY_AMOUNT) AS TOTAL_MEBLEG
    FROM CMS.F_TRANSACTION_DETAILS T
   WHERE T.BANK_DATE  = (SELECT PREVIOUSWORKDAY FROM CAL)
   GROUP BY T.PAN,
            T.ACCOUNTNOONE,
            T.TERM,
            T.TERMLOCATION,
            T.OBJECTUID,
            T.VALUE_TIME,
             T.MCC
  HAVING SUM(T.LCY_AMOUNT) > 100)
SELECT T.PAN AS KART_PANI,
       T.ACCOUNTNOONE AS KART_HESABI,
       T.TERM AS TERMINAL,
       T.TERMLOCATION,
       T.OBJECTUID,
       T.VALUE_TIME AS EMELIYYATIN_VAXTI,
       T.TOTAL_MEBLEG,
       D.NAME AS EMEKDAHS_AD,
       D.MINISTRY_CODE AS KOD,
       D.MINISTRY_NAME AS AD,
       D.CMS_ID,
       D.CIF,
       D.STATUS AS KART_STATUS
  FROM TRANZAKSIYA T
  JOIN CMS.D_CARD D
    ON D.OBJECTUID = T.OBJECTUID
 WHERE T.ACCOUNTNOONE IN
       (SELECT C.ACCOUNT
          FROM CMS.D_CARD C
         WHERE C.STATUS = '1'
               AND
               C.CMS_ID IN
               (SELECT D.CMS_ID
                  FROM CMS.D_CARD D
                 WHERE D.STATUS = '1'
                       AND LOWER(D.FINPROFILE_NAME) LIKE '%salary%'
                       AND D.MINISTRY_CODE = '037'
                       AND LOWER(D.PRODUCT_NAME) LIKE '%electron%salary%'))
                  AND T.MCC IN ('5816',
                       '7801',
                       '7800',
                       '7802',
                       '7995',
                       '9406',
                       '9754',
                       '7993',
                       '7994')
 ORDER BY T.TOTAL_MEBLEG DESC;
