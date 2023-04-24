#!/bin/bash

# Os script deve ser rodadado em todos os servidores Linux recem-criado pelo datacenter


Principal() {

echo -e "\033[1;31m


                                                      
 @@@@@@    @@@@@@@  @@@@@@@   @@@  @@@@@@@   @@@@@@@  
@@@@@@@   @@@@@@@@  @@@@@@@@  @@@  @@@@@@@@  @@@@@@@  
!@@       !@@       @@!  @@@  @@!  @@!  @@@    @@!    
!@!       !@!       !@!  @!@  !@!  !@!  @!@    !@!    
!!@@!!    !@!       @!@!!@!   !!@  @!@@!@!     @!!    
 !!@!!!   !!!       !!@!@!    !!!  !!@!!!      !!!    
     !:!  :!!       !!: :!!   !!:  !!:         !!:    
    !:!   :!:       :!:  !:!  :!:  :!:         :!:    
:::: ::    ::: :::  ::   :::   ::   ::          ::    
:: : :     :: :: :   :   : :  :     :           :     
                                         
__       _      _       _   _     _                  
|_ _|_ __ (_) ___(_) __ _| | | |   (_)_ __  _   ___  __
 | ||  _ \| |/ __| |/ _  | | | |   | |  _ \| | | \ \/ /
 | || | | | | (__| | (_| | | | |___| | | | | |_| |>  < 
|___|_| |_|_|\___|_|\__,_|_| |_____|_|_| |_|\__,_/_/\_\


            Criador: Marcelo Goncalves
\033[m"


echo -e "\033[1;92m
---------------------------------------------------------------------------------
- 1.  Instalar Rapid7   - 2.  Instalar Nessus      - 3.  Instalar Carbon        -
---------------------------------------------------------------------------------
- 4.  Instalar o Zabbix                            - 5.  Instalar Banner SSH    -
---------------------------------------------------------------------------------
- 6.  Instalação do Easy Inventory                 - 7.  Mudar senha de um User -
---------------------------------------------------------------------------------
- 8.  Uninstall Scanner Nessus                     - 9.  Uninstall Agent Nessus -
---------------------------------------------------------------------------------
- 10. Update Nessus Agent                          - 11. Profile Inicial        -
---------------------------------------------------------------------------------
-                        Que a força esteja com você!                           -  
                                   12 - Sair
---------------------------------------------------------------------------------
             NÃO INSTALE O RAPID7 SEM COMUNICAR SEU SUPERIOR
\033[m"
echo -e "\033[1;34m
--------------------------------------------------------------------------------
-                            Qual e a opção desejada?                          -
--------------------------------------------------------------------------------

\033[m"



  read opcao

  case $opcao in

    1) rapid7 ;;

    2) nessus ;;

    3) carbon ;;

    4) zabbix ;;

    5) banner ;;

    6) easy ;;

    7) senha ;;

    8) unessus ;;

    9) uanessus ;;

    10) upanessus ;;

    11) profile ;;

    12) exit ;;

    *) "Opção desconhecida." ; echo ; Principal ;;

  esac

            }


rapid7() {

    yum makecache

    #yum install audit.x86_64 -y

    #yum install audispd-plugins.x86_64 -y

    mkdir /mnt/rapid7/

    cd /mnt/rapid7/

    wget -c http://192.168.50.224:8282/agent_installer.sh

    chmod a+x agent_installer.sh


    #echo "-b 8192" >> /etc/audit/rules.d/audit.rules

    #echo "-a always,exit -F arch=b64 -S execve -F key=execve" >> /etc/audit/rules.d/audit.rules

    #sed -i 's/250/8192/g' /etc/audisp/audispd.conf

    #sed -i 's/active = no/active = yes/g' /etc/audisp/plugins.d/af_unix.conf

    #sed -i 's/format = string/format = binary/g' /etc/audisp/plugins.d/af_unix.conf

    #sed -i 's/0640/600/g' /etc/audisp/plugins.d/af_unix.conf

    #touch log.txt

    #auditctl -l >> log.txt

    sh agent_installer.sh install_start --token eu:042fc173-e10d-434f-aae7-b04f67febd2e >> log.txt

    #touch /opt/rapid7/ir_agent/components/insight_agent/common/audit.conf

    #chmod 777 /opt/rapid7/ir_agent/components/insight_agent/common/audit.conf

    #echo "{"auditd-compatibility-mode":true}" >> /opt/rapid7/ir_agent/components/insight_agent/common/audit.conf

    #service auditd restart

    systemctl stop ir_agent

    systemctl start ir_agent

    systemctl status ir_agent >> log.txt

    cat /opt/rapid7/ir_agent/components/insight_agent/common/agent.log | grep "Agent Info" | tail -1l >> log.txt

    cat /mnt/rapid7/log.txt
    
    #cat /etc/audit/audit.rules >> log.txt

    #cat /etc/audisp/audispd.conf >> log.txt

    #cat /etc/audisp/plugins.d/af_unix.conf >> log.txt

    #cat /opt/rapid7/ir_agent/components/insight_agent/common/audit.conf >> log.txt

    echo 'Deseja instalar outro aplicativo? (Digite sim ou nao)'
                                   read escolha

                                                for i in $escolha; do


                                                        case $escolha in

                                                                sim) "Opção desconhecida." ; echo ;Principal ;;
                                                                nao)  exit ;;
                                                                  *) "Opção desconhecida." ; echo ;Principal ;;

                                                        esac
                                    done

            }

