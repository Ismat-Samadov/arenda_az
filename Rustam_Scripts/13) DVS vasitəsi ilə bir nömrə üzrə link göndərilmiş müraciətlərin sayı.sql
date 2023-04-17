select count (distinct  A.CIF) as say , A.MOBILE,B.SALES_CHANNEL
from cx.d_dvs_customer A
left join cx.f_dvs_order B on A.ID=B.CUSTOMER_ID 
left join optimus.d_contract O on o.cif = a.cif 
where o.cash_contract_startdate between '01-Apr-22' and '30-Apr-22' and b.sales_channel = 'teleSales' --and a.mobile like '%5606263'
group by a.mobile,  b.sales_channel
order by say desc  ;
