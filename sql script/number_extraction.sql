select /*+ paralel*/
w.userdata,
substr(regexp_replace(w.userdata, '[^0-9]', ''), 1, 12) nums,
w.*
  from cms.f_transaction_details w
where w.value_date > '01-Jun-2023'
   and w.termcode = '49831'
   and w.device = 'F'
   and w.entcode = '06';