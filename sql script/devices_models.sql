SELECT        
trim(replace(replace(replace(replace(replace(substr(a.user_agent, instr(a.user_agent, ',', 1,2),instr(a.user_agent, ',', 1,2) ),'model'), '"'),':'),',') ,' br')) models,
count(distinct a.user_id) as say FROM birbank.d_customer_device a
WHERE state = 'ACTIVE'
   AND type IN ('iOS', 'ANDROID')

group by trim(replace(replace(replace(replace(replace(substr(a.user_agent, instr(a.user_agent, ',', 1,2),instr(a.user_agent, ',', 1,2) ),'model'), '"'),':'),',') ,' br'))
          order by say desc fetch first 10 rows only;