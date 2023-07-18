with t as
 (SELECT /* +parallel*/
   d.pin,
   d.full_name,
   d.structure_name,
   b.pan,
   a.lcy_balance,
   MAX(a.bank_date) AS tarix,
   RANK() OVER(ORDER BY MAX(a.bank_date) DESC) AS tarix_rank
    FROM cms.f_account_balance a
   INNER JOIN cms.d_card b
      ON a.account = b.account
   INNER JOIN dwh.d_customer c
      ON b.cif = c.cif
   INNER JOIN hrb.d_basic_info d
      ON c.pin = d.pin
   WHERE b.product_name = 'Kapital Employee Salary Cards'
     AND B.CANCEL_DATE > SYSDATE
     and d.status=1
   GROUP BY d.pin, d.full_name, d.structure_name, b.pan,a.lcy_balance)
select /* +parallel*/
 *
  from t
 where tarix_rank = 1;
