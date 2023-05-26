
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

","
        {
                yyparser.yylval = new ParserVal(yytext());
                return Parser.COMMA; 
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

[0-9]+
        { 
                yyparser.yylval = new ParserVal(yytext());
                return Parser.DIGITS; 
        }

[a-zA-Z]+
        { 
                yyparser.yylval = new ParserVal(yytext());
                return Parser.WORD; 
        }

"\"" [a-zA-Z0-9 " "]+ "\""
        { 
                yyparser.yylval = new ParserVal(yytext().substring(1, yytext().length() - 1));
                return Parser.MIXED; 
        }

["\t" "\n" "\r" " "]
        { 
                // BLANK CHARACTERS are here also allowed (to prevent input mismatch) but ignored entirely delivering the parser to check some syntax rules breaking
        }