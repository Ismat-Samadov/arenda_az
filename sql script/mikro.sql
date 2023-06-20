select /* +parallel*/ expert_hr_code 
from front.dm_credit_portfolio a 
where lower(a.expert_hr_code) like '%abdullayev zeynalabdın abdulla oğlu%';
--------------------------------
select *
  from dwh.d_contract_credit A
 where a.PRODUCT_CODE in
       (SELECT u.code
          FROM dwh.d_product u
         where lower(u.description) like '%mikro%') and a.creator_user_hr_code = '900055'
--lower(a.expert_name) like '%zeynal%';
------------------------------------------------------------------------------------
SELECT * FROM dwh.d_product u where lower (u.description) like '%mikro%'
