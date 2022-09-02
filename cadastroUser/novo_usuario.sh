#!/bin/bash
USUARIO=$2
TIPO=$1
LEN=$#



cadastro() {
	if [ `cut -d ':' -f1 /etc/group | grep -w $GRUPO` ];then
		adduser --disabled-password --gecos GECOS --home /home/$GRUPO/$USUARIO $USUARIO
		passwd -d $USUARIO
		passwd -e $USUARIO
		adduser $USUARIO $GRUPO 
		cp regras.txt /home/$GRUPO/$USUARIO
		echo -e " Olá $USUARIO, seja bem-vindo(a) à EMPRESA X. \n Seu cargo na instituição é de: $GRUPO \n A ativação do seu cadastro foi realizada em: `date +"%d de %h de %Y às %H:%M:%S"` \n Bom trabalho!" >> /home/$GRUPO/$USUARIO/welcome_$USUARIO.txt	
		echo 'usuario criado'		
	else
		echo 'Grupo não Existente'
	fi 

}


if [ $LEN -eq 2 ]; then
	if [ `cut -d ':' -f1 /etc/passwd | grep -w $USUARIO`  ]; then
		echo 'Usuario ja cadastrado'
	else
		if [ $TIPO = 'professor']; then
			GRUPO = 'professores'
			cadastro()
		elif [ $TIPO = 'aluno' ]; then
			GRUPO = 'alunos'
			cadastro()
		elif [ $TIPO = 'tecnico' ]; then
			GRUPO = 'tecnicos'
			cadastro()
		else:
			echo 'Tipo de usuario não pode ser cadastrado'
			
		fi
		    
	fi

else
	echo 'Argumentos invalidos'
	echo './novo_usuario.sh <grupo> <usuario>'
fi
