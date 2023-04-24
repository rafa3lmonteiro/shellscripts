#!/bin/bash

# Os script deve ser executado nos servidores Linux que precisam ser implementado o IDM

Principal() {

echo -e  " \033[1;32m
  ####    ######   ### ##        #####     ####   ######    ####    ######    ######
   ##     #######  #######      #######   ######  #######    ##     #######   ######
   ##     ##  ###  #######      ###  ##  ### ###  ### ###    ##     ##   ##   # ## #
   ##     ##   ##  ## # ##       ###     ##   #   ##  ##     ##     ##  ##      ##
   ##     ##   ##  ## # ##         ###   ##       ## ##      ##     ####        ##
  ####    ##   ##  ##   ##      ##  ###   ##  ##  ##  ##    ####    ##  #       ##
  ####    ######   ##   ##       #####     ####   ##   ##   ####    ##          ##

\033[m"

echo -e  "
\033[1;31m     1 - Listar Usuarios            2 - Bloquear Usuarios    3-Habilitar Usuarios
                     4 - Listar Sudoers               5 - Desabilitar Sudoers
\033[1;35m     6 - Mudar o hostname para o IDM                         8 - Implementar o IDM



                                             9 - SAIR

                                     Qual e a opção desejada?


\033[m"

 read opcao

  case $opcao in

    1) lusers ;;

    2) dusers ;;

    3) husers ;;

    4) lsudoers ;;

    5) dsudoers ;;

    6) hostname ;;

    7) hosts ;;

    8) idm ;;

    9) exit ;;

    *) "Opção desconhecida." ; echo -e ; Principal ;;

  esac

            }


lusers() {

    cat /etc/passwd | cut -d : -f1



echo -e "\033[1;32m Deseja voltar para o menu? (Digite sim ou nao)\033[m"
                                   read escolha

                                                for i in $escolha; do


                                                        case $escolha in

                                                                sim) "Opção desconhecida." ; echo -e ;Principal ;;
                                                                nao)  exit ;;

                                                                *) "Opção desconhecida." ; echo -e ;Principal ;;

                                                        esac
                                    done


}

dusers() {

    echo -e "\033[1;31m Nome do usuario: \033[m"

    read user

    usermod -L $user


echo -e "\033[1;31m Deseja bloquear outro usuario? (Digite sim ou nao ou menu)\033[m"
                                   read escolha

                                                for i in $escolha; do


                                                        case $escolha in

                                                                sim) "Opção desconhecida." ; echo -e ;dusers ;;
                                                                nao)  exit ;;
                                                                menu) "Opção desconhecida." ; echo -e ;Principal ;;
                                                                  *) "Opção desconhecida." ; echo -e ;Principal ;;

                                                        esac
                                    done


}


husers() {

    echo -e "\033[1;31m Nome do usuario: \033[m"

    read user

    usermod -U $user


echo -e "\033[1;32m Deseja habilitar outro usuario? (Digite sim ou nao ou menu)\033[m"
                                   read escolha

                                                for i in $escolha; do


                                                        case $escolha in

                                                                sim) "Opção desconhecida." ; echo -e ;dusers ;;
                                                                nao)  exit ;;
                                                                menu) "Opção desconhecida." ; echo -e ;Principal ;;
                                                                  *) "Opção desconhecida." ; echo -e ;Principal ;;

                                                        esac
                                    done


}


lsudoers() {

    grep -iR "ALL=" /etc/sudoers

    echo -e "\033[1;31m Os usuarios que estiverem com o simbolo # no inicio ja estao desabilitados\033[m"



echo -e "\033[1;32m Deseja voltar para o menu? (Digite sim ou nao)\033[m"
                                   read escolha

                                                for i in $escolha; do


                                                        case $escolha in

                                                                sim) "Opção desconhecida." ; echo -e ;Principal ;;
                                                                nao)  exit ;;

                                                                *) "Opção desconhecida." ; echo -e ;Principal ;;

                                                        esac
                                    done


}

dsudoers() {

    echo -e "\033[1;31m Nome do usuario: \033[m"

    read user

    sed -i "s/$user/#$user/g" /etc/sudoers


echo -e "\033[1;31m Deseja desabilitar outro usuario do sudoers? (Digite sim ou nao ou menu)\033[m"
                                   read escolha

                                                for i in $escolha; do


                                                        case $escolha in

                                                                sim) "Opção desconhecida." ; echo -e ;dsudoers ;;
                                                                nao)  exit ;;
                                                                menu) "Opção desconhecida." ; echo -e ;Principal ;;
                                                                  *) "Opção desconhecida." ; echo -e ;Principal ;;

                                                        esac
                                    done


}


hostname() {

    echo -e "\033[1;31mO nome do servidor e\033[m" `cat /etc/hostname`

    echo -e "\033[1;31mQual e o nome do servidor?\033[m"

    read nome

    #nome=`cat /etc/hostname`

    echo -e "\033[1;31mQual e o ip do servidor?\033[m"

    read ip

    echo  "$ip $nome.linux.ssa.corp $nome" >> /etc/hosts


    hostnamectl set-hostname $nome.linux.ssa.corp


    echo -e "\033[1;31mNovo nome do servidor\033[m"
    cat /etc/hostname


    echo -e "\033[1;31mNome do servidor no arquivo hosts\033[m"
    grep -iR "linux.ssa.corp" /etc/hosts











echo -e "\033[1;32m Deseja voltar para o menu? (Digite sim ou nao)\033[m"
                                   read escolha

                                                for i in $escolha; do


                                                        case $escolha in

                                                                sim) "Opção desconhecida." ; echo -e ;Principal ;;
                                                                nao)  exit ;;

                                                                *) "Opção desconhecida." ; echo -e ;Principal ;;

                                                        esac
                                    done


}



idm() {



    echo -e "\033[1;32m Qual é a versão do Red Hat? Digite 1 para RH8 ou 2 para RH7\033[m"
    echo -e "\033[1;32m Digite 1 para RH8\033[m"
    echo -e "\033[1;32m Digite 2 para RH7\033[m"
    echo -e "\033[1;32m Digite 3 para Menu\033[m"

                                   read escolha

                                                for i in $escolha; do


                                                        case $escolha in

                                                                 1) "Opção desconhecida." ; echo -e ;rh8 ;;
                                                                 2) "Opção desconhecida." ; echo -e ;rh7 ;;
                                                                 3) "Opção desconhecida." ; echo -e ;rh7 ;;
                                                                 4)  exit ;;

                                                                *) "Opção desconhecida." ; echo -e ;Principal ;;

                                                        esac
                                    done

}

rh8() {

     echo "search ssa.corp linux.ssa.corp" > /etc/resolv.conf
     echo "nameserver 192.168.50.235" >> /etc/resolv.conf


    yum makecache

    yum -y install @idm:client

#    yum install -y epel-release

    yum install -y ipa-client

    ipa-client-install --no-ntp --no-dns-sshfp --mkhomedir --enable-dns-updates --ssh-trust-dns



}

rh7() {

     echo "search ssa.corp linux.ssa.corp" > /etc/resolv.conf
    echo "nameserver 192.168.50.235" >> /etc/resolv.conf


    yum makecache


 #   yum install -y epel-release

    yum install -y ipa-client

    ipa-client-install --no-ntp --no-dns-sshfp --mkhomedir --enable-dns-updates --ssh-trust-dns



}





Principal





