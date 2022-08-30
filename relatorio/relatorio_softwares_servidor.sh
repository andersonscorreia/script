#!/bin/bash 
apt update 
a=(`dpkg -l | cut -d " " -f3`)
echo "Relatório Gerencial de Softwares do Servidor debian-isa">> teste.csv
echo "`date +"%d de %h de %Y"`">> teste.csv
echo "Pacote, Versão atual, Versão repositório, Seção, Prioridade, Necessita atualizar?" >> teste.csv
unset "a[0]"
unset "a[1]"
unset "a[2]"
f=0
for nome in "${a[@]}"
do
	
	versao_instalada=`apt list --installed | grep -w $nome|cut -d " " -f2 | head -n 1 ` 
	versao_repositorio=`apt-cache show $nome | grep Version | cut -d ":" -f2| head -n 1 `
	secao=`apt-cache show $nome | grep Section | cut -d ":" -f2 | head -n 1 `
	prioridade=`apt-cache show $nome | grep Priority | cut -d ":" -f2 | head -n 1 `
	if [ $versao_instalada = $versao_repositorio ]; then
		atualizar="Não"
	else
		atualizar="Sim"
	fi
	

echo "$nome,$versao_instalada,$versao_repositorio,$secao,$prioridade,$atualizar" >> teste.csv
echo $f

f=$((1+$f))
done


tar -cf `date +"%Y"/"%m"/`/`date +"softwares-%Y%m%d.tar.gz"` teste.csv



