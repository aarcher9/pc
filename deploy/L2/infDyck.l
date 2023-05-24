
%%

%byaccj

%{
        /* store a reference to the parser object */
        private Parser yyparser;

        /* constructor taking an additional parser object */
        public Yylex(java.io.Reader r, Parser yyparser) {

                // The default constructor (not defined here?) that calls for r.readLine() or something that collects input.
                this(r);

                this.yyparser = yyparser;
        }
%}

%%

"("     { yyparser.yylval = new ParserVal("" + yytext());
                return Parser.ROUND_OPEN_B; }

")"     { yyparser.yylval = new ParserVal("" + yytext());
                return Parser.ROUND_CLOSE_B; }

"["     { yyparser.yylval = new ParserVal("" + yytext());
                return Parser.SQUARE_OPEN_B; }

"]"     { yyparser.yylval = new ParserVal("" + yytext());
                return Parser.SQUARE_CLOSE_B; }

[a-z]+  { yyparser.yylval = new ParserVal(yytext());
                return Parser.LOWER_CASE; }

/* More explicit way to dump any char that does not match other rules */
/* This action of dumping other character is not effectless. In fact it is seen that if a throwaway char or string breaks apart a LOWER_CASE token the parser will raise syntax error if there isn't any suitable production rule to handle two LOWER_CASE tokens */
[^[a-z]\(\)]     {}
