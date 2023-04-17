with sahibkar as 
(select p.account, p.name from cms.d_card p where p.product_code in ('211','631') and p.TIN is not null and p.status = '1'), 
employer as 
(select h.account from cms.d_card h where h.cms_id in (select m.credit_cms_id from cms.f_transaction m where m.debitentcode = '3' and m.credit_cms_id in (select z.cms_id
  from cms.d_card z
where z.ministry_code = '037'
   and z.product_code = '3') and m.value_date between '29-Dec-22' and '31-Dec-22'))
select a.value_date, a.pan, a.accountnoone, r.name ,a.org_amount, a.org_currency, w.name ,b.accountnoone, b.pan ,b.termcode, b.term, b.retailer
from cms.f_transaction_details a 
join cms.f_transaction_details b on a.invoice = b.invoice 
join sahibkar r on a.accountnoone = r.account
join employer g on b.accountnoone = g.account
join cms.d_card W on g.account = w.account 
where
a.device = 'P' and a.entcode = '32' and b.entcode = '33' and  a.value_date between '01-Jun-22' and '31-Dec-22'       
