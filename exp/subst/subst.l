
%%

%class Subst
%standalone

%{
  String name;
  public static final String ANSI_RESET = "\u001B[0m";
  public static final String ANSI_BLACK = "\u001B[30m";
  public static final String ANSI_RED = "\u001B[31m";
  public static final String ANSI_GREEN = "\u001B[32m";
  public static final String ANSI_YELLOW = "\u001B[33m";
  public static final String ANSI_BLUE = "\u001B[34m";
  public static final String ANSI_PURPLE = "\u001B[35m";
  public static final String ANSI_CYAN = "\u001B[36m";
  public static final String ANSI_WHITE = "\u001B[37m";

  void highlight(String text) {
    System.out.print(ANSI_GREEN + text + ANSI_RESET);
  } 
%}

%%

/* Identifica la stringa 'nameMarco', elimina le prime 4 lettere, quelle di name, e poi se trova un 'Hello' o un 'hello' ci stampa 'helloMarco' o 'HelloMarco' */
"name" [a-zA-Z]  { name = yytext().substring(4); }
[Hh] "ello"        { highlight(yytext()); }
