with BBchanges as 
(select A.DEVICE_ID as phone, A.STATE as status, A.LAST_SEEN, A.USER_ID, B.DEVICE_ID, B.LINKED_DATE, B.STATE  
from Birbank.d_Customer_Device A 
join birbank.d_customer_device B on a.USER_ID =  B.USER_ID and A.DEVICE_ID != B.DEVICE_ID
where trunc (a.last_seen) = trunc ( b.linked_date ) and trunc (b.linked_date) between '01-Sep-22' and '21-Sep-22'
and B.STATE = 'ACTIVE'),
operation as 
(select bank_date, client_id, op_status, currency, amount, source_type, destination_type, CREDIT_SYSTEM,
debit_product, credit_product, auto_op_id, op_date 
from birbank.f_operation )
select distinct cc.user_id, CC.LINKED_DATE, TT.BANK_dATE, tt.op_date, TT.OP_STATUS, TT.CURRENCY, TT.AMOUNT, TT.SOURCE_TYPE, TT.DESTINATION_TYPE,
TT.DEBIT_PRODUCT, TT.CREDIT_PRODUCT, TT.AUTO_OP_ID
from BBchanges CC 
join operation TT on CC.USER_ID = TT.CLIENT_ID
WHERE tt.auto_op_id != '88888888'  and tt.credit_system = 'TWO'
and  TT.BANK_DATE BETWEEN TRUNC (CC.LINKED_DATE) AND TRUNC (CC.LINKED_DATE +2)
