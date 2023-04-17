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
       B.ACCOUNTNOONE as gebul_eden 
  from cms.f_transaction_details A
  join cms.f_transaction_details B  on A.Invoice = b.Invoice
  join cms.d_customer c on a.idclient = c.cms_id 
  join cms.d_customer D on b.idclient = d.cms_id
   
 where 
   a.value_date > '01-Aug-22' 
   and a.entcode = '32'
   AND B.ENTCODE = '33'
   AND A.TERMCODE = '42271'
   and a.idclient in (select A.cms_id
                 from cms.d_customer A
                where A.cms_id in (select m.credit_cms_id
                                     from cms.f_transaction m
                                    where m.debitentcode = '3'
                                      and m.credit_cms_id in
                                          (select z.cms_id
                                             from cms.d_card z
                                            where z.ministry_code = '037'
                                              and z.product_code = '3')
                                      and m.value_date between '01-Jan-23' and
                                          '01-Feb-23'))
   
