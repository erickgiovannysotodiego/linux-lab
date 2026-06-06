#!/bin/bash
echo "=== Desinstalando Dotfiles y restaurando respaldos ==="

unlink_file() {
    local file="$1"
    if [ -L "$file" ]; then
        echo "Removiendo symlink: $file"
        rm "$file"
        if [ -f "$file.bak" ]; then
            echo "Restaurando respaldo: $file.bak -> $file"
            mv "$file.bak" "$file"
        fi
    fi
}

unlink_file "$HOME/.bashrc"
unlink_file "$HOME/.bash_aliases"
unlink_file "$HOME/.vimrc"

echo "=== Desinstalación completada ==="
