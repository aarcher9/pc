%{
        import java.io.*;
%}

%token <sval> ROUND_OPEN_B;
%token <sval> ROUND_CLOSE_B;
%token <sval> SQUARE_OPEN_B;
%token <sval> SQUARE_CLOSE_B;
%token <sval> LOWER_CASE;

%start block

%%

round_bra  
        : ROUND_OPEN_B block ROUND_CLOSE_B
        | ROUND_OPEN_B ROUND_CLOSE_B

square_bra  
        : SQUARE_OPEN_B block SQUARE_CLOSE_B
        | SQUARE_OPEN_B SQUARE_CLOSE_B

expression
        : round_bra
        | round_bra LOWER_CASE { println($2); }
        | square_bra
        | square_bra LOWER_CASE { println($2); }

block   
        : LOWER_CASE { println($1); }
        | expression
        | block expression

%%



static Yylex lexer;

void println(String s) {
        System.out.println(s);
}

void yyerror(String s) {
        System.out.println("Error : " + s + "\n\t : " + yylval.sval);
}

int yylex() {
        try {
                return lexer.yylex();
        }
        catch (IOException e) {
                System.err.println("IOError :\n\t" + e);
                return -1;
        }
}


// ========== //
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
