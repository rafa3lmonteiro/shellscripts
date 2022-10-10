#!/bin/bash
#########################################################
# Script para as checagem de Timezone no servidor:	#
#							#
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
# Rafael Monteiro 					#
# 							#
# Ultima atualizacao: Out/2018 				#
#########################################################


HOST=`uname -n`
UXTIPO=`uname -s`
color=$1
data_hora=$2
data_minuto=$3
data_dia=$4
count=$5
zdump_result1="/tmp/zdump-result1.txt"
zdump_result2="/tmp/zdump-result2.txt"
ntp_result1="/tmp/ntp_result1.txt"
zdump_command="/usr/sbin/zdump"

if [ -f "/usr/sbin/zdump" ];then
                zdump_command="/usr/sbin/zdump"
        elif [ -f "/usr/bin/zdump" ];then
                zdump_command="/usr/bin/zdump"
        elif [ -f "/usr/local/bin/zdump" ];then
        zdump_command="/usr/local/bin/zdump"
	else
	zdump_command=""
        fi




verifica_ntp() {

	if [ -f "/usr/sbin/ntpq" ];then
		ntpq_command="/usr/sbin/ntpq"
	elif [ -f "/usr/bin/ntpq" ];then
		ntpq_command="/usr/bin/ntpq"
	else 
	ntpq_command=""
	fi

if [ ! "$ntpq_command" = "" ];then
			
	$ntpq_command -np > $ntp_result1
	#$ntpq_command -np 2>> $ntp_result1
	conta_ntp=`wc -l < $ntp_result1`
	if grep "*" $ntp_result1 > /dev/null;then
		ntpcolor="green"
	else
		ntpcolor="black"
	fi

echo "<td width=20%><font face='Verdana, Arial, Helvetica' size=1 color=$ntpcolor>"	
				i=1 
				while [ $i -le $conta_ntp ]
				do 
				sed -n ''$i'p' $ntp_result1 
				echo "<br>" 
				i=$((i+1))
				done
	
				$ntpq_command -np 2> $ntp_result1 && cat $ntp_result1	
				
echo "</font></td>"			
rm -f $ntp_result1

else
	echo "<td width=20%><font face='Verdana, Arial, Helvetica' size=1 color=$ntpcolor><center>Comando NTPQ nao existe</font></td>"
fi

#rm -f $ntp_result1

}

verifica_data(){

	diferenca_hora=`expr $(date +%H) - $data_hora`
	diferenca_hora=`expr $diferenca_hora \* 60`
	
	diferenca_minuto=`expr $(date +%M) - $data_minuto`
	
	diferenca_hora=`expr $diferenca_hora + $diferenca_minuto`
	
	echo "<td>"
	
	if [ $diferenca_hora -ne 0 ];then
		msg_hora="<font face='Verdana, Arial, Helvetica' size=1 color=red><center><b>Hora Checagem: $data_hora:$data_minuto<br>Diferenca de Hora: "$diferenca_hora"m</b></font>"
	
	else
		msg_hora="<font face='Verdana, Arial, Helvetica' size=1 color=black><center><b>Diferenca de Hora: "$diferenca_hora"m</b></font>"
	fi
	
	
	if [ $data_dia -eq $(date +%Y%m%d) ];then
		msg_data="<font face='Verdana, Arial, Helvetica' size=1 color=black><center><b>Data Correta<b></font>"
	
	else
		msg_data="<font face='Verdana, Arial, Helvetica' size=1 color=red><center><b>Data Incorreta<b></font>"
		
	fi
	
	echo $msg_hora
	echo "<br>"
	echo $msg_data
	
	echo "</td>"
	
}
	

golinux() {
if [ ! "$zdump_command" = "" ];then
       if $zdump_command -v /etc/localtime | grep -q 2018; then
#	   if $zdump_command -v /etc/localtime | egrep -e '2018';then
                $zdump_command -v /etc/localtime | egrep -e '2018' > $zdump_result1
				conta_zdump=`wc -l < $zdump_result1`
				
				if grep -q "Sat Nov 17 23:59:59 2018" $zdump_result1;then
					tzcolor="green"
				
				fi
				
				if [ -f "$zdump_result2" ];then
					rm -f $zdump_result2
				fi
				
				for i in `seq 1 $conta_zdump`
				do
				sed -n ''$i'p' $zdump_result1 >> $zdump_result2
				echo "<br>" >> $zdump_result2
				done
				
		else
				echo "Sem zdump para ano 2018" > $zdump_result2
        fi
else 
echo "Comando zdump nao encontrado" > $zdump_result2
fi
		
		echo "<tr bgcolor=$(echo $color)><td><center><font face="Verdana, Arial, Helvetica" size=1>$count</font></td>
		<td><center><font face="Verdana, Arial, Helvetica" size=1>$(uname -n)</font></td>
		<td><center><font face="Verdana, Arial, Helvetica" size=1>$(uname -s)</font></td>
		<td><font face="Verdana, Arial, Helvetica" size=1><center>$(/bin/date)</font></td>
		<td><font face="Verdana, Arial, Helvetica" size=1><center>$(/bin/date -u)</font></td>
		<td><font face="Verdana, Arial, Helvetica" size=1><center>$(/bin/date -R)</font></td>"
		verifica_data
		echo "<td width=40%><font face="Verdana, Arial, Helvetica" size=1 color=$tzcolor>$(cat $zdump_result2)</font></td>"
		verifica_ntp
		echo "</tr>"
		
		rm -f $zdump_result1
		rm -f $zdump_result2
		
}

