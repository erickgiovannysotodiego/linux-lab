# Ejemplos Prácticos de Navegación y Diagnóstico

## Exploración Básica
```bash
pwd              # Muestra la ubicación actual
cd /             # Cambia al directorio raíz
ls -l            # Listado en formato largo con permisos
tree -L 2 -d     # Árbol jerárquico de directorios
cd ~             # Regresa al HOMEuname -a         # Detalles del kernel
cat /etc/os-release  # Nombre de la distribución
free -h          # Monitoreo de memoria RAM
lsblk            # Muestra los bloques de discos
df -h            # Espacio en disco disponible} 
find /etc -name "hosts" 2>/dev/null
find /etc -name "*.conf" -type f 2>/dev/null | head
find ~ -type f -size +10M 2>/dev/null

