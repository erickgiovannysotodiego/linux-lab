#!/bin/bash
set -e

LOG_FILE="sample.log"
REPORT="analysis-report.txt"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: No existe el archivo $LOG_FILE. Corre primero el generador."
    exit 1
fi

echo "=== INICIANDO ANALISIS DE LOGS ==="
echo "Reporte de Analisis de Servidor" > "$REPORT"
echo "Generado el: $(date)" >> "$REPORT"
echo "-----------------------------------" >> "$REPORT"

# 1. Contar total de líneas
TOTAL_LINES=$(wc -l < "$LOG_FILE")
echo "Total de eventos analizados: $TOTAL_LINES" >> "$REPORT"

# 2. Contar por nivel de severidad
echo "" >> "$REPORT"
echo "=== RESUMEN POR SEVERIDAD ===" >> "$REPORT"
for SEV in "INFO" "WARNING" "ERROR" "FATAL"; do
    COUNT=$(grep -c " | $SEV | " "$LOG_FILE" || echo 0)
    echo "$SEV: $COUNT" >> "$REPORT"
done

# 3. Identificar las Top 3 IPs con más errores/fatales
echo "" >> "$REPORT"
echo "=== TOP 3 IPS CON MAS ERRORES ===" >> "$REPORT"
grep -E "ERROR|FATAL" "$LOG_FILE" | awk -F ' | ' '{print $2}' | sort | uniq -c | sort -nr | head -n 3 >> "$REPORT"

# 4. Los mensajes de error más comunes
echo "" >> "$REPORT"
echo "=== MENSAJES DE ERROR MAS FRECUENTES ===" >> "$REPORT"
grep -E "ERROR|FATAL" "$LOG_FILE" | awk -F ' | ' '{print $4}' | sort | uniq -c | sort -nr | head -n 3 >> "$REPORT"

echo "Analisis completado con exito. Resultados guardados en: $REPORT"
echo ""
cat "$REPORT"
