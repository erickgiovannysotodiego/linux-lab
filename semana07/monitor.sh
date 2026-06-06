#!/bin/bash
# monitor.sh - Vigila el uso de la red

LOG="monitor.log"

# Esto hace que el script se cierre bien si presionas Ctrl+C
trap 'echo " Cerrando..."; exit' INT

echo "Iniciando vigilancia..."

# Esto es un ciclo: repite la acción una y otra vez
while true; do
    # Lee el uso de red
    RX=$(grep 'eth0' /proc/net/dev 2>/dev/null | awk '{print $2}')
    echo "$(date) - Datos recibidos: ${RX:-0}" | tee -a "$LOG"
    
    # Espera 5 segundos antes de repetir
    sleep 5
done
