select unique 
       a.pin,
       a.cif,
       a.contract_ref_no,
       a.prolongation_count,
       case
         when sysdate > a.maturity_date then
          'close'
         else
          'open'
       end as activity
  from front.dm_deposit_portfolio a
 order by PROLONGATION_COUNT desc;
--------------------------------------------------------
select a.contract_ref_no, max(a.prolongation_count) say
  from front.dm_deposit_portfolio a
 group by a.contract_ref_no
having max(a.prolongation_count) > 2
 order by say desc;
------------------------------------------------------
with t as
(select c.contract_ref_no, max(c.prolongation_count)
    from front.dm_deposit_portfolio c
   group by c.contract_ref_no)

select unique a.pin,
       a.cif,
       a.contract_ref_no,
       a.prolongation_count,
       a.expert_name,
       a.branch_name,
       a.initial_amount,
       case
         when sysdate > a.maturity_date then
          'close'
         else
          'open'
       end as activity
  from front.dm_deposit_portfolio a
inner join t
    on a.contract_ref_no = t.contract_ref_no
order by PROLONGATION_COUNT desc;
