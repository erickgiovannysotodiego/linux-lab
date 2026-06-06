#!/bin/bash

# backup-check.sh - Validador de backups
# Uso: ./backup-check.sh [directorio_backup]

# === Constantes configurables ===
readonly VERSION="1.0.0"
readonly DIR_BACKUP="${1:-/backup}"
readonly DIR_LOGS="$(dirname "$0")/logs"
readonly LOGFILE="$DIR_LOGS/backup-check-$(date +%Y%m%d).log"
readonly MAX_HORAS_SIN_BACKUP=24
readonly MIN_TAMANIO_MB=10
readonly MAX_TAMANIO_MB=50000

# === Variables de estado global ===
estado_global="OK"

# === Función de uso ===
uso() {
    echo "Uso: $0 [directorio_backup]"
    echo "Directorio a verificar (por defecto: /backup)"
    exit 2
}

# === Función de logging ===
log() {
    local nivel="$1"
    local mensaje="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    printf "[%s] [%-7s] %s\n" "$timestamp" "$nivel" "$mensaje" | tee -a "$LOGFILE"

    if [ "$nivel" = "ERROR" ] && [ "$estado_global" != "ERROR" ]; then
        estado_global="ERROR"
    elif [ "$nivel" = "WARNING" ] && [ "$estado_global" = "OK" ]; then
        estado_global="WARNING"
    fi
}

# === Procesar argumentos especiales ===
case "${1:-}" in
    --version) echo "backup-check.sh v$VERSION"; exit 0 ;;
    --help|-h) uso ;;
esac

# Asegurar que el directorio de logs existe
mkdir -p "$DIR_LOGS"

# === Verificación 1: Existencia del directorio ===
verificar_directorio() {
    log "INFO" "Verificando directorio: $DIR_BACKUP"

    if [ ! -e "$DIR_BACKUP" ]; then
        log "ERROR" "El directorio '$DIR_BACKUP' no existe."
        return 1
    fi

    if [ ! -d "$DIR_BACKUP" ]; then
        log "ERROR" "'$DIR_BACKUP' existe pero no es un directorio."
        return 1
    fi

    if [ ! -r "$DIR_BACKUP" ]; then
        log "ERROR" "Sin permiso de lectura en '$DIR_BACKUP'."
        return 1
    fi

    log "OK" "Directorio accesible: $DIR_BACKUP"
    return 0
}

# === Inicio del reporte ===
log "INFO" "=== backup-check.sh v$VERSION - Inicio ==="
log "INFO" "Directorio objetivo: $DIR_BACKUP"

if ! verificar_directorio; then
    log "ERROR" "Verificación abortada: directorio inaccesible."
    exit 1
fi
# === Verificación 2: Contenido de archivos ===
verificar_archivos() {
    log "INFO" "Verificando contenido en $DIR_BACKUP"
    
    local num_archivos=$(find "$DIR_BACKUP" -maxdepth 1 -type f -name "*.tar.gz" | wc -l)
    
    if [ "$num_archivos" -eq 0 ]; then
        log "WARNING" "No se encontraron archivos de backup (*.tar.gz) en $DIR_BACKUP"
        return 1
    fi
    
    # Verificar que el último archivo no esté vacío
    local ultimo=$(find "$DIR_BACKUP" -maxdepth 1 -type f -name "*.tar.gz" | sort | tail -1)
    if [ ! -s "$ultimo" ]; then
        log "ERROR" "El archivo más reciente está vacío: $ultimo"
        return 1
    fi
    
    log "OK" "Se encontraron $num_archivos archivos de backup."
    return 0
}
# === Verificación 3: Antigüedad ===
verificar_antiguedad() {
    log "INFO" "Verificando antigüedad del backup más reciente"
    
    local recientes=$(find "$DIR_BACKUP" -maxdepth 1 -type f -name "*.tar.gz" -mtime -1 | wc -l)
    
    if [ "$recientes" -eq 0 ]; then
        log "WARNING" "No hay backups de las últimas $MAX_HORAS_SIN_BACKUP horas."
        return 1
    fi
    
    log "OK" "Backup reciente encontrado ($recientes archivo(s))."
    return 0
}
# === Verificación 4: Tamaño del directorio ===
verificar_tamanio() {
    log "INFO" "Verificando tamaño del directorio"
    
    local tamanio=$(du -sm "$DIR_BACKUP" | awk '{print $1}')
    
    if [ "$tamanio" -lt "$MIN_TAMANIO_MB" ]; then
        log "WARNING" "Backup muy pequeño: ${tamanio}MB"
    elif [ "$tamanio" -gt "$MAX_TAMANIO_MB" ]; then
        log "ERROR" "Backup demasiado grande: ${tamanio}MB"
        return 1
    else
        log "OK" "Tamaño del backup dentro del rango: ${tamanio}MB"
    fi
    return 0
}
# === Ejecución principal ===
verificar_directorio
verificar_archivos
verificar_antiguedad
verificar_tamanio

# Reporte final
log "INFO" "Estado final del backup: $estado_global"

case "$estado_global" in
    OK)      exit 0 ;;
    WARNING) exit 0 ;;
    ERROR)   exit 1 ;;
esac
