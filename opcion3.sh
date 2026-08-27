#!/bin/bash

if [ ! -f "$HOME/EPNro1/salida/FILENAME.txt" ]; then
    echo "Manteca"
else
    sort -k1 -n "$HOME/EPNro1/salida/FILENAME.txt"
fi