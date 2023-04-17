select idclient,
       accountnoone,
       sum(lcy_amount) as cem,
       count(doc_no) as say
from cms.f_transaction_details
where device  = 'A' and entcode = '20'
and value_Date between '01-Apr-22' and '10-May-22'
and idclient is not null and accountnoone in ((select  d.account 
                                               from cms.d_card d
                                               left join cms.d_customer c on d.cms_id = c.cms_id 
                                               where
                                               d.ministry_code = '037' and 
                                               d.status in ('A','1') and 
                                               d.finprofile_code = '46')
                                               union  
                                               (select d.account 
                                               from cms.d_card d
                                               left join cms.d_customer c on d.cms_id = c.cms_id
                                               where d.status = '1' and 
                                               d.cms_id in ((select d.cms_id
                                                from cms.d_card d
                                                left join cms.d_customer c on d.cms_id = c.cms_id 
                                                where
                                                d.ministry_code = '037' and 
                                                d.status IN ('1','A') and 
                                                d.finprofile_code = '46'))))
group by idclient, accountnoone
order by cem desc;
