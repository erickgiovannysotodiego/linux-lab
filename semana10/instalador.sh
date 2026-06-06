#!/bin/bash
# instalador.sh - Script de gestión de paquetes (Semana 10)

PAQUETE="htop"

echo "--- Verificando estado del paquete: $PAQUETE ---"

# 1. Comprobar si ya está instalado usando dpkg
if dpkg -l | grep -q "^ii  $PAQUETE "; then
    echo "El paquete $PAQUETE ya se encuentra instalado. Saltando paso."
else
    echo "El paquete $PAQUETE no está instalado. Iniciando configuración..."
    
    # 2. Actualizar repositorios e instalar
    sudo apt update -y
    sudo apt install -y "$PAQUETE"
    
    # 3. Comprobar si la instalación tuvo éxito
    if [ $? -eq 0 ]; then
        echo "¡Instalación de $PAQUETE exitosa!"
    else
        echo "Error: Falló la instalación de $PAQUETE."
        exit 1
    fi
fi

# 4. Verificación final de disponibilidad
if command -v "$PAQUETE" >/dev/null 2>&1; then
    echo "Verificación: $PAQUETE está listo para ser ejecutado."
else
    echo "Error: El comando no se encuentra en el PATH."
fi
