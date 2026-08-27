#!/bin/bash

clear

OPCIONES=("1" "2" "3" "4" "5" "6" "7")

MENU="Bienvenido al menu!\n1)Crear entorno.\n2)Crear proceso.\n3)Mostrar alumnos.\n4)Mostrar notas mas altas.\n5)Messi.\n6)Mostrar log.\n7)Salir."

# OPCION 1 --- TERMINADA
# OPCION 2 --- EN PROCESO
# OPCION 3 --- PENDIENTE
# OPCION 4 --- PENDIENTE
# OPCION 5 --- PENDIENTE
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
    cat > "$HOME/EPNro1/consolidar.sh" << EOF
#!/bin/bash

EOF

}

case $opcion in 

    1)
        if [ ! -d "$HOME/EPNro1" ]; then
            mkdir -p "$HOME/EPNro1/entrada" "$HOME/EPNro1/salida" "$HOME/EPNro1/procesado"
            generar_script
        else
            echo "Entorno ya creado."
        fi
        ;;
    2)
        if [ ! -d "$HOME/EPNro1" ]; then
            echo "Entorno no creado. Primero debe correr la opcion 1."
        else
            bash "$HOME/EPNro1/consolidar.sh"
        fi
        ;;
    3)
        if [ ! -d "$HOME/EPNro1" ]; then
            echo "Entorno no creado. Primero debe correr la opcion 1."
        else
            if [ ! -f "$HOME/EPNro1/salida/FILENAME.txt" ]; then
                echo "No hay registros todavia."
            else
                sort -k1 -n "$HOME/EPNro1/salida/FILENAME.txt"
            fi
        fi
        ;;
    4) 
        if [ ! -d "$HOME/EPNro1" ]; then
            echo "Entorno no creado. Primero debe correr la opcion 1."
        else
            if [ ! -f "$HOME/EPNro1/salida/FILENAME.txt" ]; then
                echo "No hay registros todavia."
            else
                sort -k5 -n -r "$HOME/EPNro1/salida/FILENAME.txt" | head -n 10 
            fi
        fi
        ;;
    7)
        echo "Gracias por usar el menu!";;

esac