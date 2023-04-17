select A.STARTDATE, A.PINKOD, A.SERIYA_NO, A.FULLNAME ,A.PROCESS, A.VALYUTA_NOV, A.MEBLEG, A.MEBLEG_AZN, A.BRANCHNAME, A.BRANCHCODE, A.BIRTH_DATE,
       B.USER_NAME, B.DOC_DESCRIPTION
  from dwh.f_exc_elma_exchange A
  left join dwh.f_exch_transaction_zeus B on A.REFID = B.OP_ID
 where a.mubadile_novu like '%1%'
   and trunc(startdate) between '01-Oct-2022' and '31-Oct-2022' ;
   

