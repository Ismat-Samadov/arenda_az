with ccentrecheck as 
(select a.bank_date, a.page_name, a.card_account, a.card_uid,  a.main_phone_number, a.customer_id,
B.FULLNAME, C.CMS_ID 
from odin.f_event_log A
inner join  cms.d_card C on A.CARD_UID = C.CARDUID 
INNER JOIN ODIN.D_USERS B on a.user_id = b.id
where b.is_operator = 1 and 
BANK_DATE  between '01-Jul-22' and '31-Jul-22'),
callring as 
(select distinct a.call_start_time, a.call_end_time, a.call_result, a.phone_number, a.agent_name, 
b.cms_id, b.call_reason, TO_CHAR (A.CALL_START_TIME, 'DD-Mon-YY' ) AS BDATE 
  from callcenter.f_queue_calls A
  join callcenter.f_received_calls B
    on a.call_id = b.call_id 
    where trunc (call_start_time) between '01-Jul-22' and '31-Jul-22' )
    select w.* from ccentrecheck W 
    left join callring O on to_char(W.CMS_ID) = O.CMS_ID 
    WHERE W.BANK_DATE = O.BDATE
