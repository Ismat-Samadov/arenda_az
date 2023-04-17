
select /* +parallel*/
DISTINCT a.bank_date, a.op_date, v.name, a.currency, a.amount, a.amount_azn, a.debit_trans_id, a.debit_product,
         a.credit_product, o.customer_name, o.cms_id, o.cif,  v.cms_id, v.cif
  from birbank.f_operation a
  join birbank.d_customers_new v
    on a.client_id = v.user_id
  join dwh.d_contract_credit o on (to_char(a.credit_product) = to_char(o.id) 
  or to_char(a.credit_product) = to_char(o.contract_ref_no))
 where a.source_type = '7'
   and a.destination_type = '8'
   and a.op_status = '1'
   and a.category_id = '99'
   and a.provider_id in ('1801', '1808', '667', '666')
   and v.cms_id in (select j.cms_id
                      from cms.d_customer j
                      join fraud.emp_2 k
                        on j.pin = k.fin)
   and a.bank_date between '01-Jan-2023' and '28-Feb-2023'
   
   