gosolaris(){
if [ ! "$zdump_command" = "" ];then
        #if $zdump_command -v $TZ | grep 200[89] > /dev/null ;then
		if $zdump_command -v $TZ | egrep -e '2018' > /dev/null ;then
                $zdump_command -v $TZ | egrep -e '2018' > $zdump_result1
				conta_zdump=`wc -l < $zdump_result1`
				
				if grep "Sat Feb 20 23:59:59 2018" $zdump_result1 > /dev/null;then
					tzcolor="green"
				fi
				
				if [ -f "$zdump_result2" ];then
					rm -f $zdump_result2
				fi
				
				i=1 
				while [ $i -le $conta_zdump ]
				do 
				sed -n ''$i'p' $zdump_result1 >> $zdump_result2
				echo "<br>" >> $zdump_result2
				i=$((i+1))
				done
				
		else
				echo "Sem zdump para ano 2018" > $zdump_result2
        fi
else
echo "Comando zdump nao encontrado" > $zdump_result2
fi

		
		echo "<tr bgcolor=$(echo $color)><td><center><font face="Verdana, Arial, Helvetica" size=1>$count</font></td>
		<td><center><font face="Verdana, Arial, Helvetica" size=1>$(uname -n)</font></td>
		<td><center><font face="Verdana, Arial, Helvetica" size=1>$(uname -s)</font></td>
		<td><font face="Verdana, Arial, Helvetica" size=1><center>$(/bin/date)</font></td>
		<td><font face="Verdana, Arial, Helvetica" size=1><center>$(/bin/date -u)</font></td>
		<td><font face="Verdana, Arial, Helvetica" size=1><center>$(echo $TZ)</font></td>"
		verifica_data
		echo "<td width=40%><font face="Verdana, Arial, Helvetica" size=1 color=$tzcolor>$(cat $zdump_result2)</font></td>"
		verifica_ntp
		echo "</tr>"
		
		rm -f $zdump_result1
		rm -f $zdump_result2		

			
		
}

goaix(){
		tz_environment=`grep ^TZ /etc/environment`
		if [ "tz_environment" = "GRNLNDST3GRNLNDDT,M10.3.0/00:00:00,M2.3.0/00:00:00" ];then
			tz_color="green"
		else
			tz_color="black"
		fi
		
		
		echo "<tr bgcolor=$(echo $color)><td><center><font face="Verdana, Arial, Helvetica" size=1>$count</font></td>
		<td><center><font face="Verdana, Arial, Helvetica" size=1>$(uname -n)</font></td>
		<td><center><font face="Verdana, Arial, Helvetica" size=1>$(uname -s)</font></td>
		<td><font face="Verdana, Arial, Helvetica" size=1><center>$(/usr/bin/date)</font></td>
		<td><font face="Verdana, Arial, Helvetica" size=1><center>$(/usr/bin/date -u)</font></td>
		<td><font face="Verdana, Arial, Helvetica" size=1><center>$(echo $TZ | cut -d, -f1)</font></td>"
		verifica_data
		echo "<td width=40%><font face="Verdana, Arial, Helvetica" size=1 color=$tz_color><center>$(grep ^TZ /etc/environment)</font></td>"
		verifica_ntp
		echo "</tr>"

}

gohpux(){
		linha_inicio=`grep -n "$TZ" /usr/lib/tztab | grep -v "#" | cut -f1 -d:`
		if [ $? -ne 0 ];then
			linha_fim=`expr $linha_inicio + 5`
			tztab_result=`sed -n ''$linha_inicio,$linha_fim'p' /usr/lib/tztab`
		else
			tztab_result="Sem configuracao de HV"
		fi
		
		echo "<tr bgcolor=$(echo $color)><td><center><font face="Verdana, Arial, Helvetica" size=1>$count</font></td>
		<td><center><font face="Verdana, Arial, Helvetica" size=1>$(uname -n)</font></td>
		<td><center><font face="Verdana, Arial, Helvetica" size=1>$(uname -s)</font></td>
		<td><font face="Verdana, Arial, Helvetica" size=1><center>$(/usr/bin/date)</font></td>
		<td><font face="Verdana, Arial, Helvetica" size=1><center>$(/usr/bin/date -u)</font></td>
		<td><font face="Verdana, Arial, Helvetica" size=1><center>$(echo $TZ)</font></td>"
		verifica_data
		echo "<td width=40%><font face="Verdana, Arial, Helvetica" size=1><center>$(echo $tztab_result)</font></td>"
		verifica_ntp
		echo "</tr>"
		
}

case "$UXTIPO" in
'Linux')
   golinux
;;
'SunOS')
   gosolaris
;;
'AIX')
   goaix
;;
'HP-UX')
   gohpux
;;
'*')
   echo "$UXTIPO - SISTEMA OPERACIONAL DESCONHECIDO PARA O SCRIPT"
   exit 1
;;
esac

