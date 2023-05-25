%{
        import java.io.*;
%}

%token <sval> ROUND_OPEN_B;
%token <sval> ROUND_CLOSE_B;
%token <sval> SQUARE_OPEN_B;
%token <sval> SQUARE_CLOSE_B;
%token <sval> LOWER_CASE;
%token <sval> UPPER_CASE;
%token <sval> COLON;
%token <sval> REG_NUMBER;

%type <sval> free_text;

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
        | round_bra free_text { println($2); }
        | square_bra
        | square_bra free_text { println($2); }

block   
        : free_text 
        | expression
        | block expression

free_text
        : LOWER_CASE { println($1); }
        | REG_NUMBER
        | UPPER_CASE LOWER_CASE { upperCaseFreeTextValidate($1, $2); }
        | COLON LOWER_CASE { colonFreeTextValidate($1, $2); }
        | UPPER_CASE REG_NUMBER { upperCaseFreeTextValidate($1, $2); }
        | COLON REG_NUMBER { colonFreeTextValidate($1, $2); }

%%



static Yylex lexer;


// Helpers ========== //
void upperCaseFreeTextValidate(String s1, String s2) {

        if (s1.charAt(0) == s1.charAt(1)) {
                println(s2);
        } else {
                println("Err: " + s2);
        }
}

void colonFreeTextValidate(String s1, String s2) {

        if (s1.length() % 2 == 0) {
                println(s2);
        } else {
                println(s1 + s2);
        }
}


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


// Main ========== //
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
