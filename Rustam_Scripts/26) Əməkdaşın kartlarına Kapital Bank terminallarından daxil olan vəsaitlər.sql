select a.pan, a.value_date, a.accountnoone, a.value_date, a.value_time, a.lcy_amount, a.currency, a.term, b.full_name
  from cms.f_transaction_details A
  join dwh.d_customer B on A.Idclient = B.Cms_Id 
 where a.term like 'K0%'
   and a.value_Date between '01-Oct-22' and '24-Oct-22' and a.idclient in ( SELECT D.CMS_ID
                                                                            FROM CMS.D_CARD D
                                                                           WHERE D.STATUS = '1'
                                                                                 AND LOWER(D.FINPROFILE_NAME) LIKE '%salary%'
                                                                                 AND D.MINISTRY_CODE = '037'
                                                                                 AND LOWER(D.PRODUCT_NAME) LIKE '%electron%salary%')
