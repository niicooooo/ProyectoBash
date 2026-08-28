#!/bin/bash

clear

OPCIONES=("1" "2" "3" "4" "5" "6" "7")

MENU="Bienvenido al menu!\n1)Crear entorno.\n2)Crear proceso.\n3)Mostrar alumnos.\n4)Mostrar notas mas altas.\n5)Messi.\n6)Mostrar log.\n7)Salir."

BASE="$HOME/EPNro1"
ENTRADA="$BASE/entrada"
SALIDA="$BASE/salida"
PROCESADO="$BASE/procesado"
FILENAME="$SALIDA/FILENAME.txt"
CONSOLIDAR="$BASE/consolidar.sh"

# OPCION 1 --- TERMINADA
# OPCION 2 --- EN PROCESO
# OPCION 3 --- TERMINADA
# OPCION 4 --- TERMINADA
# OPCION 5 --- TERMINADA
# OPCION 6 --- PENDIENTE
# OPCION 7 --- TERMINADA

# PASO 1 - MENU (validar ingreso de opcion correcta) ---- Listo
# PASO 2 - 

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
    cat > "$CONSOLIDAR" << EOF
#!/bin/bash

EOF

}

case $opcion in 

    1)
        if [ ! -d "$BASE" ]; then
            mkdir -p "$ENTRADA" "$SALIDA" "$PROCESADO"
            generar_script
        else
            echo "Entorno ya creado."
        fi
        ;;
    2)
        if [ ! -d "$BASE" ]; then
            echo "Entorno no creado. Primero debe correr la opcion 1."
        else
            bash "$CONSOLIDAR"
        fi
        ;;
    3)
        if [ ! -d "$BASE" ]; then
            echo "Entorno no creado. Primero debe correr la opcion 1."
        else
            if [ ! -f "$FILENAME" ]; then
                echo "No hay registros todavia."
            else
                sort -k1 -n "$FILENAME"
            fi
        fi
        ;;
    4) 
        if [ ! -d "$BASE" ]; then
            echo "Entorno no creado. Primero debe correr la opcion 1."
        else
            if [ ! -f "$FILENAME" ]; then
                echo "No hay registros todavia."
            else
                sort -k5 -n -r "$FILENAME" | head -n 10 
            fi
        fi
        ;;
    5)
        echo -n "Ingrese el NRO de padron: "

        read nro_padron

        resultado=$(awk -v padron=$nro_padron '$1 == padron' "$FILENAME")

        if [ ! -z $resultado ]; then
            echo $resultado
        else
            echo "No se encontraron registros."
        fi
        ;;
    7)
        echo "Gracias por usar el menu!";;

esac