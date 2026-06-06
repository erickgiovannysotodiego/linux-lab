#!/bin/bash
# monitor-procesos.sh - Script de evaluación Semana 9

# Función: Listar procesos de un usuario
procesos_usuario() {
    echo -e "\n--- Procesos del usuario: $1 ---"
    ps -u "$1" -o pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head -n 6
}

# Lógica principal
if [[ "$1" == "-i" && -n "$2" ]]; then
    # Modo monitoreo continuo (Petición del PDF)
    INTERVALO=$2
    echo "Iniciando monitoreo continuo cada $INTERVALO segundos. (Ctrl+C para salir)"
    while true; do
        clear
        echo "--- Reporte de Procesos (CPU Top 5) ---"
        ps aux --sort=-%cpu | head -n 6
        sleep "$INTERVALO"
    done
elif [[ -n "$1" ]]; then
    # Modo usuario específico
    procesos_usuario "$1"
else
    # Modo reporte simple
    echo "--- Reporte de Procesos (Top 5) ---"
    ps aux --sort=-%cpu | head -n 6
fi
