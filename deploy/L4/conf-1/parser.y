%{
        import java.io.*;
%}

%token <sval> PLAIN_WORD
%token <sval> SPACED_WORD
%token <sval> SPECIAL_WORD
%token <sval> COLON
%token <sval> SEMI_COLON
%token <sval> OPEN_CURLY_BRA
%token <sval> CLOSE_CURLY_BRA

%type <sval> s
%type <sval> group
%type <sval> groups
%type <sval> members
%type <sval> property
%type <sval> value

%start s

%%

s
        : { $$ = ""; } // matches empty file
        | groups { println($$); }

groups
        : group { $$ = $1 + "\n"; }
        | groups groups { $$ = $1 + $2; }

group
        : PLAIN_WORD COLON OPEN_CURLY_BRA members CLOSE_CURLY_BRA SEMI_COLON {
                $$ = "[" + $1 + "]\n" + $4;
        }
        | PLAIN_WORD COLON OPEN_CURLY_BRA CLOSE_CURLY_BRA SEMI_COLON {
                $$ = "[" + $1 + "]\n";
        }

members
        : property
        | members members { $$ = $1 + $2; }

property
        : PLAIN_WORD COLON value {
                $$ = $1 + "=" + $3 + "\n";
        }
        | SPACED_WORD COLON value {
                $$ = $1 + "=" + $3 + "\n";
        }

value
        : PLAIN_WORD
        | SPECIAL_WORD

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

        Parser par = new Parser();

        try {
                lexer = new Yylex(new FileReader("input.txt"), par);
                par.yyparse();
                System.exit(0);

        } catch (IOException e) {
                
                e.printStackTrace();
                System.exit(0);
        }
}