select case
         when a.mcc in ('6010', '6011', '6012') then
          'cash'
         else
          'non-cash'
       end as cash_status,
       b.*,
       a.*
  from cms.f_transaction_details a
 inner join cms.d_mcc_details b
    on a.mcc = b.mcc
 where a.idclient = '298324'
 order by a.bank_date desc;
-----------------------------------------------
select * from (
  select --a.bank_date ,
         case
         when a.mcc in ('6010', '6011', '6012') then
          'cash'
         else
          'non-cash'
       end as cash_status,a.lcy_amount
  from cms.f_transaction_details a  where a.idclient = '298324'
)
PIVOT 
(
   sum(lcy_amount)
  for cash_status in ('cash','non-cash')
)
--order by bank_date desc ;