select /* +parallel*/ * from fraud.transactions t inner join cc  on t.gonderenin_pini=cc.FIN
inner join nazarat on t.qebuledenin_pini=nazarat.fin
where t.gonderilme_vaxti >to_date('01.06.2023','dd.mm.yyyy');

drop table cc;
drop table nazarat;

create table cc as select * from fraud.emp_07_06_2023 a where a.SHOBE=n'Əlaqə mərkəzi şöbəsi';

create table nazarat as select * from fraud.emp_07_06_2023 a where a.SHOBE=n'Xidmət keyfiyyətinə nəzarət şöbəsi';


select /* +parallel*/
      gonderen.value_date as gonderilme_vaxti,
      qebuleden.value_date as qebul_vaxti,
      gonderen_info.name as gonderen,
      qebuleden_info.name as qebuleden,
      gonderen_info.pin as gonderenin_pini,
      qebuleden_info.pin as qebuledenin_pini,
      gonderen.pan as gonderen_pan,
      qebuleden.pan as qebuleden_pan,
      gonderen.accountnoone as gonderen_account,
      qebuleden.accountnoone as qebuleden_account,
      gonderen.lcy_amount as gonderen_lcy_amount,
      gonderen.Termlocation/*,
      CASE WHEN  gonderen_info.pin=qebuleden_info.pin THEN 'YES' ELSE 'NO' END AS "SAME_PERSON",
      CASE WHEN  gonderen.TERMCODE='42004' THEN 'F2F' ELSE 'C2C' END AS "CATEGORY"*/


     from
                cms.f_transaction_details gonderen
     inner join cms.f_transaction_details qebuleden on gonderen.Invoice = qebuleden.Invoice
     inner join fraud.cc gonderen_info on gonderen.idclient = gonderen_info.cms_id
     inner join fraud.nazarat qebuleden_info on qebuleden.idclient = qebuleden_info.cms_id
                  WHERE gonderen.entcode = '32'
                    AND qebuleden.ENTCODE = '33'
                    AND gonderen.TERMCODE in ( '42004' ,'42271');    