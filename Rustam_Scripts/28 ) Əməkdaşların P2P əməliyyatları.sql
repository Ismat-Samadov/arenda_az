/*WITH CAL AS
(SELECT A.PREVIOUSWORKDAY
 FROM DWH.D_CALENDAR A
 WHERE A.CALENDAR_DATE=TRUNC(SYSDATE))*/
SELECT F.VALUE_DATE   AS GONDERILME_TARIXI,
       F.PAN          AS GONDERENIN_PANI,
       F.ENTCODE      AS ENTCODE_GONDEREN,
       F.ACCOUNTNOONE AS GONDERENIN_HESABI,
       DA.NAME         AS GONDERENIN_ADI,
       F.ORG_AMOUNT   AS MEBLEG,
       F.ORG_CURRENCY AS VALYUTA,
       F.TERM         AS TERM,
       F.VALUE_TIME   AS GONDERILME_TARIXI_SAAT,
       T.PAN          AS QEBUL_EDENIN_PANI,
       T.ACCOUNTNOONE AS QEBUL_EDENIN_HESABI,
       F.ORG_AMOUNT   AS MEBLEG,
       F.ORG_CURRENCY AS VALYUTA, 
       f.idclient as alanin_cms_id, 
       case when t.idclient = f.idclient then 'OK' else 'NOTOK' end as Yoxlama
  FROM CMS.F_TRANSACTION_DETAILS F
  JOIN CMS.F_TRANSACTION_DETAILS T
    ON F.INVOICE = T.INVOICE
  JOIN CMS.D_CARD DA
    ON DA.OBJECTUID = F.OBJECTUID
 WHERE F.ENTCODE = '32'
       AND T.ENTCODE = '33'
 AND f.idclient = '9429600' /*IN (SELECT C.ACCOUNT
                             FROM CMS.D_CARD C
                             WHERE C.STATUS = '1'
                                   AND C.CMS_ID IN (SELECT D.CMS_ID
                                                FROM CMS.D_CARD D
                                                 WHERE D.STATUS = '1'
                                                 AND LOWER(D.FINPROFILE_NAME) LIKE '%salary%'
                                                 AND D.MINISTRY_CODE = '037'
                                                 AND LOWER(D.PRODUCT_NAME) LIKE '%electron%salary%'))*/
/*AND T.ACCOUNTNOONE IN (SELECT CA.ACCOUNT
                             FROM CMS.D_CARD CA
                             WHERE CA.STATUS = '1'
                                   AND CA.CMS_ID IN (SELECT DR.CMS_ID
                                                FROM CMS.D_CARD DR
                                                 WHERE DR.STATUS = '1'
                                                 AND LOWER(DR.FINPROFILE_NAME) LIKE '%salary%'
                                                 AND DR.MINISTRY_CODE = '037'
                                                 AND LOWER(DR.PRODUCT_NAME) LIKE '%electron%salary%'))*/
AND F.VALUE_DATE > '01-NOV-22'
/*AND F.ORG_AMOUNT > 500
ORDER BY F.ORG_AMOUNT DESC;*/