nessus(){
   
    wget -c http://192.168.50.224:8282/NessusAgent-10.2.1-es7.x86_64.rpm

    rpm -ivh NessusAgent-10.2.1-es7.x86_64.rpm

    cd /opt/nessus_agent/sbin/

    ./nessuscli agent link --key=8c297735742f315545899cea6d124bfef1d959c7c1d494195d5dbc4497b87570 --groups="BRAZIL_Agents_Servers1" --cloud=yes 
    
    /sbin/service nessusagent start
    /sbin/service nessusagent status
    
    echo 'Deseja instalar outro aplicativo? (Digite sim ou nao)'
                                   read escolha

                                                for i in $escolha; do


                                                        case $escolha in

                                                                sim) "Opção desconhecida." ; echo ;Principal ;;
                                                                nao)  exit ;;
                                                                  *) "Opção desconhecida." ; echo ;Principal ;;

                                                        esac
                                    done
}

carbon(){

    mkdir /mnt/carbon

    cd /mnt/carbon

    wget -c http://192.168.50.224:8282/cb-psc-sensor-rhel-2.13.2.1054252.tar

    tar zxfv cb-psc-sensor-rhel-2.13.2.1054252.tar

    rpm -i cb-psc-sensor-2.13.2-1054252.el7.x86_64.rpm

    sh /mnt/carbon/blades/bladesUnpack.sh

    /opt/carbonblack/psc/bin/cbagentd -d SX38GTIPWMSZYVQHM4I

    service cbagentd start

    /opt/carbonblack/psc/bin/cbagentd -v

    echo 'Deseja instalar outro aplicativo? (Digite sim ou nao)'
                                   read escolha

                                                for i in $escolha; do


                                                        case $escolha in

                                                                sim) "Opção desconhecida." ; echo ;Principal ;;
                                                                nao)  exit ;;
                                                                  *) "Opção desconhecida." ; echo ;Principal ;;

                                                        esac
                                    done
  
            }


zabbix() {

echo ""
	echo " 1=CENTOS ou RH 6 / 2=CENTOS ou RH 7 / 3=CENTOS ou RH 8 / 4=CENTOS ou RH 9"
	echo " 5=DEBIAN 9 / 6=DEBIAN 10 / 7=DEBIAN 11"
	echo " 8=UBUNTU 18 / 9=UBUNTU=20 / 10=UBUNTU 22"

        echo ""
        echo ""

echo "Digite o numero que e respectivo a sua distro"
read version
echo ""



mkdir /opt/zabbix/

cd /opt/zabbix/

wget -c http://192.168.50.224:8282/script.zip

unzip script.zip

cd /opt/zabbix/script

sh deploy_zabbix_linux.sh $version 10.100.100.19 10.100.100.15 7772 Linux_Client

echo 'Deseja instalar outro aplicativo? (Digite sim ou nao)'
                                   read escolha

                                                for i in $escolha; do


                                                        case $escolha in

                                                                sim) "Opção desconhecida." ; echo ;Principal ;;
                                                                nao)  exit ;;
                                                                  *) "Opção desconhecida." ; echo ;Principal ;;

                                                        esac
                                    done


    }


banner() {

    touch /etc/banner-client.net

echo "

Client Name


######################################################################

                      Acesso restrito!!!

       O acesso é permitido apenas para pessoas autorizadas.
   Todas as conexões estão sendo monitoradas e armazenadas em log." > /etc/banner-client.net


   echo "
   ### Banner de entrada SSH
   Banner /etc/banner-client.net"  >>  /etc/ssh/sshd_config

   systemctl restart sshd


   echo 'Deseja instalar outro aplicativo? (Digite sim ou nao)'
                                   read escolha

                                                for i in $escolha; do


                                                        case $escolha in

                                                                sim) "Opção desconhecida." ; echo ;Principal ;;
                                                                nao)  exit ;;
                                                                  *) "Opção desconhecida." ; echo ;Principal ;;

                                                        esac
                                    done

          
    }



