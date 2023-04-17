select /*+ parallel*/
A.Cms_Id,
      sum (case when a.direction = 'CREDIT' THEN A.CASHBACK_AMOUNT else 0 end) Toplam_CREDIT, 
      sum (case when a.direction = 'DEBIT' THEN A.CASHBACK_AMOUNT else 0 end) Toplam_DEBIT, 
      sum (case when a.direction = 'REVERSE' THEN A.CASHBACK_AMOUNT else 0 end) Toplam_REVERSE
  from cms.f_cashback_transaction A
 where A.cms_id not in
       (select m.credit_cms_id
          from cms.f_transaction m
         where m.debitentcode = '3'
           and m.credit_cms_id in
               (select z.cms_id
                  from cms.d_card z
                 where z.ministry_code = '037'
                   and z.product_code = '3')
           and m.value_date between '27-Feb-23' and '28-Feb-23') AND
   --and A.TERMNAME NOT IN ( 'BIRBANK','ZEUS')
   /*and A.direction = 'CREDIT'
   and a.direction = 
  
   and*/ 
   --A.TERMNAME  = 'E1000021' and 
   A.bank_date between '01-Feb-23' and '28-Feb-23'
   GROUP BY A.CMS_ID
