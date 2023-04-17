with emekdash as
(select cms_id, cif, name, login_idx from birbank.d_customers_new
where cms_id in (select c.cms_id
                            from cms.d_customer c
                           where c.pin in (select j.fin from fraud.emp_2 j))),
mushteri as
(select distinct dc.cif, dc.mobile, cc.full_name,cc.cms_id
from optimus.d_customer_contact dc
join optimus.d_contract c on c.cif = dc.cif
join dwh.d_customer cc on cc.cif = dc.cif
where trunc(c.created_date_time) between date '2023-02-01' and date '2023-02-28')
select e.name, e.cif, e.cms_id, e.login_idx,
       m.full_name, m.cif, m.mobile,m.cms_id,
       case when e.cif = m.cif or e.cms_id = m.cms_id then 'okay'
         else 'not okay'
           end as result
from emekdash e
join mushteri m on e.login_idx = m.mobile;
