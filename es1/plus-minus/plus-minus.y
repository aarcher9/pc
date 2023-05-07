%{
   #include <ctype.h>
   #include <stdio.h>
   #define YYSTYPE double /* double type for yacc stack */
%}
 
%%
 /* Lines :  Lines S '\n' { printf("OK \n"); }
       |  S '\n'
       |  error '\n' {yyerror("Error: reenter last line:");
                        yyerrok; }; */
S: 'a' { printf("OK"); }


%%
int ind = 0;
char* in = "a";

int yylex() {

    if (ind < 1) {

        return (int) in[ind];

    } else return 0;
}

void yyerror(char* s)
/* yacc error handler */
{  
 fprintf (stderr, "%s\n", s);
}
  
int main(void)
 {
 return yyparse();
 } 