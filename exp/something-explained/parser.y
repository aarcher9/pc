%{
        import java.io.*;
%}

%token <sval> OPEN_PAREN;
%token <sval> CLOSE_PAREN;
%token <sval> LOWER_CASE;
%type <sval> s;
%type <sval> exps;
%type <sval> parens;

%start s

%%

parens  : OPEN_PAREN s CLOSE_PAREN {
                // $$ = $1 + $2 + $3;
                System.out.println($$ + " = parens <- OPEN_PAREN s CLOSE_PAREN"); }
        | OPEN_PAREN CLOSE_PAREN {
                // $$ = $1 + $2;
                System.out.println($$ + " = parens <- OPEN_PAREN CLOSE_PAREN"); }

exps    : parens LOWER_CASE {
                // $$ = $1 + $2;
                System.out.println($1 + " = exps <- parens LOWER_CASE"); }
        /* | LOWER_CASE parens {
                // $$ = $1 + $2;
                System.out.println($2 + " = exps <- LOWER_CASE parens"); } */
        | parens {    
                // $$ = $1;
                System.out.println($$ + " = exps <- parens"); }

s       : LOWER_CASE {     
                // $$ = $1;
                System.out.println($$ + " = s <- LOWER_CASE"); }
        | exps {     
                // $$ = $1;
                System.out.println($$ + " = s <- exps"); }
        | s exps {
                // $$ = $1 + $2;     
                System.out.println($$ + " = s <- s exps"); }
        // This makes acceptable line feeds between lower cases
        /* | s LOWER_CASE
                { 
                        // Values are already typed, no need to obtain value with .sval, .ival,...
                        // $$ = $1 + $2;
                        System.out.println("txt: "+ $2); 
                } */

%%

static Yylex lexer;

void yyerror(String s) {
        System.out.println("err:" + s);
        System.out.println("   :" + yylval.sval);
}

int yylex() {
        try {
                return lexer.yylex();
        }
        catch (IOException e) {
                System.err.println("IO error :" + e);
                return -1;
        }
}

public static void main(String args[]) {

        System.out.println("[Quit with CTRL-D]");
        Parser par = new Parser();

        try {
                lexer = new Yylex(new FileReader("input.txt"), par);
                par.yyparse();
                System.exit(0);

        } catch (IOException e) {} 

        lexer = new Yylex(new InputStreamReader(System.in), par);
        par.yyparse();

}
