#!/bin/bash

#Script para deploy de do arquivo oxt_cmd.conf no Zabbix

#Download do arquivo
curl -O http://192.168.50.224:8282/oxt_cmd.conf

#Copiando o OXF conf file
cp oxt_cmd.conf /etc/zabbix/zabbix_agent2.d/

#reiniciando ooxt_cmd.conf agent do Zabbix
systemctl restart zabbix-agent2

sleep 2

#Verificando o Status do agent
systemctl status zabbix-agent2

#Alterando as permissões do secure
chmod 777 /var/log/secure

#Alterando as permissões do audit se houver
chmod -R 777 /var/log/audit