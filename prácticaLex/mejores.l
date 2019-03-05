/*--------------------------Sección de declaraciones--------------------------*/

%{
#include <stdio.h>

char filas[10000];
int n_filas, n_datos= 1;

%}

letra               [a-zA-Z]
numero              [0-9]
num_dos_digitos     {numero}{numero}
entero              {numero}+
espacio             [ ]
unidad              ("metros"|"m"|"kilometros"|"km")
distancia           ^{entero}{espacio}{unidad}{espacio}
fecha               {num_dos_digitos}.{num_dos_digitos}.{num_dos_digitos}{num_dos_digitos}$
lugar               {letra}+
nombre              {letra}+
apellido            {letra}+
codigo              ({letra}|{numero})+
tiempo              {numero}+\.{numero}+
fila                {tiempo}{espacio}{nombre}{espacio}{apellido}{espacio}{entero}{espacio}{codigo}{espacio}{lugar}{espacio}{fecha}{espacio}

%%


{distancia}   {
                sprintf(filas, "Distancia: %s\n", yytext);
                n_filas=1;
              }
{fila}        {
                if(n_filas >= 1 && n_filas <= 3){
                  sprintf(filas, "%dº mejor: %s\n", n_filas, yytext);
                  n_filas++;
                }
              }

%%

/*-------------------------Sección de procedimientos--------------------------*/

int main(int argc, char *argv[]){
  if (argc == 2 ){
    yyin= fopen(argv[1], "rt");

    if(yyin == NULL){
      printf("El fichero %s no se puede abrir\n", argv[1]);
      exit(-1);
    }
  }
  else{
    printf("Ha de especificar fichero de entrada.\n");
    exit(-1);
  }

  yylex();

  //------Escribimos la lista de los atletas escogidos

    FILE *f = fopen("mejores.txt", "w");
    if (f == NULL) {
        printf("Error al abrir el archivo\n");
        exit(1);
    }

    fprintf(f, "Atletas con los tres mejores tiempos de su categoría del archivo: %s\n", argv[1]);
    fprintf(f, filas);

    fclose(f);

  return 0;
}
