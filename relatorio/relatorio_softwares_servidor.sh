#!/bin/bash 
apt update 
a=(`dpkg -l | cut -d " " -f3`)
echo "Relatório Gerencial de Softwares do Servidor debian-isa" >> relatorio.csv
echo "`date +"%d de %h de %Y"`" >> relatorio.csv
echo "Pacote, Versão atual, Versão repositório, Seção, Prioridade, Necessita atualizar?" >> relatorio.csv
unset "a[0]"
unset "a[1]"
unset "a[2]"

for nome in "${a[@]}"
do
	
	versao_instalada=`dpkg -l $nome | grep $nome | awk {'print $3'} ` 
	versao_repositorio=`apt-cache show $nome | grep Version | awk {'print $2'}| head -n 1 `
	secao=`apt-cache show $nome | grep Section | awk {'print $2'} | head -n 1 `
	prioridade=`apt-cache show $nome | grep Priority | awk {'print $2'} | head -n 1 `
	if [ $versao_instalada = $versao_repositorio ]; then
		atualizar="Não"
	else
		atualizar="Sim"
	fi
	

echo "$nome,$versao_instalada,$versao_repositorio,$secao,$prioridade,$atualizar" >> relatorio.csv



done


tar -zcvf /var/backups/relatorios/`date +%Y/%m/softwares-%Y%m%d.tar.gz` relatorio.csv



