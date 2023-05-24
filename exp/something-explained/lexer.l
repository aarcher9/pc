
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
                return Parser.OPEN_PAREN; }

")"     { yyparser.yylval = new ParserVal("" + yytext());
                return Parser.CLOSE_PAREN; }

[a-z]+  { yyparser.yylval = new ParserVal(yytext());
                return Parser.LOWER_CASE; }

/* More explicit way to dump any char that does not match other rules */
/* This action of dumping other character is not effectless. In fact it is seen that if a throwaway char breaks a LOWER_CASE token apart the parser will raise syntax error because a the time we din't have any suitable productions to handle two LOWER_CASE tokens */
[^[a-z]\(\)]     {}
