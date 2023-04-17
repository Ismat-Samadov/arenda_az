with branchreg as
 (select distinct a.user_id,
                  a.cms_id,
                  a.cif,
                  a.login,
                  a.login_idx,
                  a.name,
                  a.full_name,
                  a.identity_number,
                  a.user_state,
                  a.created_date,
                  a.auth_token_type, 
                  j.device_id,
                  j.identifier, 
                  j.linked_date,
                  j.last_seen
    from birbank.d_customers_new A
      inner join birbank.d_customer_device J on A.User_Id = J.User_Id ),
embranch as
 (select m.user_id,
         m.cms_id,
         m.cif,
         m.login,
         m.name,
         m.created_date,
         m.user_state,
         m.full_name,
         m.login_idx,
         z.identifier,
         z.linked_date,
         z.last_seen,
         z.device_id
    from birbank.d_customers_new m
    left join birbank.d_customer_device Z
      on m.user_id = z.user_id
   where m.cms_id in  (select j.cms_id
                      from cms.d_customer j
                      join fraud.emp_2 k
                        on j.pin = k.fin))
select l.*, x.*, 
case when l.cms_id = x.cms_id then 'ok' else 'suspicious' end as yoxlama

  from  embranch L 
 inner join branchreg X
    on l.identifier = x.identifier
    order by x.linked_date desc  
