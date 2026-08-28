#!/bin/bash

clear

OPCIONES=("1" "2" "3" "4" "5" "6" "7")

MENU="Bienvenido al menu!\n1)Crear entorno.\n2)Crear proceso.\n3)Mostrar alumnos.\n4)Mostrar notas mas altas.\n5)Buscar alumno por padron.\n6)Mostrar log.\n7)Salir."

BASE="$HOME/EPNro1"
ENTRADA="$BASE/entrada"
SALIDA="$BASE/salida"
PROCESADO="$BASE/procesado"
CONSOLIDAR="$BASE/consolidar.sh"
PIDFILE="$BASE/.consolidar.pid"
LOGFILE="$BASE/procesado.log"

# OPCION 1 --- TERMINADA
# OPCION 2 --- TERMINADA
# OPCION 3 --- TERMINADA
# OPCION 4 --- TERMINADA
# OPCION 5 --- TERMINADA
# OPCION 6 --- TERMINADA
# OPCION 7 --- TERMINADA

# PASO 1 - MENU (validar ingreso de opcion correcta) ---- Listo
# PASO 2 - proceso en background + log + parametro -d ---- Listo

# Parametro opcional -d: borra el entorno y mata el proceso en background
if [ "$1" == "-d" ]; then
    if [ -f "$PIDFILE" ]; then
        PID=$(cat "$PIDFILE")
        if kill -0 "$PID" 2>/dev/null; then
            kill "$PID"
            echo "Proceso en background (PID $PID) finalizado."
        fi
        rm -f "$PIDFILE"
    fi
    pkill -f "$CONSOLIDAR" 2>/dev/null
    if [ -d "$BASE" ]; then
        rm -rf "$BASE"
        echo "Entorno $BASE eliminado."
    else
        echo "No existe el entorno a eliminar."
    fi
    exit 0
fi

if [ -z "$FILENAME" ]; then
echo "falta definir la variable ambiente, para arreglarlo usar : export FILENAME=nombre_elegido"
exit 1
fi

SALIDA_FILE="$SALIDA/$FILENAME.txt"

while [ "$valido" != "true" ]
do

echo -e $MENU
echo -n "Ingrese su opcion: "

read opcion

valido=false

for elemento in "${OPCIONES[@]}"
do

if [ "$elemento" == "$opcion" ]; then
valido=true
fi

done

if [ "$valido" != "true" ]; then
clear
echo "Ingreso una opcion invalida."
read -p "Presione ENTER para volver al menu..."
clear
fi

done

generar_script() {
    cat > "$CONSOLIDAR" << 'EOF'
#!/bin/bash

BASE="$1"
FILENAME="$2"
ENTRADA="$BASE/entrada"
SALIDA="$BASE/salida"
PROCESADO="$BASE/procesado"
SALIDA_FILE="$SALIDA/$FILENAME.txt"
LOGFILE="$BASE/procesado.log"

shopt -s nullglob

while true; do
       archivos=("$ENTRADA"/*.txt)
       for archivo in "${archivos[@]}"; do
            cat "$archivo" >> "$SALIDA_FILE"
            mv "$archivo" "$PROCESADO"
            fecha=$(date '+%d/%m/%Y %H:%M:%S')
            nombre=$(basename "$archivo")
            echo "$fecha - Procesado archivo $nombre" >> "$LOGFILE"
done
    sleep 2
done

EOF
    chmod +x "$CONSOLIDAR"
}

case $opcion in 

1)
if [ ! -d "$BASE" ]; then
mkdir -p "$ENTRADA" "$SALIDA" "$PROCESADO"
generar_script
echo "Entorno creado en $BASE."
else
echo "Entorno ya creado."
fi
        ;;
2)
if [ ! -d "$BASE" ]; then
echo "Entorno no creado. Primero debe correr la opcion 1."
elif [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
echo "El proceso ya esta corriendo (PID $(cat "$PIDFILE"))."
else
nohup bash "$CONSOLIDAR" "$BASE" "$FILENAME" > "$BASE/consolidar.out" 2>&1 &
echo $! > "$PIDFILE"
echo "Proceso consolidar.sh corriendo en background (PID $!)."
fi
        ;;
3)
if [ ! -d "$BASE" ]; then
echo "Entorno no creado. Primero debe correr la opcion 1."
else
if [ ! -f "$SALIDA_FILE" ]; then
echo "No hay registros todavia."
else
sort -k1 -n "$SALIDA_FILE"
fi
fi
        ;;
4) 
if [ ! -d "$BASE" ]; then
echo "Entorno no creado. Primero debe correr la opcion 1."
else
if [ ! -f "$SALIDA_FILE" ]; then
echo "No hay registros todavia."
else
sort -k5 -n -r "$SALIDA_FILE" | head -n 10 
fi
fi
        ;;
5)
echo -n "Ingrese el NRO de padron: "

read nro_padron

resultado=$(awk -v padron="$nro_padron" '$1 == padron' "$SALIDA_FILE")

if [ ! -z "$resultado" ]; then
echo "$resultado"
else
echo "No se encontraron registros."
fi
        ;;
6)
if [ ! -f "$LOGFILE" ]; then
echo "No existe el log todavia."
else
cat "$LOGFILE"
fi
        ;;
7)
echo "Gracias por usar el menu!";;

esac