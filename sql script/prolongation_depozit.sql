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
