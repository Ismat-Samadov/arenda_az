with ccentrecheck as 
(select a.bank_date, a.page_name, a.card_account, a.card_uid,  a.main_phone_number, a.customer_id,
B.FULLNAME, C.CMS_ID 
from odin.f_event_log A
inner join  cms.d_card C on A.CARD_UID = C.CARDUID 
INNER JOIN ODIN.D_USERS B on a.user_id = b.id
where b.is_operator = 1 and 
BANK_DATE between '01-Jul-22' and '26-Sep-22'),
callring as 
(select call_id, call_reason, cms_id, insert_Date
 from callcenter.f_received_calls 
 where trunc (insert_Date) between '01-Jul-22' and '26-Sep-22'),
 changes as ( select jj.accountnoone, jj.value_Date , jj.device, jj.entcode, jj.userdata from cms.f_transaction_details jj
 where JJ.device = 'F')
 --where trunc (call_start_time) between '01-Jan-22' and '26-Sep-22' )
 select distinct w.*, o.* , p.*
 from ccentrecheck W 
 left join callring O on to_char(W.CMS_ID) = O.CMS_ID
 left join changes p on w.card_account = p.accountnoone and w.bank_date = p.value_date  
 where w.card_account = '38810944008249738114'
 --WHERE W.BANK_DATE = O.BDATE and o.phone_number is null
