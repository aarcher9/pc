
%%

%class Main
%standalone

%{
  String name;
%}

%%

"name " [a-z]+     { System.out.print("[" + yytext() + "]"); }
[Hh] "ello"        { System.out.print("[" + yytext() + "]"); }
