select a.client_id, B.NAME, B.FULL_NAME, count(a.op_id) as say
  from birbank.f_operation A
 inner join birbank.d_customers_new B
    on A.CLIENT_ID = B.USER_ID
 where a.source_type = 3
   and a.destination_type = 2
   and a.op_status = 1
   and A.client_id in
       (select user_id
          from birbank.d_customers_new
         where cms_id in (select n.cms_id
                            from cms.d_customer n
                           where n.pin in (select f.fin from fraud.emp_2 f )))
   and a.bank_date between '01-Feb-23' and '28-Feb-23'
 group by A.client_id, B.NAME, B.FULL_NAME
 order by say desc
--------------------------------------------------------------------------------
