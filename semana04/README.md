# Semana 04: Editores de Texto y Dotfiles

## Descripción
Este módulo contiene la automatización y personalización del entorno CLI (`bashrc`, `bash_aliases` y `vimrc`) utilizando enlaces simbólicos gestionados con Bash.

## Archivos del Repositorio
* `dotfiles/` - Contiene las configuraciones reales resguardadas.
* `install.sh` - Instala las configuraciones generando enlaces simbólicos en `$HOME`.
* `uninstall.sh` - Remueve los enlaces y restaura las configuraciones previas del sistema.

## Características Agregadas
* Prompt con colores dinámicos (PS1).
* Comando `clima` integrado para consultar el estado meteorológico de Oruro mediante `curl`.
* Vim optimizado para programación con numeración y autoidentación.
