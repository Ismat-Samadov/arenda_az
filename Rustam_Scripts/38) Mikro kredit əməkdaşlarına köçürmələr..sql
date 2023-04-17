with Microcust as 
(select P.cms_id, 
       P.customer_name, 
       P.expert_name,
       p.start_date
  from dwh.d_contract_credit P
 where P.product_code in
       (select t.code
          from dwh.d_product t
         where lower(t.description) like '%mikro%')
         and p.close_date is null), 
Emekdash as 
(select L.name, L.fin, o.cms_id
from mikro_emp L
join cms.d_customer o on l.fin = o.pin)
select a.value_date, ----- c2c

         a.idclient     as alan,

         b.idclient     as gonderen,

         a.pan          as gonderen_pan,

         a.accountnoone AS gonderen_acc,
         Y.CUSTOMER_NAME AS gonderenin_adi,

         --c.full_name    as Gonderenin_adi,

         --e.pin as qebul_edenin_fini,

        -- d.full_name    as Qebuledenin_Adi,
        h.name as qebuledenin_adi, 

         B.PAN          as qebuleden_pan,

         B.ACCOUNTNOONE as gebul_eden,

         a.org_amount,

         a.org_currency,

         a.fcy_amount,

         a.currency, 
         y.expert_name, 
         y.start_date

    from cms.f_transaction_details A

   inner join cms.f_transaction_details B      on A.Invoice = b.Invoice
   inner join Microcust Y on A.IDCLIENT = Y.CMS_ID 
   INNER JOIN Emekdash H on b.idclient = H.CMS_ID 
   where a.value_date between to_date('01.01.2023', 'dd.mm.yyyy') and to_date('15.02.2023', 'dd.mm.yyyy')

     and a.entcode = '32'

     AND B.ENTCODE = '33'
