
----device deyisen ve p2p musteriler
with t as
 (select /* +parallel*/
   be.cif, count(unique aa.DEVICE_ID) say, max(aa.LINKED_DATE) as max_tarix
    from birbank.d_customer_device aa
   inner join birbank.d_customers_new be
      on aa.user_id = be.user_id
   where aa.LINKED_DATE between to_date('01.04.2023', 'dd.mm.yyyy') and
         to_date('30.04.2023', 'dd.mm.yyyy')
   group by be.cif)

select /* +parallel*/
 a.value_date,
 a.pan,
 a.accountnoone AS gonderen,
 c.full_name    as Gonderenin_adi,
 a.org_amount,
 a.org_currency,
 a.fcy_amount,
 a.currency,
 d.full_name    as Qebuledenin_Adi,
 B.PAN,
 B.ACCOUNTNOONE as gebul_eden,
 A.TERMCODE
  from cms.f_transaction_details A
  join cms.f_transaction_details B
    on A.Invoice = b.Invoice
  join cms.d_customer c
    on a.idclient = c.cms_id
  join cms.d_customer D
    on b.idclient = d.cms_id
  join t
    on t.cif = c.cif
 where a.value_date between to_date('01.04.2023', 'dd.mm.yyyy') and
       to_date('30.04.2023', 'dd.mm.yyyy')
   AND a.entcode = '32'
   AND B.ENTCODE = '33'
   AND A.TERMCODE in ('42004', '42271')
   and t.say > 1
   and (t.max_tarix = a.value_date or t.max_tarix = b.value_date)
