select DISTINCT A.WORKFLOWINSTANCE,
                A.TMPLTODAY,
                A.FULLNAME,
                J.FULL_NAME,
                A.CIF,
                A.IDCARDNUMBER,
                A.PINCODESTRING,
                J.PIN,
                A.TMPLACCOUNT,
                A.PLASTICCARDNUMBER,
                A.TMPLAMOUNT,
                A.TMPLCURRENCY,
                A.REASONBLOCKCARD,
                A.POADOCUMENTTYPE,
                A.RECIPIENT,
                A.BRANCHNAME,
                A.INICIATOR,
                A.DESCRIPTION,
                CASE
                  WHEN A.PINCODESTRING = J.PIN THEN
                   'OK'
                  ELSE
                   'NOTOK'
                END YOXLAMA
  from elma.f_plastic_card_withdrawal A
  LEFT JOIN (select S.ACCOUNT, T.PIN, T.FULL_NAME, S.CMS_ID
               from cms.d_card S
               JOIN cms.d_customer T
                 on S.CMS_ID = T.CMS_ID) J
    ON A.TMPLACCOUNT = J.ACCOUNT
 WHERE /*A.PINCODESTRING  in
       (select pin
          from dwh.d_customer
         where cms_id in
               (select cms_id
                  from cms.d_card S
                 where S.ministry_code = '037'
                   and S.status = '1'
                   and S.Finprofile_code in ('192', '46')))
   and*/ A.WORKFLOWINSTANCESTATUS = '{Success}Success'
   and A.TMPLTODAY between '01-Jan-22' and '31-Jul-22'
                       
                       
order by A.TMPLTODAY desc
