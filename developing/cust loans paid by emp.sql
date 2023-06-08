

------------------------------------------------------------------------------------------------
---- all customers info

 create or replace view ALL_LOAN_AND_CUSTOMERS_INFO as

  SELECT /* +PARALLEL*/ B.PIN,B.FULL_NAME, A.CONTRACT_REF_NO AS LOAN_ID

  FROM dwh.d_contract_credit A INNER JOIN DWH.D_CUSTOMER B ON A.CIF=B.CIF

  UNION ALL

  SELECT /* +PARALLEL*/ B.PIN,B.FULL_NAME, TO_CHAR(A.ID) AS LOAN_ID

  FROM dwh.d_contract_credit A INNER JOIN DWH.D_CUSTOMER B ON A.CIF=B.CIF;

----------------------------------------------------------------------------------------------
--- employees loans out

create or replace view without_emp_all_cust_loan_info as
select /* +PARALLEL*/ * from fraud.ALL_LOAN_AND_CUSTOMERS_INFO a 
where not exists ( select kx.PIN from fraud.emp_07_06_2023 kx where a.PIN=kx.PIN);

-------------------------------------------------------------------------------------------------------
------------ at last our sacrifices gives fruit
create or replace view loan_payments_of_emp  as
SELECT           /* +PARALLEL*/
                 unique         
                 A.bank_date,
                 B.FULL_NAME     AS LOAN_OWNER,
                 B.PIN           AS LOAN_OWNER_PIN,
                 A.EMPLOYEE_NAME,
                 A.EMP_PIN,
                 A.EMP_DEP,
                 A.EMP_SPECS,
                 A.AMOUNT, 
                 A.LOAN_ID                 
FROM FRAUD.Non_Emp_Loans_Payments A INNER JOIN FRAUD.All_Loan_And_Customers_Info B ON A.LOAN_ID = B.LOAN_ID;

    