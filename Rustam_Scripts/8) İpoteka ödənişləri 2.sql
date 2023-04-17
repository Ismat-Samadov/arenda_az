select distinct T.BANK_DATE,
       T.OP_ID,
       T.CLIENT_ID,
       T3.CIF,
       T3.CMS_ID,
       T.CURRENCY,
       T.AMOUNT,
       T.AMOUNT_AZN,
       T.SOURCE_TYPE,
       T.DESTINATION_TYPE,
       T.DEBIT_PRODUCT,
       T.CREDIT_PRODUCT,
       T2.CUSTOMER_NAME,
       T2.CIF,
       T2.CMS_ID,
       case when T3.CIF = T2.CIF and T3.CMS_ID = T2.CMS_ID THEN 'OK' ELSE 'SUSP' END AS YOXLAMA
  from birbank.f_operation T
  join dwh.d_contract_credit T2
    on T.CREDIT_PRODUCT = T2.ID
  join birbank.d_customers_all_cms_id T3
    on T.CLIENT_ID = T3.USER_ID
 WHERE T.OP_CATEGORY_ID = '99'
   AND T.OP_PROVIDER_ID = '667'
   AND T.OP_STATUS = 1
  AND T2.ID IN ('465004739','556128320','353916639')---shert 
   AND T.BANK_DATE BETWEEN '01-Jan-22' AND '08-Mar-23'
Union
select distinct S.BANK_DATE,
       S.OP_ID,
       S.CLIENT_ID,
       S3.CIF,
       S3.CMS_ID,
       S.CURRENCY,
       S.AMOUNT,
       S.AMOUNT_AZN,
       S.SOURCE_TYPE,
       S.DESTINATION_TYPE,
       S.DEBIT_PRODUCT,
       S.CREDIT_PRODUCT,
       S2.CUSTOMER_NAME,
       S2.CIF,
       S2.CMS_ID,
       case when S3.CIF = S2.CIF and S3.CMS_ID = S2.CMS_ID THEN 'OK' ELSE 'SUSP' END AS YOXLAMA
  from birbank.f_operation S
  join dwh.d_contract_credit S2
    on S.CREDIT_PRODUCT = S2.CONTRACT_REF_NO_ALT
  join birbank.d_customers_all_cms_id S3
    on S.CLIENT_ID = S3.USER_ID
 WHERE S.OP_CATEGORY_ID = '99'
   AND S.OP_PROVIDER_ID = '667'
   AND S.OP_STATUS = 1
   and s2.contract_ref_no_alt in ('IPKF6292062A112','IPKF9624640A112','IPKF4718073A112') 
   AND S.BANK_DATE BETWEEN   '01-Jan-22' AND '08-Mar-23'
