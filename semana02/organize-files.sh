#!/bin/bash

set -e # Salir si hay un error

echo "=== Organizador de Archivos ==="
echo ""

# Crear estructura de directorios
echo "[1/4] Creando directorios..."
mkdir -p organized/{documents,images,scripts,config,logs,temp}
echo "Directorios creados"
# Organizar documentos
echo "[2/4] Organizando documentos..."
mv *.txt organized/documents/ 2>/dev/null || true
mv *.md organized/documents/ 2>/dev/null || true
mv *.doc organized/documents/ 2>/dev/null || true
echo "Documentos organizados"

# Organizar imagenes
echo "[3/4] Organizando imagenes..."
mv *.jpg organized/images/ 2>/dev/null || true
mv *.png organized/images/ 2>/dev/null || true
mv *.gif organized/images/ 2>/dev/null || true
echo "Imagenes organizadas"

# Organizar scripts
echo "Organizando scripts..."
mv *.sh organized/scripts/ 2>/dev/null || true
mv *.py organized/scripts/ 2>/dev/null || true

# Organizar configuraciones
echo "Organizando configuraciones..."
mv *.conf organized/config/ 2>/dev/null || true
mv *.json organized/config/ 2>/dev/null || true
mv *.xml organized/config/ 2>/dev/null || true

# Organizar logs
echo "Organizando logs..."
mv *.log organized/logs/ 2>/dev/null || true
# Aplicar permisos
echo "[4/4] Aplicando permisos..."

# Directorios: 755 (rwxr-xr-x)
chmod 755 organized/
chmod 755 organized/*/

# Documentos: 644 (rw-r--r--)
find organized/documents/ -type f -exec chmod 644 {} \;

# Imagenes: 644 (rw-r--r--)
find organized/images/ -type f -exec chmod 644 {} \;

# Scripts: 755 (rwxr-xr-x) - ejecutables
find organized/scripts/ -type f -exec chmod 755 {} \;

# Configuraciones: 644 (rw-r--r--)
find organized/config/ -type f -exec chmod 644 {} \;

# Logs: 644 (rw-r--r--)
find organized/logs/ -type f -exec chmod 644 {} \;

echo ""
echo "Permisos aplicados correctamente"
echo "=== Organizacion completada ==="
echo "Ver estructura: tree organized/"
echo "Ver permisos: ls -lR organized/"
