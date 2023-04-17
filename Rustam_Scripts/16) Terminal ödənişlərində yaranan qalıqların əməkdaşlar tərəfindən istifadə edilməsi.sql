select A.VALUEDATE,
       A.VALUETIME,
       A.TERMINAL,
       A.ADDRESS,
       A.CHECK_NUMBER,
       A.STATE_NAME,
       A.SUBSTATE_NAME,
       A.SERVICE_NAME,
       A.SUM_INCOME,
       A.SUM_OUTCOME,
       A.SUM_COMM,
       A.CASHBACK,
       B.POINT,
       B.CITY,
       B.PIN,
       B.NOMINAL,
       B.CREATE_ACCOUNT,
       B.CREATE_SERVICE,
       B.ACTIVE_ACCOUNT,
       B.STATUS,
       B.LAST_TYPE,
       B.CLOSE_POINT,
       B.CLOSE_SERVICE,
       B.LAST_TIME,
       a.id_operation
  from sfour.f_paylogic_main_data A
  JOIN sfour.f_paylogic_rest_codes B
    ON A.ID_OPERATION = B.CREATE_TX
 WHERE B.CREATE_ACCOUNT IN
       (SELECT C.Account
          FROM CMS.D_CARD C
         WHERE C.STATUS = '1'
           AND C.CMS_ID IN
               (SELECT D.CMS_ID
                  FROM CMS.D_CARD D
                 WHERE D.STATUS = '1'
                   AND LOWER(D.FINPROFILE_NAME) LIKE '%salary%'
                   AND D.MINISTRY_CODE = '037'
                   AND LOWER(D.PRODUCT_NAME) LIKE '%electron%salary%'))
