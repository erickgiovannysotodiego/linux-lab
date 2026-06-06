#!/bin/bash
# datos.sh - Arrays asociativos (Clave -> Valor)

declare -A usuario_uid

# Asignamos valores a claves
usuario_uid["root"]=0
usuario_uid["bin"]=1
usuario_uid["daemon"]=2

# Accedemos usando la clave
echo "El UID del usuario root es: ${usuario_uid["root"]}"
