select distinct *
  from (with empnum as (select B.NAME, B.LOGIN_IDX, B.CMS_ID, B.CIF
                          from birbank.d_customers_new B
                         where B.cms_id in
                               ((select m.credit_cms_id
                                  from cms.f_transaction m
                                 where m.debitentcode = '3'
                                   and m.credit_cms_id in
                                       (select z.cms_id
                                          from cms.d_card z
                                         where z.ministry_code = '037'
                                           and z.product_code = '3')
                                   and m.value_date between '27-Feb-23' and
                                       '28-Feb-23'))),
       
       othernum as (select c.address,
                           p.account,
                           p.name,
                           p.cms_id,
                           c.createdate
                      from cms.d_card_cns C
                      left join cms.d_card P
                        on c.objectuid = P.Objectuid
                     where p.status = '1')
         select E.name as BBname,
                E.login_idx as BBnum,
                E.cms_id as BBcms,
                E.cif as BBcif,
                Q.address as CMSaddress,
                Q.account as Cmsaccount,
                Q.name as Cmsname,
                Q.cms_id as cmscms_id,
                Q.Createdate,
                case
                  when E.cms_id = Q.cms_id then
                   'OK'
                  else
                   'Suspicious'
                end as Checking
           from empnum E
           left join othernum Q
             on E.login_idx = Q.address) F
          where f.checking = 'Suspicious'
            and f.createdate between '01-Feb-23' and '28-Feb-23'
          order by f.createdate desc
