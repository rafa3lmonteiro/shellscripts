#!/bin/bash

HOSTNAME=`uname -n`
RAIZ=`df -Ph | grep lv_root | awk '{print $5}' | tr -d '\n'`
LOGS=`df -Ph | grep lv_var | awk '{print $5}' | tr -d '\n'`
OPT=`df -Ph | grep lv_opt | awk '{print $5}' | tr -d '\n'`
CONFIG=`df -Ph | grep config | awk '{print $4}' | tr -d '\n'`
MEMORY1=`free -h -t -m | grep "Mem" | awk '{print $3" ";}'`
MEMORY2=`free -h -t -m | grep "Mem" | awk '{print $2" ";}'`
PSA=`ps -Afl | wc -l`
uptime=`cat /proc/uptime | cut -f1 -d.`
upDays=$((uptime/60/60/24))
upHours=$((uptime/60/60%24))
upMins=$((uptime/60%60))
LOAD1=`cat /proc/loadavg | awk {'print $1'}`
LOAD5=`cat /proc/loadavg | awk {'print $2'}`
LOAD15=`cat /proc/loadavg | awk {'print $3'}`

echo "
==============================================================================
 - Hostname do sistema ............: $HOSTNAME
 - Versão do sistema   ............: `cat /etc/redhat-release`
 - Usuários conectados ............: Atualmente `users | wc -w` usuário(s)
==============================================================================
 - Utilização do Processador ...........: $LOAD1, $LOAD5, $LOAD15 (1, 5, 15 min)
 - Utilização da memória     ...........: $MEMORY1 do total de: $MEMORY2
 - Utilização da SWAP        ...........: `free -m | tail -n 1 | awk '{print $3}'` MB
 - Processos em execução     ...........: $PSA processos rodando
 - Tempo Online do sistema   ...........: $upDays dia(s) $upHours hora(s) $upMins minuto(s)
 - Uso do disco em /         ...........: $RAIZ Usado(s)
 - Uso do disco em /var      ...........: $LOGS Usado(s)
 - Uso do disco em /opt      ...........: $OPT Usado(s)
==============================================================================
"
