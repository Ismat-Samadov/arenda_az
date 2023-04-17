with ishgunu as
 (select a.previousworkday
    from dwh.d_calendar a
   where a.calendar_date = trunc(sysdate))
select e.*, d.branch_name
  from optimus.d_process_loan_online_eligible e
  join dwh.d_branch d
    on d.branch_code = e.branch_code
 where trunc(e.process_create_time) = (select previousworkday from ishgunu)
   and (e.initiator_user, customer_pin) in
       (select initiator_user, customer_pin
          from optimus.d_process_loan_online_eligible
         where trunc(process_create_time) =
               (select previousworkday - 3 from ishgunu)
           and eligible = '1')
