select a.create_date,
       a.create_time,
       a.by_otp,
       a.label,
       a.state,
       a.type,
       a.user_id,
       C.PIN,
       C.MOBILE,
       B.CARD_NUMBER,
       B.NAME,
       B.SURNAME,
       B.AMOUNT,
       B.COMMISSION_STATE,
       D.FROMACCT
  from taxrefund.f_transaction A
 inner join taxrefund.f_transfer B
    on A.ID = B.OPERATION_ID
 inner join taxrefund.d_customer C
    on A.USER_ID = C.ID
 inner join cms.f_tla_cmp D
    on B.TRANSACTION_ID = D.ID
    where c.pin in (select j.pin
                      from cms.d_customer j
                      join fraud.emp_2 k
                        on j.pin = k.fin) and a.create_date between '01-Jan-23' and '31-Mar-23'
 --where D.FROMACCT IN (SELECT ACCOUNT FROM CMS.D_CARD where PRODUCT_CODE = '2255')
 --ORDER BY A.CREATE_TIME DESC;
