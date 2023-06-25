select /* +parallel*/ * from cms.f_transaction_details a

where a.idclient='298324'

and a.mcc='7011'

order by a.bank_date desc