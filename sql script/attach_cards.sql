select *
  from birbank.d_verified_attach_card a
 inner join cms.d_card b
    on a.product_id = b.CARDUID
 inner join birbank.d_customers_new c
    on a.user_id = c.user_id
 where c.cif = '298324';

-----------------------------------------------------------
select * from birbank.d_verified_attach_card a 
inner join birbank.d_customers_new b  on a.user_id = b.user_id 
inner join cms.d_card c on a.product_id = c.CARDUID 
where b.cif = '8930610';