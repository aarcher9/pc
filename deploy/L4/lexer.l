
%%

%byaccj

%{
        private Parser yyparser;

        public Yylex(java.io.Reader r, Parser yyparser) {

                this(r);
                this.yyparser = yyparser;
        }
%}

%%

":"
        {
                yyparser.yylval = new ParserVal(yytext());
                return Parser.COLON; 
        }

";"
        {
                yyparser.yylval = new ParserVal(yytext());
                return Parser.SEMI_COLON; 
        }

"{"
        {
                yyparser.yylval = new ParserVal(yytext());
                return Parser.OPEN_CURLY_BRA; 
        }

"}"
        {
                yyparser.yylval = new ParserVal(yytext());
                return Parser.CLOSE_CURLY_BRA; 
        }

[a-z]+
        { 
                yyparser.yylval = new ParserVal(yytext());
                return Parser.PLAIN_WORD; 
        }

([a-z]+ " "*)+
        { 
                yyparser.yylval = new ParserVal(yytext());
                return Parser.SPACED_WORD; 
        }

[a-zA-Z0-9\.\/]+
        { 
                yyparser.yylval = new ParserVal(yytext());
                return Parser.SPECIAL_WORD; 
        }

["\t""\n"" "]
        { 
                // BLANK CHARACTERS are here also allowed (to prevent input mismatch) but ignored entirely delivering the parser to check some syntax rules breaking
        }