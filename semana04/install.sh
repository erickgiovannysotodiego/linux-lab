#!/bin/bash
set -e

DOTFILES_DIR="$HOME/linux-lab/semana04/dotfiles"

echo "=== Instalando Dotfiles mediante Enlaces Simbólicos ==="

# Función para enlazar de forma segura
link_file() {
    local src="$1"
    local dest="$2"
    
    if [ -f "$dest" ] || [ -L "$dest" ]; then
        echo "Respaldando archivo existente: $dest -> $dest.bak"
        mv "$dest" "$dest.bak"
    fi
    
    echo "Creando symlink: $dest -> $src"
    ln -s "$src" "$dest"
}

link_file "$DOTFILES_DIR/bashrc" "$HOME/.bashrc"
link_file "$DOTFILES_DIR/bash_aliases" "$HOME/.bash_aliases"
link_file "$DOTFILES_DIR/vimrc" "$HOME/.vimrc"

echo "=== Instalación completada con éxito. Ejecuta 'source ~/.bashrc' ==="