easy() {

mkdir /opt/easy

cd /opt/easy

wget -c http://192.168.50.224:8282/easy2l-redhat.tar.gz

tar zxfv easy2l-redhat.tar.gz

cd /opt/easy/easy2l

echo "Key para Easy: S3F9-8042"

chmod 777 sh /opt/easy/easy2l/install-easyinv.sh

sh /opt/easy/easy2l/install-easyinv.sh


echo 'Deseja instalar outro aplicativo? (Digite sim ou nao)'
                                   read escolha

                                                for i in $escolha; do


                                                        case $escolha in

                                                                sim) "Opção desconhecida." ; echo ;Principal ;;
                                                                nao)  exit ;;
                                                                  *) "Opção desconhecida." ; echo ;Principal ;;

                                                        esac
                                    done


}


senha() {

    echo 'Nome do usuario'

    read user

    passwd $user


   echo 'Deseja mudar a senha de outro USER? (Digite sim ou nao ou menu)'
                                   read escolha

                                                for i in $escolha; do


                                                        case $escolha in

                                                                sim) "Opção desconhecida." ; echo ;senha ;;
                                                                nao)  exit ;;
                                                                menu) "Opção desconhecida." ; echo ;Principal ;;
                                                                  *) "Opção desconhecida." ; echo ;Principal ;;

                                                        esac
                                    done


}


unessus() {

              
           
           /sbin/service nessusd stop
           
           rpm -qa | grep Nessus

           echo 'Qual e a versao do Nessus?'

           read vnessus
           
           rpm -e $vnessus
           
           rm -rf /opt/nessus
           
           
           echo 'Deseja instalar outro aplicativo? (Digite sim ou nao)'
                                              read escolha
           
                                                           for i in $escolha; do
           
           
                                                                   case $escolha in
           
                                                                           sim) "Opção desconhecida." ; echo ;Principal ;;
                                                                           nao)  exit ;;
                                                                             *) "Opção desconhecida." ; echo ;Principal ;;
           
                                                                   esac
                                               done
           
           


    }


uanessus() {
           
           /sbin/service nessusagent stop
           
           rpm -qa | grep Nessus

           echo 'Qual e a versao do Nessus?'

           read vnessus
           
           rpm -e $vnessus
           
           rm -Rf /opt/nessus_agent/
           
           
           echo 'Deseja instalar outro aplicativo? (Digite sim ou nao)'
                                              read escolha
           
                                                           for i in $escolha; do
           
           
                                                                   case $escolha in
           
                                                                           sim) "Opção desconhecida." ; echo ;Principal ;;
                                                                           nao)  exit ;;
                                                                             *) "Opção desconhecida." ; echo ;Principal ;;
           
                                                                   esac
                                               done
           
           


    }


upanessus() {



    /sbin/service nessusagent stop

    wget -c http://192.168.50.224:8282/NessusAgent-10.2.1-es7.x86_64.rpm

    rpm -Uvh NessusAgent-10.2.1-es7.x86_64.rpm

    cd /opt/nessus_agent/sbin/

#    ./nessuscli agent link --key=8c297735742f315545899cea6d124bfef1d959c7c1d494195d5dbc4497b87570 --groups="BRAZIL_Agents_Servers1" --cloud=yes 
    
    /sbin/service nessusagent start
    /sbin/service nessusagent status
           
                 
           
           echo 'Deseja instalar outro aplicativo? (Digite sim ou nao)'
                                              read escolha
           
                                                           for i in $escolha; do
           
           
                                                                   case $escolha in
           
                                                                           sim) "Opção desconhecida." ; echo ;Principal ;;
                                                                           nao)  exit ;;
                                                                             *) "Opção desconhecida." ; echo ;Principal ;;
           
                                                                   esac
                                               done
           
           


    }

profile() {

cd /usr/local/bin/

wget -c http://192.168.50.224:8282/dynmotd.sh

chmod +x dynmotd.sh

echo "/usr/local/bin/dynmotd.sh" >> /etc/profile

echo 'Deseja instalar outro aplicativo? (Digite sim ou nao)'
                                   read escolha

                                                for i in $escolha; do


                                                        case $escolha in

                                                                sim) "Opção desconhecida." ; echo ;Principal ;;
                                                                nao)  exit ;;
                                                                  *) "Opção desconhecida." ; echo ;Principal ;;

                                                        esac
                                    done


    }


#Ver 1.0 16/12/2022

Principal
