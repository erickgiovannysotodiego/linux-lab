#!/bin/bash
# sysinfo.sh - Reporte del estado del sistema
# Uso: ./sysinfo.sh [--all | --cpu | --mem | --disk | --proc | --net]

readonly VERSION="1.0.0"
readonly SEPARADOR="==========================================="
readonly SEPARADOR_SEC="-------------------------------------------"

uso () {
    echo "Uso: $0 [opcion]"
    echo ""
    echo "Opciones:"
    echo "  --all       Reporte completo (explícito)"
    echo "  --cpu       Solo CPU"
    echo "  --mem       Solo memoria"
    echo "  --disk      Solo disco"
    echo "  --proc      Solo procesos"
    echo "  --net       Solo red (Desafío)"
    echo "  --version   Versión del script"
    echo "  --help, -h  Esta ayuda"
    exit 2
}[cite: 2]

MODO="${1:-all}"[cite: 2]

case "$MODO" in[cite: 2]
    --all|"all") MODO="all" ;;[cite: 2]
    --cpu)       MODO="cpu" ;;[cite: 2]
    --mem)       MODO="mem" ;;[cite: 2]
    --disk)      MODO="disk" ;;[cite: 2]
    --proc)      MODO="proc" ;;[cite: 2]
    --net)       MODO="net" ;;
    --version)   echo "sysinfo.sh versión $VERSION"; exit 0 ;;[cite: 2]
    --help|-h)   uso ;;[cite: 2]
    *)           echo "Error: opción desconocida '$MODO'"; uso ;;[cite: 2]
esac[cite: 2]

echo "$SEPARADOR"[cite: 2]
printf "REPORTE DEL SISTEMA | sysinfo.sh v%s\n" "$VERSION"[cite: 2]
echo "$SEPARADOR"[cite: 2]
echo ""[cite: 2]
