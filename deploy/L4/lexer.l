
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

["\t""\n"" "]
        { 
                // ignore SPACE, TABS, and LINE_FEED
        }

":"
        {
                return Parser.COLON; 
        }

";"
        {
                return Parser.SEMI_COLON; 
        }

"{"
        {
                return Parser.OPEN_CURLY_BRA; 
        }

"}"
        {
                return Parser.CLOSE_CURLY_BRA; 
        }

[a-z]+
        { 
                yyparser.yylval = new ParserVal(yytext());
                return Parser.PLAIN_WORD; 
        }

// collection of allowed characters
[0-9]+
        { 
                /* System.out.println("dot found"); */

                yyparser.yylval = new ParserVal(yytext());
                return Parser.ALLOWED_SPECIAL; 
        }