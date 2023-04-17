select distinct fc.phone_number, t.value_date,t.idclient, t.accountnoone, cc.address, cc.createsysdate,
       case when fc.phone_number = substr(cc.address, 4) then 'okay' else 'not okay' end as result
from cms.f_transaction_details t
join cms.d_card_cns cc on cc.objectuid= t.objectuid and cc.createdate = t.value_date
join callcenter.f_ivr_report_data fc on fc.cms_id = t.idclient and t.value_date = trunc ( call_start_date ) 
where t.value_date between date '2022-09-01' and date '2022-09-30' 
and concat(t.device,t.entcode) = 'F06'
and lower(term) like '%vr%'
and fc.forwarded_to_operator = '0'; 
