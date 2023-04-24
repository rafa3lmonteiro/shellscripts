#!/bin/bash


cd /etc/zabbix/

touch audit_zabbix.sh

echo -e "#!/bin/bash 

### Liberar leitura para a dash users do zabbix

chmod 777 /var/log/secure
chmod -R 777 /var/log/audit/" > audit_zabbix.sh

chmod 777 /etc/zabbix/audit_zabbix.sh

echo -e '*/30 * * * * root /bin/sh /etc/zabbix/audit_zabbix.sh' >> /etc/crontab
