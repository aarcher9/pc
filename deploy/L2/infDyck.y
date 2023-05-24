%{
        import java.io.*;
%}

%token OPEN_PAREN;
%token CLOSE_PAREN;
%token <sval> LOWER_CASE;
/* %type <sval> s;
%type <sval> exps;
%type <sval> parens; */

%start s

%%

parens  : OPEN_PAREN s CLOSE_PAREN
        | OPEN_PAREN CLOSE_PAREN

exps    : parens LOWER_CASE { System.out.println("A: " + $2); }
        /* | LOWER_CASE parens { System.out.println("B: " + $1); } */
        | parens

s       : LOWER_CASE { System.out.println("Text: " + $1); }
        | exps
        | s exps

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
