  select * from ( 
    select distinct A.AGENT_NAME, a.extension_number ,COUNT (A.ID) as say --b.cms_id, b.call_reason
  from callcenter.f_queue_calls A
  inner join callcenter.f_received_calls B
    on a.call_id = b.call_id 
    where (a.talking_duration between '00:00:01' and '00:00:59') and 
    (trunc (a.call_start_time) between '01-Jul-22' and '31-Jul-22') and 
    a.terminated_by = 'AGENT' 
    GROUP BY A.AGENT_NAME, a.extension_number)
    order by say desc ;
    
    select distinct a.*, b.cms_id, b.call_reason
  from callcenter.f_queue_calls A
  inner join callcenter.f_received_calls B
    on a.call_id = b.call_id 
    where (a.talking_duration between '00:00:01' and '00:00:59') and 
    (trunc (a.call_start_time) between '01-Jul-22' and '31-Jul-22') and 
    a.terminated_by = 'AGENT' and a.extension_number = '9402' ;
