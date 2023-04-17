with Medaxil as
 (select F1.BANK_DATE,
         F1.DOC_NO,
         F1.ACCOUNT,
         F1.CONTRA_BRANCH_CODE,
         F1.FCY_AMOUNT,
         F1.LCY_AMOUNT,
         F1.CIF,
         F1.VALUE_DT,
         F1.TXN_DT_TIME
    from dwh.f_transaction F1
   where related_product = '123'
     and F1.contra_cbar_code in ('10010', '10020')
     and F1.cbar_code in ('41010', '41020')
     and F1.bank_date between '01-Jan-22' and '05-Jun-22'
     and F1.source_id = 1),
Mexaric as
 (select F2.DOC_NO,
         F2.FCY_AMOUNT,
         F2.LCY_AMOUNT,
         F2.CONTRA_CIF,
         f2.contra_account,
         F2.VALUE_DT,
         F2.BRANCH_CODE,
         F2.TXN_DT_TIME
    from dwh.f_transaction F2
   where related_product = '124'
     and contra_cbar_code in ('41010', '41020')
     and cbar_code in ('10010', '10020')
     and bank_date between '01-Jan-22' and '05-Jun-22'
     and source_id = 1
     and f2.cif = '0000000'
     and f2.contra_cif != '0000000')
select C1.BANK_DATE,
       C1.DOC_NO,
       C1.ACCOUNT,
       C1.CONTRA_BRANCH_CODE as medaxil_filial,
       C1.FCY_AMOUNT as Medaxilxv,
       C1.TXN_DT_TIME,
       C1.LCY_AMOUNT as Medaxil,
       C2.BRANCH_CODE as mexaric_filial,
       C1.CIF,
       C1.VALUE_DT,
       C2.DOC_NO,
       C2.TXN_DT_TIME,
       C2.FCY_AMOUNT as Mexaricxv,
       C2.LCY_AMOUNT as Mexaric
  from Medaxil C1
  left join Mexaric C2
   on C1.account = C2.contra_account
   and C1.Value_dt = C2.value_dt
   where C1.LCY_AMOUNT > 2900 and c2.lcy_amount = c1.lcy_amount 
   
   
