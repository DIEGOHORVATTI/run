#!/usr/bin/env bash
######################################################################################
#                      automação de copilador em shellscript                         #
######################################################################################

function versao_f(){
	echo -e "\n"
	echo -e "┌───────────────────────────────────────┐"
	echo -e "│                                       │"
	echo -e "│    Run v0.0.1 | by Diego Horvatti     │"
	echo -e "│   https://github.com/DIEGOHORVATTI    │"
	echo -e "│                                       │"
	echo -e "└───────────────────────────────────────┘"
	echo -e "\n"
}

function help_f(){
	echo -e "\n"
	echo -e "┌───────────────────────────────────────┐"
	echo -e "│                                       │"
	echo -e "│ -v, --version = versão do soft        │"
	echo -e "│ -h, --help = informações das flags    │"
	echo -e "│ -c, --create-file = criar arquivo.c   │"
	echo -e "│ -g, --gitgnore = criar .gitgnore      │"
	echo -e "│                                       │"
	echo -e "│ Dependencias: 'colorls', 'grep'       │"
	echo -e "│ 'cppcheck', 'wget'                    │"
	echo -e "│                                       │"
	echo -e "│ Como usar ex: run arquivo.c           │"
	echo -e "│                                       │"
	echo -e "└───────────────────────────────────────┘"
	echo -e "\n"
}

function gitgnore_f(){
	wget https://gist.githubusercontent.com/DIEGOHORVATTI/30462a7868ae1df718a6c32c505a9ea3/raw/77d407af7e041727e6025f30531683aaab893a7d/.gitignore
	clear
	echo -e "\n"
	echo -e "┌───────────────────────────────────────┐"
	echo -e "│                                       │"
	echo -e "│        Create file:  .gitgnore       │"
	echo -e "│                                       │"
	echo -e "└───────────────────────────────────────┘"
	echo -e "\n"
}

function creat_file_f(){
	read -p ' New file: ' nome
	echo -e "\n"
	wget https://gist.githubusercontent.com/DIEGOHORVATTI/f1272263f3db0118f2d5d5bb3df0de8d/raw/ad09444126da9bb50bdd98b62cf5957f5feb895d/min.c -O $nome
	code $nome
	clear
}

function f_gitAll(){
	while :; do
		git branch -M main && 
		git add . && 
		git commit -m "$(date +'[%d/%m/%Y] [%H:%M] -- {%j, %A}')" && 
		git push -u origin main &&
		clear &&
		for ((i=10; i >= 0; i--)); do       
			echo -e "\n\033[0;34m🕗 $(($i))m\033 \033[1;32m $(date +'[%d/%m/%Y] [%H:%M] { %j }')\033[0m "
			sleep 1m 
		done
	done
}

function f_git_read(){
	read -p ' New commit: ' git
	git branch -M main && 
	git add . && 
	git commit -m "$git" && 
	git push -u origin main &&
	clear &&
	echo -e "\n\033[0;34m ✓✓:\033 $git \n"
}

for i in "$@"; do
	case $i in
	"" | -v | --version) 
		# ver versão, caso o parametro seja vazil ou -v 
		versao_f
		;;
		-h | --help) 
			help_f
		;;
		-c | --create-file)
			creat_file_f
		;;
		--gitgnore)
			gitgnore_f
		;;
		--git)
			f_git_read
		;;
		-git-date)
			f_gitAll
		;;
		*)
			# verificar que a flag é uma pasta e printa seu conteúdo
			if [ -d $i ];then
				echo -e "\n"
				echo -e "┌───────────────────────────────────────"
				echo -e "│                                       "
				echo -e "│  Directory> $i"
				echo -e "│                                       "
				echo -e "└───────────────────────────────────────"
				colorls --group-directories-first --almost-all 
				echo -e "\n"
				# verificar que o arquivo alvo foi achado e o executa
				elif [ -f $i ]; then
					clear && 
					#cppcheck ./$i && 
					echo -e "\n───────────────────────────────────────\n" && 
					gcc ./$1 -o /tmp/run.exe && /tmp/run.exe && 
					echo -e "\n\n───────────────────────────────────────\n"
				else
					# verificar que a flag usada não é nem arquivo em diretório e printa o conteúdo
					echo -e "\n"
					echo -e "┌───────────────────────────────────────"
					echo -e "│                                       "
					echo -e "│    Arquivo ou diretório inexistente   "
					echo -e "│                                       "
					echo -e "│    Erro: $i"  
					echo -e "│                                       "
					echo -e "└───────────────────────────────────────"
					echo -e "\n"
					colorls --group-directories-first --almost-all
					echo -e "\n"
					read -p ' Create New file[S/s][N/n]: ' quest
					case $quest in
						"s" | "S")
							creat_file_f
						;;
						"n" | "N")
							exit
						;;
						*)
							exit
						;;
					esac
			fi
	;;
	esac
done
