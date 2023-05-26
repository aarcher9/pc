%{
        import java.io.*;
%}

%token <sval> PLAIN_WORD
%token <sval> ALLOWED_SPECIAL
%token <sval> COLON
%token <sval> SEMI_COLON
%token <sval> OPEN_CURLY_BRA
%token <sval> CLOSE_CURLY_BRA

%type <sval> group

%start s

%%

s
        : // matches empty file
        | groups

groups
        : group
        | groups groups

group
        : PLAIN_WORD COLON OPEN_CURLY_BRA members CLOSE_CURLY_BRA SEMI_COLON

members
        : property
        | members members
        | groups

property
        : PLAIN_WORD COLON PLAIN_WORD // (1)
        | PLAIN_WORD COLON ALLOWED_SPECIAL // (2)
        | PLAIN_WORD COLON value

// incorporating (1) and (2) here will not work
value
        : value ALLOWED_SPECIAL
        | value PLAIN_WORD
        /* | ALLOWED_SPECIAL
        | PLAIN_WORD */


%%



static Yylex lexer;



void println(String s) {
        System.out.println(s);
}

void yyerror(String s) {
        System.out.println("Error : " + s + "\n\t -> " + yylval.sval);
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



public static void main(String args[]) {

        System.out.println("[Quit with CTRL-D]");
        Parser par = new Parser();

        try {
                lexer = new Yylex(new FileReader("input.txt"), par);
                par.yyparse();
                System.exit(0);

        } catch (IOException e) {

                System.exit(0);
        }
}