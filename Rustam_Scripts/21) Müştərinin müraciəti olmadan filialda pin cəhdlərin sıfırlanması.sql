with  FIMI_CRM as 
(select A.value_Date,
        a.value_time,
        A.ACCOUNTNOONE,
        B.CMS_ID 
  from cms.f_transaction_details A
  join cms.d_card B ON A.OBJECTUID = B.OBJECTUID
  where A.entcode = '16' and 
       A.termcode = '49831' and 
       A.VALUE_dATE BETWEEN '01-Jul-22' and '30-Jul-22' ), 
callcenter as 
(select j.*, b.cms_id, b.call_reason 
  from callcenter.f_queue_calls J
  join callcenter.f_received_calls B
    on j.call_id = b.call_id )
select T.*, Q.*
FROM FIMI_CRM T 
LEFT JOIN CALLCENTER Q ON T.CMS_ID = Q.CMS_ID 
