#!/bin/bash
# check-disk.sh - Monitoreo avanzado con condicionales

LOG_FILE="disk_monitor.log"
DRY_RUN=false

# Función de log (Reutilizada del capstone)
log() {
    local nivel="$1"
    local mensaje="$2"
    local registro="$(date '+%Y-%m-%d %H:%M:%S') [$nivel] - $mensaje"
    
    if [ "$DRY_RUN" = true ]; then
        echo "[DRY-RUN] $registro"
    else
        echo "$registro" | tee -a "$LOG_FILE"
    fi
}

# Lógica principal con estructuras de control
verificar_particion() {
    local p="$1"
    local uso=$(df -h "$p" | tail -1 | awk '{print $5}' | sed 's/%//')

    if [ -z "$uso" ]; then
        log "ERROR" "No se pudo leer la partición $p"
        return
    fi

    # Condicionales: Lógica de la semana 6
    if [ "$uso" -gt 90 ]; then
        log "ERROR" "Partición $p en estado CRÍTICO ($uso%)"
    elif [ "$uso" -gt 75 ]; then
        log "WARNING" "Partición $p requiere atención ($uso%)"
    else
        log "OK" "Partición $p en estado normal ($uso%)"
    fi
}

# Validación de argumento --dry-run
if [ "$1" == "--dry-run" ]; then
    DRY_RUN=true
fi

verificar_particion "/"
verificar_particion "/home"

