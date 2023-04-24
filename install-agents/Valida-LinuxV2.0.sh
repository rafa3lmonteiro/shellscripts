#!/bin/bash

echo -e " \033[1;33m O Carbon esta excutando? Se sim, qual é a versão ? \033[0m"
if ( systemctl status cbagentd  | grep "running" > /dev/null ); then echo -e "\033[1;92m "Sim, o Carbon esta executando na versao:"\033[m"; else echo -e '\033[05;31m"ATENÇÃO!! O Carbon nao esta executando"\033[00;37m'; fi
/opt/carbonblack/psc/bin/cbagentd --version | cut -d" " -f3
echo

echo -e " \033[1;33m O Easy inventory esta executando? \033[0m"
if ( systemctl status easy2l  | grep "running" > /dev/null ); then echo -e "\033[1;92m "Sim, o Easy esta executando"\033[m"; else echo -e '\033[05;31m"ATENÇÃO!! O Easy nao esta executando"\033[00;37m'; fi
echo

echo -e " \033[1;33m O Zabbix2 esta excutando? \033[0m"
if ( systemctl status zabbix-agent2  | grep "running" > /dev/null ); then echo -e "\033[1;92m "Sim, o Zabbix2 esta executando"\033[m"; else echo -e '\033[05;31m"ATENÇÃO!! O Zabbix2 nao esta executando"\033[00;37m'; fi
echo

echo -e " \033[1;33m O Nessus agent esta excutando? \033[0m"
if ( systemctl status nessusagent | grep "running" > /dev/null ); then echo -e "\033[1;92m "Sim, o Nessus esta executando"\033[m"; else echo -e '\033[05;31m"ATENÇÃO!! O Nessus nao esta executando"\033[00;37m'; fi
echo

echo -e " \033[1;33m O Graylog esta executando? \033[0m"
if ( systemctl status graylog-sidecar | grep "running" > /dev/null ); then echo -e "\033[1;92m "Sim, o Graylog esta executando"\033[m"; else echo -e '\033[05;31m"ATENÇÃO!! O Graylog nao esta executando"\033[00;37m'; fi
echo

echo -e " \033[1;33m O Arquivo de integacao zabbix webhook teams existe ? \033[0m"
if ( ls /etc/zabbix/zabbix_agent2.d/ | grep oxt_cmd.conf > /dev/null ); then echo -e "\033[1;92m "Sim, o arquivo de integracao esta instalado"\033[m"; else echo -e '\033[05;31m"ATENÇÃO!! O arquivo nao esta instalado"\033[00;37m'; fi
echo

echo -e " \033[1;33m O histórico de comandos esta corretamente configurado ? \033[0m"
if ( cat  /root/.bashrc | grep HISTTIMEFORMAT > /dev/null ); then echo -e "\033[1;92m "Sim, o history esta configurado"\033[m"; else echo -e '\033[05;31m"ATENÇÃO!! O history não esta configurado"\033[00;37m'; fi
echo

echo -e " \033[1;33m  O Banner SSH e o Profile inicial estão presentes ? \033[0m"

if ( cat /etc/ssh/sshd_config | grep "Banner /etc/banner-client.net" > /dev/null ); then echo -e "\033[1;92m "Banner SSH instalado"\033[m"; else echo -e '\033[05;31m"ATENÇÃO!! o Banner não esta instalado"\033[00;37m'; fi
if ( cat /etc/profile | grep dynmotd > /dev/null ); then echo -e "\033[1;92m "Profile instalado"\033[m" ; else echo -e '\033[05;31m "ATENÇÃO!! o Profile não esta instalado"\033[00;37m'; fi
echo

