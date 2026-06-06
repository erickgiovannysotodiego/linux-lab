# Semana 08: Comandos y Tecnicas Usadas

## mapfile
`mapfile -t archivos < <(find "$REPO" -type f | sort)`
Carga cada línea de la salida de `find` en un array, eliminando el salto de línea con `-t`[cite: 480].

## Arrays asociativos
`declare -A conteo`
`conteo["$ext"]=$(( ${conteo["$ext"]:-0} + 1 ))`
Permite acumular conteos usando claves de texto (extensiones)[cite: 482].

## Matriz con array indexado
`matriz_sem[$((i * COLS + col))]="$valor"`
Simula una tabla 2D en un array lineal calculando el índice[cite: 484].

## column
`comando | column -t`
Alinea automáticamente columnas para presentar datos tabulares[cite: 486].
