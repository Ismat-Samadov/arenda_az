--for user search
select unique b.user_name,b.full_name from elma.d_elma_user b where lower(b.user_name) like'%safarov%';


---elma general info search

select a.startdate, 
       b.full_name, 
       a.workflowinstance_name, 
       c.pin
  from elma.f_workflow_instance a
  join elma.d_elma_user b  on a.initiator = b.id
  join elma.d_wfi_client_info c on a.wfid = c.instanceid
 where b.user_name = 'SafarovN'
   AND LOWER(A.WORKFLOWINSTANCE_NAME) LIKE    n'%müştəri barədə ümumi məlumat%';
            