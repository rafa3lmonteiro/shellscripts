#!/bin/sh

#Deploy Ubuntu 18
URL="https://repo.zabbix.com/zabbix/6.2/ubuntu/pool/main/z/zabbix/zabbix-agent2_6.2.0-1%2Bubuntu18.04_amd64.deb"

#Baixando o Pacote
echo "> Fazendo Download do Agente"
wget -c $URL --no-check-certificate -O /tmp/zabbix.deb >/dev/null 2>&1

#Instalando o Pacote
echo "> Instalando o Agente Zabbix"
dpkg -i /tmp/zabbix.deb >/dev/null 2>&1

echo "> Alterando Variaveis no .conf do Agente"

#Troca LogFileSize
sed -i 's/^LogFileSize=0/LogFileSize=10/g' /etc/zabbix/zabbix_agent2.conf

#Troca de DebugLevel
sed -i 's|^#\ DebugLevel=3|DebugLevel=3|g' /etc/zabbix/zabbix_agent2.conf

#Habilita Comandos Remotos
sed -i '472iAllowKey=system.run['$IP_SERVER']' /etc/zabbix/zabbix_agent2.conf

#Altera Porta Zabbix
sed -i 's|^#\ ListenPort=10050|ListenPort='$ZABBIX_PORTA'|g' /etc/zabbix/zabbix_agent2.conf

#Ativa Log Comandos Remotos
sed -i 's|^#\ LogRemoteCommands=0|LogRemoteCommands=1|g' /etc/zabbix/zabbix_agent2.conf

#Troca Server Default
sed -i 's/^Server=127.0.0.1/Server='$IP_SERVER'/g' /etc/zabbix/zabbix_agent2.conf

#Troca ServerActive Default
sed -i 's/^ServerActive=127.0.0.1/ServerActive='$IP_SERVER_ACTIVE'/g' /etc/zabbix/zabbix_agent2.conf

#Troca Hostname
HOST=`cat /etc/hostname`
sed -i 's|^Hostname=Zabbix\ server|Hostname='$HOST'|g' /etc/zabbix/zabbix_agent2.conf

#Troca de HostMetadata
sed -i 's|^#\ HostMetadata=|HostMetadata='$METADATA'|g' /etc/zabbix/zabbix_agent2.conf

#Altera Timeout do Agente Zabbix
sed -i 's|^#\ Timeout=3|Timeout=30|g' /etc/zabbix/zabbix_agent2.conf

echo "> Iniciando o Agente Zabbix"

#Iniciando e Habilitando o Serviço
systemctl enable --now zabbix-agent2.service >/dev/null 2>&1
