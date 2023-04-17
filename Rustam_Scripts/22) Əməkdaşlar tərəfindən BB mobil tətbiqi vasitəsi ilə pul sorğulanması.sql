select client_id, count(distinct op_id), sum(amount_azn)
from birbank.f_operation
where bank_date between date '2022-09-01' and date '2022-09-30'
and lower(debit_system) like '%fr_end%'
and client_id in (select user_id from birbank.d_customers_new
                      where cms_id in (select c.cms_id
                                                from cms.d_card c
                                               where c.status = '1'
                                                     and c.cms_id in
                                                     (select d.cms_id
                                                            from cms.d_card d
                                                           where d.status = '1'
                                                                 and lower(d.finprofile_name) like '%salary%'
                                                                 and d.ministry_code = '037'
                                                                 and lower(d.product_name) like '%electron%salary%')))
group by client_id;
