with Birbankcashback as
 (select cms_id, sum(cashback_amount) as sayBB
    from cms.f_cashback_transaction
   where source = 'BirBank'
     and bank_date between '07-Jul-22' and '29-Jul-22'
     and direction = 'CREDIT'
   group by cms_id
   order by sum(cashback_amount) desc),
Allcashback as
 (select cms_id, sum(cashback_amount) as saytam
    from cms.f_cashback_transaction
   where bank_date between '07-Jul-22' and '29-Jul-22'
     and direction = 'CREDIT'
   group by cms_id),
Reversed as
 (select cms_id, sum(cashback_amount) as sayreverse
    from cms.f_cashback_transaction
   where bank_date between '07-Jul-22' and '29-Jul-22'
     and direction = 'REVERSE'
   group by cms_id)
select a.cms_id, a.saytam, b.saybb, c.sayreverse, a.saytam-nvl(c.sayreverse, 0 ) as benefit
  from Allcashback A
  left join Birbankcashback B
    on A.cms_id = B.cms_id
  left join Reversed C
    on a.CMS_id = c.cms_id
where B.saybb is not null
 order by b.saybb desc
