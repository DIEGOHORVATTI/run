#!/usr/bin/env bash
######################################################################################
#                      automação de copilador em shellscript                         #
######################################################################################

for i in "$@"; do
	case $i in
		# ver versão, caso o parametro seja vazil ou -v 
		"" | -v | --version) 
			echo -e "\n"
			echo -e "┌───────────────────────────────────────┐"
			echo -e "│                                       │"
			echo -e "│    Run v0.0.1 | by Diego Horvatti     │"
			echo -e "│   https://github.com/DIEGOHORVATTI    │"
			echo -e "│                                       │"
			echo -e "└───────────────────────────────────────┘"
			echo -e "\n"
		;;
		-h | --help) 
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
		;;
		-c | --create-file)
			# novo arquivo de estrutura minima para C, usando entrata de texto
			read -p ' New file: ' nome
			echo -e "\n"
			wget https://gist.githubusercontent.com/DIEGOHORVATTI/f1272263f3db0118f2d5d5bb3df0de8d/raw/8346a43c9b3c75a463ad6b500d89699eca76e9b8/min.c -O $nome.c
			code $nome.c
			clear
		;;
		-g | --gitgnore)
			wget https://gist.githubusercontent.com/DIEGOHORVATTI/30462a7868ae1df718a6c32c505a9ea3/raw/77d407af7e041727e6025f30531683aaab893a7d/.gitignore
			clear
			echo -e "\n"
			echo -e "┌───────────────────────────────────────┐"
			echo -e "│                                       │"
			echo -e "│        Create file:  .gitgnore       │"
			echo -e "│                                       │"
			echo -e "└───────────────────────────────────────┘"
			echo -e "\n"
		;;
		*)
			# verificar de a pasta ./exe exite caso não, criar
			if [ ! -d ./.exe ];then
				mkdir ./.exe
				clear
				echo -e "\n"
				echo -e "┌───────────────────────────────────────┐"
				echo -e "│                                       │"
				echo -e "│      Create directory:   ./.exe      │"
				echo -e "│                                       │"
				echo -e "└───────────────────────────────────────┘"
				echo -e "\n"
				else
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
							cppcheck ./$i && 
							echo -e "\n───────────────────────────────────────\n" && 
							gcc ./$i -o ./.exe/run.exe && 
							./.exe/run.exe && 
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
					fi
			fi
		;;
	esac
done
