select a.value_date,
       a.pan,
       a.accountnoone AS gonderen,
       c.full_name as Gonderenin_adi,
       a.org_amount,
       a.org_currency,
       a.fcy_amount,
       a.currency,
       d.full_name as Qebuledenin_Adi,
       B.PAN,
       B.ACCOUNTNOONE as gebul_eden, 
       case when a.idclient = b.idclient then 'ok' else 'not_ok' end netice 
  from cms.f_transaction_details A
  join cms.f_transaction_details B  on A.Invoice = b.Invoice
  join cms.d_customer c on a.idclient = c.cms_id 
  join cms.d_customer D on b.idclient = d.cms_id
   
 where 
   a.value_date > '01-Feb-23' 
   and a.entcode = '32'
   AND B.ENTCODE = '33'
   AND A.TERMCODE = '42271'
   and a.idclient in (select C.cms_id from cms.d_customer C where C.pin in ( select P.fin from fraud.emp_2 P))
   and b.idclient in (select D.cms_id from cms.d_customer D where D.pin in ( select W.fin from fraud.emp_2 W))
   
