create or replace view emp_loan_id as
select /* +parallel*/
unique C.CONTRACT_REF_NO AS ID_OF_LOAN,c.cif
  from dwh.d_contract_credit c 
 INNER JOIN FRAUD.EMP_01_05_2023 D ON C.CIF=D.CIF
 where c.interest_rate >0 
   and c.initial_amount>0 
   and c.close_date is null
   
UNION ALL
   
select /* +parallel*/
unique TO_CHAR(C.ID) AS ID_OF_LOAN,c.cif
  from dwh.d_contract_credit c 
 INNER JOIN FRAUD.EMP_01_05_2023 D ON C.CIF=D.CIF
 where c.interest_rate >0 
   and c.initial_amount>0 
   and c.close_date is null ;
   
-----------------------------------------------------------------------------------
create or replace view EMP_LOANS_PAYMENTS as
select   /* +parallel*/ unique
         a.bank_date,
         a.credit_product AS LOAN_ID, 
         a.amount_azn AS AMOUNT,
         d.PIN AS EMP_PIN,
         d.CIF as EMP_CIF,
         d.NAME AS EMPLOYEE_NAME,
         d.SHOBE AS EMP_DEP,
         d.VEZIFE AS EMP_SPECS
from birbank.f_operation a
inner join fraud.emp_loan_id c on a.credit_product=c.ID_OF_LOAN   /*dwh.d_contract_credit c on (to_char(a.credit_product) = to_char(c.id) or to_char(a.credit_product) = to_char(c.contract_ref_no))*/
inner join fraud.emp_07_06_2023 d on a.client_id=d.USER_ID;
                                     
-----------------------------------
create or replace view non_emp_loans_payments as
select /* +parallel*/
 unique           a.bank_date,
 a.credit_product AS LOAN_ID,
 a.amount_azn     AS AMOUNT,
 d.PIN            AS EMP_PIN,
 d.CIF            as EMP_CIF,
 d.NAME           AS EMPLOYEE_NAME,
 d.SHOBE          AS EMP_DEP,
 d.VEZIFE         AS EMP_SPECS
  from birbank.f_operation a
 inner join fraud.without_emp_all_cust_loan_info b
    on a.credit_product = b.LOAN_ID
 inner join fraud.emp_07_06_2023 d
    on a.client_id = d.USER_ID;
-------------------------------------------
  create or replace view ALL_LOAN_AND_CUSTOMERS_INFO as

  SELECT /* +PARALLEL*/ B.PIN,B.FULL_NAME, A.CONTRACT_REF_NO AS LOAN_ID

  FROM dwh.d_contract_credit A INNER JOIN DWH.D_CUSTOMER B ON A.CIF=B.CIF

  UNION ALL

  SELECT /* +PARALLEL*/ B.PIN,B.FULL_NAME, TO_CHAR(A.ID) AS LOAN_ID

  FROM dwh.d_contract_credit A INNER JOIN DWH.D_CUSTOMER B ON A.CIF=B.CIF;

-----------------------------------------------------------------------------------------------------------------------

create or replace view without_emp_all_cust_loan_info as
select /* +PARALLEL*/ * from fraud.ALL_LOAN_AND_CUSTOMERS_INFO a 
where not exists ( select kx.PIN from fraud.emp_07_06_2023 kx where a.PIN=kx.PIN);

--------------------------------------------------------------------------------------
