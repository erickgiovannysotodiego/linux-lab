#!/bin/bash
# sysinfo.sh - Reporte del estado del sistema

readonly VERSION="1.0.0"
readonly SEPARADOR="==========================================="
readonly SEPARADOR_SEC="-------------------------------------------"

uso () {
    echo "Uso: $0 [opcion]"
    echo "Opciones: --all, --cpu, --mem, --disk, --proc, --net"
    exit 2
}

MODO="${1:-all}"

seccion_general () {
    echo "[ INFORMACION DEL SISTEMA ]"
    echo "$SEPARADOR_SEC"
    printf "%-18s %s\n" "Hostname:" "$(hostname)"
    printf "%-18s %s\n" "Usuario:" "$USER"
    printf "%-18s %s\n" "Sistema:" "$(uname -s)"
    printf "%-18s %s\n" "Kernel:" "$(uname -r)"
    printf "%-18s %s\n" "Arquitectura:" "$(uname -m)"
    printf "%-18s %s\n" "Fecha/Hora:" "$(date +'%d/%m/%Y %H:%M:%S')"
    printf "%-18s %s\n" "Encendido:" "$(uptime -p)"
    echo ""
}

seccion_cpu () {
    echo "[CPU]"
    echo "$SEPARADOR_SEC"
    printf "%-18s %s\n" "Nucleos:" "$(nproc)"
    printf "%-18s %s\n" "Carga (1min):" "$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | tr -d ',')"
    echo ""
}

seccion_memoria () {
    echo "[ MEMORIA RAM ]"
    echo "$SEPARADOR_SEC"
    printf "%-18s %s\n" "RAM total:" "$(free -h | awk '/^Mem:/ {print $2}')"
    printf "%-18s %s\n" "RAM usada:" "$(free -h | awk '/^Mem:/ {print $3}')"
    printf "%-18s %s\n" "RAM libre:" "$(free -h | awk '/^Mem:/ {print $4}')"
    echo ""
}

seccion_disco () {
    echo "[ USO DE DISCO ]"
    echo "$SEPARADOR_SEC"
    df -h | grep -v "^tmpfs\|^udev\|^Filesystem" | awk '{printf "%-20s %6s %6s %6s %5s\n", $6, $2, $3, $4, $5}'
    echo ""
}

seccion_procesos () {
    echo "[ PROCESOS ]"
    echo "$SEPARADOR_SEC"
    printf "%-20s %s\n" "Total en sistema:" "$(ps aux --no-headers | wc -l)"
    echo "Top 5 por CPU:"
    ps aux --sort=-%cpu --no-headers | head -5 | awk '{printf "%-8s %-5s %s\n", $2, $3, $11}'
    echo ""
}

seccion_red () {
    echo "[ RED ]"
    echo "$SEPARADOR_SEC"
    printf "%-18s %s\n" "IP Local:" "$(hostname -i | awk '{print $1}')"
    echo ""
}

echo "$SEPARADOR"
printf "REPORTE DEL SISTEMA | v%s\n" "$VERSION"
echo "$SEPARADOR"
echo ""

case "$MODO" in
    all)  seccion_general; seccion_cpu; seccion_memoria; seccion_disco; seccion_procesos; seccion_red ;;
    cpu)  seccion_cpu ;;
    mem)  seccion_memoria ;;
    disk) seccion_disco ;;
    proc) seccion_procesos ;;
    net)  seccion_red ;;
    *)    uso ;;
esac
