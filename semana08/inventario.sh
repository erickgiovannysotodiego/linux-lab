#!/bin/bash
# inventario.sh - Uso de arrays para listar archivos

echo "Cargando archivos del directorio actual en un array..."

# Cargamos el resultado de 'ls' en el array llamado 'archivos'
mapfile -t archivos < <(ls -1)

# ${#archivos[@]} nos da el total de elementos en el array
echo "Total de archivos encontrados: ${#archivos[@]}"

# Ciclo 'for' para recorrer el array
echo "Listando archivos:"
for i in "${!archivos[@]}"; do
    echo "Archivo $i: ${archivos[$i]}"
done
