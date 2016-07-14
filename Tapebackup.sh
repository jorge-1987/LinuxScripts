#!/bin/bash
##
## FILE: Tapebackup.sh
##
## DESCRIPTION: A Script for using Tape Backup devices in a simple way from Linux Console.
## Working in the Translation to English
##
## AUTHOR: Jorge Abreu @ar_jorge1987
##
## DATE: 10/11/2010
## 
## VERSION: 1.2
##
## LANGUAGE: ESPAÑOL/ENGLISH
##
## USAGE: Non Arguments.
##

BackupArchivo()
{
echo "Ingrese el path/archivo a Copiar a la Cinta"
echo "Enter the path of the file to backup in the Tape"
#ARCHIVO=Ã`cat ArchivosBackup.tb`
#echo "Se va a realizar el backup del archivo $ARCHIVO"
read -p "Path: " ARCHIVO
#echo $ARCHIVO
echo "Realizando Backup de $ARCHIVO"
echo "Making backup of $ARCHIVO"
echo `mt -f /dev/nst0 stat` >> TapeBackup.log
echo `date` >> TapeBackup.log
echo "Se corrio Backup de $ARCHIVO" >> TapeBackup.log
echo "Runing backup of $ARCHIVO" >> TapeBackup.log
tar -cvzf /dev/nst0 $ARCHIVO
echo "Backup terminado, pulse una tecla"
echo "Backup finished, press any key"
read
}

RestaurarArchivo()
{
FILE=0
echo "Recuerde siempre Rebobinar antes de realizar esto"
echo "Con CTRL+C cancela la operacion"
echo "Indique el FileNumber para Restaurar"
read -p "File Numer: " FILE
mt -f /dev/nst0 fsf $FILE
tar xzvf /dev/nst0
echo `date` >> TapeBackup.log
echo "Se corrio Recuperar $FILE" >> TapeBackup.log
echo "Restaurado"
read
}

ListarArchivo()
{
echo "Se listaran las Sesiones y su contenido"
mt -f /dev/nst0 stat
tar -tzf /dev/nst0
#EGZIP=echo `$ESTADO | grep "error"`
#echo $EGZIP
echo `date` >> TapeBackup.log
echo "Se corrio Listar" >> TapeBackup.log
echo "El FileNumber es el necesario para realizar el Backup"
read
}

RebobinarCinta()
{
echo "Se rebobinara la Cinta, esto puede tardar varios minutos"
mt -f /dev/nst0 rewind
echo `date` >> TapeBackup.log
echo "Se corrio Rebobinar" >> TapeBackup.log
echo "Rebobinada, pulse una tecla para continuar"
read
}

BorrarCinta()
{
echo "Se borrara la cinta por completo, esto tardara varias horas"
echo "Presione enter para confirmar, de lo contrario Press CTRL+C"
read
mt -f /dev/nst0 rewind
mt -f /dev/nst0 erase
echo `date` >> TapeBackup.log
echo "Se corrio Borrado de Cinta" >> TapeBackup.log
echo "Se envio el comando de borrado de la cinta."
echo "Controle con la opcion de Status la liberacion de la misma"
read
}

StatusCinta()
{
echo "Estado de la Cinta:"
echo "Status of the Tape:"
mt -f /dev/nst0 stat
echo `date` >> TapeBackup.log
echo "Se corrio Status" >> TapeBackup.log
echo "Presione una tecla para finalizar"
echo "Enter any key to end"
read
}

MenuSeleccion()
{
echo "=================================================="
echo "Bienvenido al Script para manejo de la Tape Backup"
echo "Seleccione la Accion deseada                      "
echo "=================================================="
echo "1: Realizar el Backup de un archivo               "
echo "2: Restaurar un backup                            "
echo "3: Listar archivos en la cinta                    "
echo "4: Salir                                          "
echo "5: Rebobinar la Cinta                             "
echo "6: Borar la cinta por completo                    "
echo "7: Status de la Cinta                             "
echo "(Estos procesos pueden tardar mas de una hora)    "
echo "=================================================="
}

OPCION=0;
SALIR=4;
until [$OPCION -lt $SALIR]
 do
  clear #limpio la pantalÃla
  MenuSeleccion #muestro el Menu
  read -p "Opcion: " OPCION
  case $OPCION in 
 1) BackupArchivo 
 ;;
 2) RestaurarArchivo
 ;;
 3) ListarArchivo
 ;;
 4) exit
 ;;
 5) RebobinarCinta
 ;;
 6) BorrarCinta
 ;;
 7) StatusCinta
 ;;

 esac

done
