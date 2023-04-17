with empl as 
(select m.credit_cms_id
          from cms.f_transaction m
         where m.debitentcode = '3'
           and m.credit_cms_id in
               (select z.cms_id
                  from cms.d_card z
                 where z.ministry_code = '037'
                   and z.product_code = '3')
           and m.value_date between '29-Dec-22' and '31-Dec-22')
select j.cms_id, j.name, count( distinct pan)
from cms.d_card j
join empl t on j.cms_id = t.credit_cms_id 
where j.product_code in
       (select p.code from cms.d_card_product p where p.name like '%Salary%')
       and j.status = '1'
       group by j.cms_id, j.name
       order by count ( distinct pan) desc
       
