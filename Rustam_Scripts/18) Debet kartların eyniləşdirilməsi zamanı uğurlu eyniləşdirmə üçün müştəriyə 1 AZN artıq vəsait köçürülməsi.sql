select distinct t.credit_cms_id, 
       count(t.credit_account) as say 
       --sum(t.lcy_amount) as sem
from cms.f_transaction t
where t.value_date between date '2022-07-01' and date '2022-09-23'
and t.debit_account = '870170014944100'
and t.credit_account like '38817%'
group by t.credit_cms_id
--having count(t.lcy_amount) <> 1
order by say desc 


select /*distinct t.credit_cms_id, 
       count(t.credit_account) as say, 
       sum(t.lcy_amount) as sem*/
       t.credit_account,
       t.value_date, 
       sum(t.lcy_amount) as cem
from cms.f_transaction t
where t.value_date between date '2022-07-01' and date '2022-09-23'
and t.debit_account = '870170014944100'
and t.credit_account like '38817%'
group by t.credit_account, t.value_date
having count(t.lcy_amount) <> 1
order by  value_date desc 
