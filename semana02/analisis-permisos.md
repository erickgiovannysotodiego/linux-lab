# Analisis de Permisos Aplicados
## Resumen de Permisos
| Tipo | Permisos | Octal | Justificacion |
|------|----------|-------|---------------|
| Documentos | rw-r--r-- | 644 | Solo el dueno modifica, otros leen |
| Imagenes | rw-r--r--| 644 | Archivos de solo lectura para otros |
| Scripts | rwxr-xr-x | 755 | Deben ser ejecutables |
| Config | rw-r--r--| 644 | Configuraciones protegidas |
| Logs | rw-r--r-- | 644 | Solo sistema/owner escribe |
| Directorios | rwxr-xr-x | 755 | Acceso de lectura para todos |

## Decisiones Tecnicas
### Por que 755 para scripts?
Los scripts necesitan el permiso de ejecucion (x) para poder ejecutarse directamente con './script.sh'.
Owner: rwx (7) - puede leer, modificar y ejecutar
Group: r-x (5) - puede leer y ejecutar, no modificar
Others: r-x (5) - puede leer y ejecutar, no modificar

### Por que 755 para directorios?
Los directorios necesitan el bit de ejecucion (x) para permitir 'cd' al directorio, listar contenido con 'ls' y acceder a archivos dentro.
