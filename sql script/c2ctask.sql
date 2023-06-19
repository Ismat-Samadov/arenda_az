select /*+parallel*/
 a.idclient,
 b.full_name,
 count(unique a.doc_no) as EMELIYYAT_SAYI,
 sum(a.fcy_amount * c.rate) as EMELIYYAT_MEBLEGI_AZN
  from cms.f_transaction_details a
 inner join dwh.d_customer b
    on a.idclient = b.cms_id
 inner join dwh.d_currency_rate c
    on a.currency = c.currency_id
   and a.bank_date = c.bank_date
 where a.bank_date = to_date('30/07/2021', 'dd/mm/yyyy')
   and a.device = 'P'
   and a.entcode = '32'
 group by a.idclient, b.full_name
 order by EMELIYYAT_MEBLEGI_AZN desc fetch first 10 rows only;
