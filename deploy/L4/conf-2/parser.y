%{
        import java.io.*;
%}

%token <sval> WORD
%token <sval> DIGITS
%token <sval> MIXED
%token <sval> COLON
%token <sval> COMMA
%token <sval> OPEN_CURLY_BRA
%token <sval> CLOSE_CURLY_BRA

%type <sval> s
%type <sval> group
%type <sval> groups
%type <sval> members
%type <sval> property

%start s

%%

s
        : { $$ = ""; } // matches empty file
        | groups { println($$); }

groups
        : group { $$ = $1 + "\n"; }
        | groups groups { $$ = $1 + $2; }

group
        : WORD COLON OPEN_CURLY_BRA members CLOSE_CURLY_BRA {
                $$ = "[" + $1 + "]\n" + $4;
        }
        | WORD COLON OPEN_CURLY_BRA CLOSE_CURLY_BRA {
                $$ = "[" + $1 + "]\n";
        }

members
        : property
        // ensures that if there is no COMMA in a property line, that line should be the last on the only on (like in JSON)
        | members COMMA members { $$ = $1 + $3; }
        | members COMMA members COMMA { $$ = $1 + $3; }

property
        : MIXED COLON MIXED {

                if ($3.equals("PROPRIO NOME E COGNOME")) {
                        $3 = "Lorenzo";
                }
                $$ = $1 + " = " + $3 + "\n";
        }
        | MIXED COLON DIGITS {

                if ($3.equals("0")) {
                        $3 = "826296";
                }

                $$ = $1 + " = " + $3 + "\n";
        }
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

        System.out.println("Parsing...\n");
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