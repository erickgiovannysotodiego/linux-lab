#!/bin/bash

set -e # Salir si hay un error

echo "=== Organizador de Archivos ==="
echo ""

# Crear estructura de directorios
echo "[1/4] Creando directorios..."
mkdir -p organized/{documents,images,scripts,config,logs,temp}
echo "Directorios creados"
