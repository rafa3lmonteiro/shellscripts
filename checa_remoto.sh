#!/bin/bash      
#########################################################
# Script para as checagem do servidor no remoto:	#
#- Checagem de diferença de horario client/server	#
#- Checagem de Zdump [Timezone]				#
#- Checagem de status NTPQ				#
#							#
#Depende:						#
#- Script checa_timezone.sh				#
#- binario NC (netcat)					#
#- sshpass						#
#- lista de servidores para checagem 			#
#							#		
#  							#	
# Rafael Araujo 					#
# 							#
# Ultima atualizacao: Out/2018 				#
#########################################################

#datafile=`date +%Y%m%d-%H%M`
html_result="result.htm"     
lista="lista.lst"            
checa_timezone="checa_timezone.sh"
tipo="remote"


#checagem de execucao do sshpass/checa_timezone e escrita no diretorio
if ! [ -f "sshpass" -o -x "sshpass" ];then                            
        echo "Sem sshpass ou nao tem permissao de execucao!"   

                elif ! [ -f "$checa_timezone" -o -x "$checa_timezone" ];then
                        echo "$checa_timezone nao existe ou nao tem permissao de execucao!"

                        elif ! [ -f "$lista" -o -s "$lista" ];then
                                echo "$lista nao existe ou esta vazio!"

                                elif ! touch $html_result;then
                                        echo "$PWD nao tem permissao de escrita para result.htm!"

#executa o script abaixo
else                    

#cria inicio da tabela em $html_result

echo "<div align=right><font face="Verdana, Arial, Helvetica" size=3>Ultima atualizacao: $(date +%d/%m/%Y-%H:%M)</font></div>
<table border=0  width=1500 cellspacing=2 cellpading=2>                                                                      
<tr><td><center><font face="Verdana, Arial, Helvetica" size=1><b>Num</b></font></td>                                         
<td><center><font face="Verdana, Arial, Helvetica" size=1><b>Hostname</b></font></td>                                        
<td><center><font face="Verdana, Arial, Helvetica" size=1><b>S.O</b></font></td>                             
<td><font face="Verdana, Arial, Helvetica" size=1><center><b>date</b></font></td>                            
<td><font face="Verdana, Arial, Helvetica" size=1><center><b>date -u</b></font></td>                         
<td><font face="Verdana, Arial, Helvetica" size=1><center><b>Timezone</b></font></td>                        
<td><font face="Verdana, Arial, Helvetica" size=1><center><b>Diferenca de Hora/Data</b></font></td>          
<td><font face="Verdana, Arial, Helvetica" size=1><center><b>zdump -v [timezone]</b></font></td>             
<td><font face="Verdana, Arial, Helvetica" size=1><center><b>NTP</b></font></td></tr>" > $html_result        


#inicia contador para criacao das cores da tabela
count=1                                          

        #Leitura na lista de maquinas
        for i in `cat $lista`     
        do                        

        data_hora=`date +%H`
        data_minuto=`date +%M`
        data_dia=`date +%Y%m%d`


		#separando os campos do arquivo lista.lst

		maquina=`echo $i | cut -d\; -f1`
                #ip=`echo $i | cut -d\; -f2`
                usuario=`echo $i | cut -d\; -f2`
                #senha=`echo $i | cut -d\; -f4`  
                #tipo=`echo $i | cut -d\; -f4`  

           
	       bgcolor_num=$[ $count & 1 ]
                #cria background das colunas baseadas no for da lista
                        if [ $bgcolor_num -eq 0 ]; then              
                color="c0c0c0"                                       
                        else                                         
                color="e0e0e0"                                       
                        fi                                           

        #verifica se no campo usuario contem string manual, caso tenha nao executa comandos remotos
case "$tipo" in                                                                                   
                'manual')                                                                         
                echo "<tr bgcolor=yellow><td><center><font face="Verdana, Arial, Helvetica" size=1>$count</font></td>
                <td><center><font face="Verdana, Arial, Helvetica" size=1>$maquina</font></td>                       
                <td colspan=7><center><font face="Verdana, Arial, Helvetica" size=1><b>Servidor feito atraves de Check Manual</b></font></td>
                </tr>" >> $html_result                                                                                                       
                ;;                                                                                                                           

                'noinfo')
                echo "<tr bgcolor=CCCC33><td><center><font face="Verdana, Arial, Helvetica" size=1>$count</font></td>
                <td><center><font face="Verdana, Arial, Helvetica" size=1>$maquina</font></td>                       
                <td colspan=7><center><font face="Verdana, Arial, Helvetica" size=1><b>Servidor sem informa�oes de acesso</b></font></td>
                </tr>" >> $html_result                                                                                                   
                ;;                                                                                                                       

                'noaccess')
                echo "<tr bgcolor=FF9900><td><center><font face="Verdana, Arial, Helvetica" size=1>$count</font></td>
                <td><center><font face="Verdana, Arial, Helvetica" size=1>$maquina</font></td>                       
                <td colspan=7><center><font face="Verdana, Arial, Helvetica" size=1><b>Servidor sem conectividade/acesso</b></font></td>
                </tr>" >> $html_result                                                                                                  
                ;;                                                                                                                      

                'remote')

        ssh_command="./sshpass -e ssh -o StrictHostKeyChecking=no -o NumberOfPasswordPrompts=1 $usuario@$maquina"
        scp_command="./sshpass -e scp -o StrictHostKeyChecking=no -o NumberOfPasswordPrompts=1 $checa_timezone  $usuario@$maquina:/tmp"


        echo "Executando verificacao em: $maquina"
        #teste de conexao na porta ssh da maquina 
        ./nc -z -w 2 $maquina 22                       
        if [ $? -eq 0 ];then                      
                #descobre tipo da maquinas        
                UXTIPO=`$ssh_command uname -s`    

#Para maquinas LINUX ou SOLARIS, executa script com bash
  
              if [ "$UXTIPO" = "SunOS" -o "$UXTIPO" = "Linux" ];then  

                        $scp_command
                        #$ssh_command ls /tmp/$checa_timezone

                        if [ $? -eq 2 ];then
                                echo "<tr bgcolor=red><td><center><font face="Verdana, Arial, Helvetica" size=1>$count</font></td>
                                <td><center><font face="Verdana, Arial, Helvetica" size=1 color=white>$maquina</font></td>        
                                <td colspan=6><center><font face="Verdana, Arial, Helvetica" size=1 color=white><b>Erro no envio do script/scp checa_timezone</b></font></td>                                                                                                                
                                </tr>" >> $html_result                                                                                         
                        else 

$ssh_command chmod +x /tmp/$checa_timezone                                                                                                 
$ssh_command /tmp/$checa_timezone $color $data_hora $data_minuto $data_dia $count >> $html_result                                          
$ssh_command rm -f /tmp/$checa_timezone                                                                                                                  
                        fi                                                                                                                     
                fi
        else

                #caso nao acesso na porta do ssh
                        echo "<tr bgcolor=red><td><center><font face="Verdana, Arial, Helvetica" size=1>$count</font></td>
                        <td><center><font face="Verdana, Arial, Helvetica" size=1 color=white>$maquina</font></td>
                        <td colspan=7><center><font face="Verdana, Arial, Helvetica" size=1 color=white><b>Problema na Conexao com o Servidor</b></font></td>
                        </tr>" >> $html_result

        fi
        ;;
esac
        let count++
        done
fi
echo "</table>" >> $html_result
