select a.*, b.accountnoone, 
case
         when a.idclient = b.idclient then
          'OK'
         else
          'Not ok'
       end Yoxlama
  from cms.f_transaction_Details A
  join cms.f_transaction_details B
    on a.invoice = b.invoice 
 where a.accountnoone in (select f.account
                            from cms.d_Card f
                           where f.finprofile_name like '254/331%'
                             and f.status = '1')
   and b.idclient in ( select cms_id from cms.d_customer w where w.pin in (select  g.fin from fraud.emp_2 g))
   and a.entcode = '32'
   and b.entcode = '33'
   and a.value_date between '01-Jan-23' and '23-Feb-23';
