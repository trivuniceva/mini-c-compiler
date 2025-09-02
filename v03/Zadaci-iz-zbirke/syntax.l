%option noyywrap yylineno
%{
  #include <string.h>
  #include "syntax.tab.h"
  #include "defs.h"
%}

%%

[ \t\n]+             { /* skip */ }

"int"                { return _TYPE; }
"unsigned"           { return _TYPE; }
"if"                 { return _IF; }
"else"               { return _ELSE; }
"return"             { return _RETURN; }

"("                  { return _LPAREN; }
")"                  { return _RPAREN; }
"{"                  { return _LBRACKET; }
"}"                  { return _RBRACKET; }
";"                  { return _SEMICOLON; }
"="                  { return _ASSIGN; }

"+"                  { return _ADDOP; }
"-"                  { return _ADDOP; }
"*"                  { return _MULOP; }
"/"                  { return _MULOP; }

"<"                  { return _RELOP; }
">"                  { return _RELOP; }
"<="                 { return _RELOP; }
">="                 { return _RELOP; }
"=="                 { return _RELOP; }
"!="                 { return _RELOP; }

"while"              { return _WHILE; }
"break"              { return _BREAK; }

"for"                { return _FOR; }
"++"                 { return _INC; }

[a-zA-Z][a-zA-Z0-9]* { return _ID; }
[+-]?[0-9]{1,10}     { return _INT_NUMBER;}
[0-9]{1,10}[uU]      { return _UINT_NUMBER;}

\/\/.*               { /* skip */ }
.                    { printf("line %d: LEXICAL ERROR on char %c\n", 
                              yylineno, *yytext);}
%%
