#!/bin/bash
set -euo pipefail

REPO="${1:-$HOME/linux-lab}"

if [[ ! -d "$REPO" ]]; then
    echo "Error: directorio '$REPO' no existe." >&2
    exit 1
fi

# 1. Cargar archivos
mapfile -t archivos < <(find "$REPO" -type f | sort)

# 2. Conteo por extensión
declare -A conteo
declare -A tamano_ext
for f in "${archivos[@]}"; do
    nombre="${f##*/}"
    ext="${nombre##*.}"
    [[ "$nombre" == *.* ]] || ext="(sin extension)"
    conteo["$ext"]=$(( ${conteo["$ext"]:-0} + 1 ))
    bytes=$(stat -c %s "$f" 2>/dev/null || echo 0)
    tamano_ext["$ext"]=$(( ${tamano_ext["$ext"]:-0} + bytes ))
done

# 3. Estado de README y Matriz
declare -A tiene_readme
mapfile -t semanas < <(ls -d "$REPO"/semana*/ 2>/dev/null | sort)
COLS=3
declare -a matriz_sem

for (( i=0; i<${#semanas[@]}; i++ )); do
    dir="${semanas[$i]}"
    nombre=$(basename "$dir")
    [[ -f "$dir/README.md" ]] && tiene_readme["$nombre"]="si" || tiene_readme["$nombre"]="NO"
    
    scripts=$(find "$dir" -name "*.sh" | wc -l)
    docs=$(find "$dir" -name "*.md" | wc -l)
    kb=$(du -sk "$dir" 2>/dev/null | awk '{print $1}')
    matriz_sem[$(( i * COLS + 0 ))]=$scripts
    matriz_sem[$(( i * COLS + 1 ))]=$docs
    matriz_sem[$(( i * COLS + 2 ))]=${kb:-0}
done

# 4. Mostrar resultados
echo "=== ARCHIVOS POR EXTENSION ==="
{ echo "EXTENSION ARCHIVOS TAMANO_KB"; for ext in "${!conteo[@]}"; do echo "$ext ${conteo[$ext]} $(( ${tamano_ext[$ext]:-0} / 1024 ))"; done; } | column -t

echo -e "\n=== RESUMEN POR SEMANA ==="
printf "%-12s %-4s %-4s %-10s %-8s\n" "SEMANA" "SH" "MD" "SIZE_KB" "README"
for (( i=0; i<${#semanas[@]}; i++ )); do
    nombre=$(basename "${semanas[$i]}")
    printf "%-12s %-4s %-4s %-10s %-8s\n" "$nombre" "${matriz_sem[$((i*COLS+0))]}" "${matriz_sem[$((i*COLS+1))]}" "${matriz_sem[$((i*COLS+2))]}" "${tiene_readme[$nombre]}"
done
