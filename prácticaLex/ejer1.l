          /*----------Sección de declaraciones----------*/

%{
  #include <stdio.h>

  int emails, webs, fechas, telefonos, matriculas, codpostales, nifs;
  void escribir_datos (int datos);
%}

letra       [a-zA-Z]
numero      [0-9]
barras      [\-_]

%%

          /*----------Sección de reglas----------*/
({letra}|{numero}|{barras})+@{letra}+\.{letra}+      {emails++;}
www\.({letra}|{numero}|{barras})+\.{letra}+          {webs++;}
%%

          /*----------Sección de procedimientos----------*/

int main(int argc, char *argv[]){
  if (argc == 2 ){
    yyin= fopen(argv[1], "rt");
    if(yyin == NULL){
      printf("El fichero %s no se puede abrir\n", argv[1]);
      exit(-1);
    }
  }
  else yyin = stdin;

  emails= 0;
  yylex();
  escribir_datos(emails);

  return 0;
}

void escribir_datos(int emails){
  printf ("Emails: %d\n", emails);
}
