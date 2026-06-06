#!/bin/bash
# limpieza.sh - Borra archivos viejos de /tmp

DIR="/tmp"

# Busca archivos terminados en .log que tengan más de 7 días
for archivo in $(find "$DIR" -name "*.log" -mtime +7); do
    echo "Borrando: $archivo"
    rm -f "$archivo"
done

echo "Limpieza lista."
