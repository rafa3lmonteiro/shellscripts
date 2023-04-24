#!/bin/sh

SO=$1
IP_SERVER=$2
IP_SERVER_ACTIVE=$3
ZABBIX_PORTA=$4
METADATA=$5

INSTALA_CENTOS_RH_6="/opt/zabbix/script/deploy_centos_rh_6.sh"
INSTALA_CENTOS_RH_7="/opt/zabbix/script/deploy_centos_rh_7.sh"
INSTALA_CENTOS_RH_8="/opt/zabbix/script/deploy_centos_rh_8.sh"
INSTALA_CENTOS_RH_9="/opt/zabbix/script/deploy_centos_rh_9.sh"
INSTALA_UBUNTU_18="/opt/zabbix/script/deploy_ubuntu_18.sh"
INSTALA_UBUNTU_20="/opt/zabbix/script/deploy_ubuntu_20.sh"
INSTALA_UBUNTU_22="/opt/zabbix/script/deploy_ubuntu_22.sh"
INSTALA_DEBIAN_9="/opt/zabbix/script/deploy_debian_9.sh"
INSTALA_DEBIAN_10="/opt/zabbix/script/deploy_debian_10.sh"
INSTALA_DEBIAN_11="/opt/zabbix/script/deploy_debian_11.sh"

if [ ! -z "$SO" ] | [ ! -z "$IP_SERVER" ] | [ ! -z "$IP_SERVER_ACTIVE" ] | [ ! -z "$ZABBIX_PORTA" ] | [ ! -z "$METADATA" ] 
then
      export SO
      export IP_SERVER
      export IP_SERVER_ACTIVE
      export ZABBIX_PORTA
      export METADATA
      
	case $SO in
                        1)
                                        #Deploy Centos / RH 6
                                        source "$INSTALA_CENTOS_RH_6"
					break
                        ;;

                        2)

                                        #Deploy Centos / RH 7
					source "$INSTALA_CENTOS_RH_7"
                                        break
                        ;;

			3)

                                        #Deploy Centos / RH 8
					source "$INSTALA_CENTOS_RH_8"
                                        break
                        ;;

			4)

                                        #Deploy Centos / RH 9
					source "$INSTALA_CENTOS_RH_9"
                                        break
                        ;;

			5)

                                        #Deploy Debian 9
					source "$INSTALA_DEBIAN_9"
                                        break
                        ;;

			6)

                                        #Deploy Debian 10
                                        source "$INSTALA_DEBIAN_10"
                                        break
                        ;;
			
			7)

                                        #Deploy Debian 11
                                        source "$INSTALA_DEBIAN_10"
                                        break
                        ;;


			8)

                                        #Deploy Ubuntu 18
					source "$INSTALA_UBUNTU_18"
                                        break
                        ;;

			9)

                                        #Deploy Ubuntu 20
                                        source "$INSTALA_UBUNTU_20"
                                        break
                        ;;

			10)

                                        #Deploy Ubuntu 22
                                        source "$INSTALA_UBUNTU_22"
                                        break
                        ;;

                        *)
                                        echo "Opção Invalida. Tente novamente."
                        ;;
                esac
else
	echo ""
	echo "Quantidade de Parametros Passada Para o Instalador foi Incorreta, Forma Correta:"
	echo ""
	echo "/deploy_zabbix_linux.sh A B C D E                    onde:"
	echo ""
	echo "A = Sistema Operacional, 1=CENTOS ou RH 6 / 2=CENTOS ou RH 7 / 3=CENTOS ou RH 8 / 4=CENTOS ou RH 9"
	echo "		         5=DEBIAN 9 / 6=DEBIAN 10 / 7=DEBIAN 11"
	echo "                         8=UBUNTU 18 / 9=UBUNTU=20 / 10=UBUNTU 22"
	echo "B = IP do Zabbix Proxy ou Zabbix Server"
	echo "C = IP do Zabbix Server"
	echo "D = Porta Utilizada pelo Agente Zabbix"
	echo "E = Metadata Utilizada para Registro Automatico de Hosts"
	echo "Exemplor de Utilizacao:"
	echo ""
	echo "./deploy_zabbix_linux.sh 2 192.168.99.254 192.168.99.253 10080 Linux_Sonepar"
	echo ""
fi
