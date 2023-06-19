SELECT /* +parallel*/
 a.user_id,
 b.name,
 b.surname,
 b.gender,
 b.birthday,
 2023 - EXTRACT(YEAR FROM b.birthday) AS age,
 CASE
   WHEN b.birthday = a.update_date THEN
    1
   ELSE
    0
 END AS dogum_gunu_bildiris,
 CASE
   WHEN a.cash_amount != 0 AND a.cashless_amount = 0 THEN
    'Nagd'
   WHEN a.cash_amount = 0 AND a.cashless_amount != 0 THEN
    'Nagdsiz'
   WHEN a.cash_amount != 0 AND a.cashless_amount != 0 THEN
    'Nagd-Nagdsiz'
 END AS odenish_novu,
 COUNT(UNIQUE a.fiscal_id) AS emeliyyat_sayi,
 SUM(a.refund_amount) AS edv_meblegi
  FROM taxrefund.f_cashback a
 INNER JOIN taxrefund.d_customer b
    ON a.user_id = b.id
 WHERE a.update_date = TO_DATE('31.07.2021', 'dd.mm.yyyy')
   AND a.state = 'completed'
   AND a.channel_type = 'birbank'
   AND a.cheque_date = a.insert_date
   AND b.create_date = TO_DATE('2021', 'yyyy')
 GROUP BY a.user_id,
          b.name,
          b.surname,
          b.gender,
          b.birthday,          
          2023 - EXTRACT(YEAR FROM b.birthday),
          CASE
            WHEN b.birthday = a.update_date THEN
             1
            ELSE
             0
          END,
          CASE
            WHEN a.cash_amount != 0 AND a.cashless_amount = 0 THEN
             'Nagd'
            WHEN a.cash_amount = 0 AND a.cashless_amount != 0 THEN
             'Nagdsiz'
            WHEN a.cash_amount != 0 AND a.cashless_amount != 0 THEN
             'Nagd-Nagdsiz'
          END
 ORDER BY edv_meblegi DESC;
