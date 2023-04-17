SELECT  B.NAME, A.RESERV_ID, B.LOGIN, B.PHONE, B.LOGIN_IDX , a.*
FROM BIRBANK.F_ONLINE_QUEUE_REQUEST A
left join birbank.d_customers_new B on A.USER_ID = B.USER_ID 
 where A.user_id in (select user_id from birbank.d_customers_new where cms_id in (select CMS_ID
                      from cms.d_card S
                     where S.ministry_code = '037'
                       and S.status = '1'
                       and S.Finprofile_code in ('192', '46'))) and STATUS = 2 and  A.INSERTED_DATE between '11-APR-22' and '12-Jul-22' 
                     
                       









 
