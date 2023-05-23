
%%

input: {
    $$ = new ParserVal("");
    System.out.println(": \"" + $$.sval + "\""); 
  } |
  input negS {
    $$ = new ParserVal($1.sval + $2.sval);
    System.out.println(": " + $$.sval); 
  } |
  input '+' {
    $$ = new ParserVal($1.sval + $2.sval);
    System.out.println(": " + $$.sval); 
  }

negS: '-' { 
    $$ = $1;
    System.out.println("1st");
  } |
  negS '-' { 
    $$ = new ParserVal($1.sval + $2.sval);
    System.out.println("2nd");
  }

%%

void yyerror(String s) {
  System.out.println("err:" + s);
  System.out.println("   :" + yylval.sval);
}

int ind = 0;
String in = "----++--";

int yylex() {

  if (ind < in.length()) {

    yylval = new ParserVal("" + in.charAt(ind++));
    return yylval.sval.charAt(0);

  } else return 0;
}

public static void main(String args[]) {
  Parser par = new Parser();
  par.yyparse();
}

