#!/bin/bash

echo "Compilando archivo lex..."
flex mejores.l

echo "Compilando archivo en C..."
gcc lex.yy.c -o prog -lfl && echo "Ejecutando archivo..." && ./prog ranking.txt
