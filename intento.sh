#!/bin/bash

clear

OPTIONS=("1" "2" "3" "4" "5" "6" "7" "-d")

MENU="Bienvenido al menu! \n1)Crear entorno.\n2)Crear proceso.\n3)Mostrar alumnos.\n4)Mostrar notas mas altas.\n5)Messi.\n6)Mostrar log.\n7)Salir."

# PASO 1 - MENU (validar ingreso de opcion correcta) ---- Listo
# PASO 2 - 

while [ "$valid" != "true" ]
do

    echo -e $MENU
    echo -n "Ingrese su opcion: "

    read option

    valid=false

    for elemento in "${OPTIONS[@]}"
    do

        if [ "$elemento" == "$option" ]; then
            valid=true
        fi

    done

    if [ "$valid" != "true" ]; then
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

echo $HOME

case $option in 

    1)
        if [ ! -d "$HOME/EPNro1" ]; then
            mkdir -p "$HOME/EPNro1/entrada" "$HOME/EPNro1/salida" "$HOME/EPNro1/procesado"
            generar_script
        else
            echo "Ya estan creadas las carpetas."
        fi
        ;;
    2)
        if [ ! -d "$HOME/EPNro1" ]; then
            echo "Entorno no creado. Primero debe correr la opcion 1."
        else
            bash "$HOME/EPNro1/consolidar.sh"
        fi
        ;;
    7)
        echo "Gracias por usar el menu!";;

esac