create or replace view gambling as
select /* +parallel*/
 a.load_date,
 a.bank_date,
 a.VALUE_DATE,
 c.fin,
 c.name,
 a.mcc,
 a.pan,
 a.accountnoone,
 a.accountnotwo,
 a.termlocation,
 A.CURRENCY,
 D.NAME AS CURRENCY_NAME,
 a.lcy_amount,
 A.FCY_AMOUNT,
 A.ORG_AMOUNT
  from cms.f_transaction_details a
 inner join dwh.d_customer b on a.idclient = b.cms_id
 inner join fraud.emp_2 c on b.pin = c.fin
 INNER JOIN DWH.D_CURRENCY D ON A.CURRENCY = D.ID
 where a.mcc in ('7800', '7801', '7802', '7995', '9754');
