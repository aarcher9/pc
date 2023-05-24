
%%

%byaccj

%{
        /* store a reference to the parser object */
        private Parser yyparser;

        /* constructor taking an additional parser object */
        public Yylex(java.io.Reader r, Parser yyparser) {

                // The default constructor (not defined here?) that calls for r.readLine(); possibly an outer while cycle checks for Ctrl-D and another inner cycle calls the lexer on the current line whenever a line feed is encountered
                this(r);

                this.yyparser = yyparser;
        }
%}

%%

// In this case is ok to return only the token because the token and the matched string are basically the same thing
"("     { //  yyparser.yylval = new ParserVal("" + yytext());
                System.out.println("op");
                return Parser.OPEN_PAREN; }

")"     { // yyparser.yylval = new ParserVal("" + yytext());
                System.out.println("cp");
                return Parser.CLOSE_PAREN; }

// Here token is not the same as the matched string
[a-z]+  { yyparser.yylval = new ParserVal(yytext());
                System.out.println("lower");
                return Parser.LOWER_CASE; }

/* More explicit way to dump any char that does not match other rules */
[^[a-z]\(\)]     {}
