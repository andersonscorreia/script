#!/bin/bash
USUARIO=$2
GRUPO=$1
if [ `cut -d ':' -f1 /etc/passwd | grep -w $USUARIO`  ]; then
	echo 'Usuario ja cadastrado'
else
	if [ `cut -d ':' -f1 /etc/group | grep -w $GRUPO` ];then
		adduser --disabled-password --gecos GECOS --home /home/$GRUPO/$USUARIO $USUARIO
		passwd -e $USUARIO
		adduser $USUARIO $GRUPO 
		cp regras.txt /home/$GRUPO/$USUARIO
		echo -e " Olá $USUARIO, seja bem-vindo(a) à EMPRESA X. \n Seu cargo na instituição é de: $GRUPO \n A ativação do seu cadastro foi realizada em: `date +"%d de %h de %Y às %H:%M:%S"` \n Bom trabalho!" >> /home/$GRUPO/$USUARIO/welcome_$USUARIO.txt				
		
		
				
		echo 'usuario criado'		
	else
		echo 'Grupo não Existente'
	fi     
fi

