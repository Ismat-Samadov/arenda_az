select DISTINCT b.name, b.cif, a.DEVICE_ID,a.type,a.state

  from birbank.d_customer_device a

 inner join birbank.d_customers_new b

    on a.user_id = b.user_id

    where a.device_id in( select DISTINCT c.DEVICE_ID

    from birbank.d_customer_device c

    inner join birbank.d_customers_new d on c.user_id = d.user_id

    where d.cif='7500850')