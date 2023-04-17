select A.STARTDATE, A.PINKOD, A.SERIYA_NO, A.FULLNAME ,A.PROCESS, A.VALYUTA_NOV, A.MEBLEG, A.MEBLEG_AZN, A.BRANCHNAME, A.BRANCHCODE, A.BIRTH_DATE,
       B.USER_NAME, B.DOC_DESCRIPTION
  from dwh.f_exc_elma_exchange A
  left join dwh.f_exch_transaction_zeus B on A.REFID = B.OP_ID
 where a.mubadile_novu like '%1%'
       and a.pinkod in (select pin from dwh.d_customer where cms_id in (select  d.cms_id 
                                               from cms.d_card d
                                               left join cms.d_customer c on d.cms_id = c.cms_id 
                                               where
                                               d.ministry_code = '037' and 
                                               d.status in ('A','1') and 
                                               d.finprofile_code = '46'))
   and trunc(startdate) between '01-Jan-2022' and '30-Nov-2022' ;
