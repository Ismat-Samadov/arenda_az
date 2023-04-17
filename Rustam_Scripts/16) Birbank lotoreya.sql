select IDCLIENT, COUNT(DOC_NO) AS SAY , SUM(LCY_AMOUNT) AS CEM, COUNT ( DISTINCT ACCOUNTNOONE) AS KARTSAY --term, device, entcode, count (doc_no)
   from cms.f_transaction_details
   where entcode != '32'
   and device != 'A' 
   and LCY_AMOUNT = '10'
   AND value_date between '17-Oct-22' and '19-OCT-22'
   group by IDCLIENT --device, entcode, term
   ORDER BY CEM DESC 
------------------------------------------------------

 
select DISTINCT a.client_id, b.cif, b.name ,sum(a.amount_azn) as cem, count(distinct a.debit_product) as say
from birbank.f_operation a
join birbank.d_customers_new b on a.client_id = b.user_id 
where a.bank_date between date '2022-10-17' and date '2022-10-24'
and a.credit_system = 'TWO'
and (concat(a.source_type,a.destination_type)='18' 
    or concat(a.source_type,a.destination_type)='115'
    or concat(a.source_type,a.destination_type)='38'
    or concat(a.source_type,a.destination_type)='78')
    and a.category_id = '99'
and a.amount_azn = 10
group by a.client_id,  b.cif, b.name
order by cem desc; 
