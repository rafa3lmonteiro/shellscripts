#!/bin/bash


setenforce 0;sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/sysconfig/selinux

yum install -y wget

# Conf. do Sidecar

wget http://192.168.50.224:8282/graylog-sidecar-1.0.2-1.x86_64.rpm

rpm -i graylog-sidecar-1.0.2-1.x86_64.rpm

graylog-sidecar -service install

chmod 777 /etc/graylog/sidecar/sidecar.yml



sed -i '6d' /etc/graylog/sidecar/sidecar.yml
echo -e 'server_url: "http://192.168.50.17:9000/api/" '  >>  /etc/graylog/sidecar/sidecar.yml

echo -e 'server_api_token: "ujj783bceo5vuatrq3fugm2ikkl72019fks9j4mrq6fe64tlbd3" '   >>  /etc/graylog/sidecar/sidecar.yml



echo -e 'tls_skip_verify: true '  >>  /etc/graylog/sidecar/sidecar.yml

systemctl start graylog-sidecar

systemctl restart graylog-sidecar

grep -iR "server_url:" /etc/graylog/sidecar/sidecar.yml

grep -iR "server_api_token:" /etc/graylog/sidecar/sidecar.yml



#Conf. do Filebeat


wget http://192.168.50.224:8282/filebeat-6.8.1-x86_64.rpm

rpm -i filebeat-6.8.1-x86_64.rpm

systemctl enable filebeat && systemctl start filebeat


# Configuracao do Rsyslog

yum install rsyslog

echo "*.* @10.4.0.86:1514;RSYSLOG_SyslogProtocol23Format" >> /etc/rsyslog.conf
echo "*.* @192.168.50.17:1514;RSYSLOG_SyslogProtocol23Format" >> /etc/rsyslog.conf

systemctl restart rsyslog

systemctl status graylog-sidecar


