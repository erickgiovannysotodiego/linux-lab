# Comandos Usados y Explicación de Pipelines - Semana 03

1. `wc -l < sample.log`: Cuenta de manera directa la cantidad total de registros en el archivo.
2. `grep -c " | SEV | "`: Filtra y cuenta de forma optimizada las líneas según la severidad indicada.
3. `grep -E "ERROR|FATAL" | awk -F ' | ' '{print $2}' | sort | uniq -c | sort -nr | head -n 3`:
   * `grep -E`: Filtra eventos críticos usando expresiones regulares.
   * `awk`: Extrae la columna de IPs utilizando la barra como delimitador.
   * `sort | uniq -c`: Ordena los resultados para contar cuántas veces se repite cada IP única.
   * `sort -nr`: Reordena de forma numérica y en orden descendente (de mayor a menor).
   * `head -n 3`: Extrae el podio con los 3 primeros resultados.
