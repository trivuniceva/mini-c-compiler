%{
  #include <stdio.h>
  #include "defs.h"

  int yyparse(void);
  int yylex(void);
  int yyerror(char *s);
  extern int yylineno;
%}

%token _TYPE
%token _IF
%token _ELSE
%token _RETURN
%token _ID
%token _INT_NUMBER
%token _UINT_NUMBER
%token _LPAREN
%token _RPAREN
%token _LBRACKET
%token _RBRACKET
%token _ASSIGN
%token _SEMICOLON
%token _AROP
%token _RELOP

%token _COMMA

%token _SELECT
%token _FROM
%token _WHERE

%token _DO
%token _WHILE

%token _INCREMENT

%token _FOR
%token _NEXT
%token _TO
%token _DOWNTO
%token _STEP

%token _DEC

%nonassoc ONLY_IF
%nonassoc _ELSE

%%

program
  : function_list
  ;

function_list
  : function
  | function_list function
  ;

/* -----------------------
   Resenje: Zadatak 6
   ----------------------- */
function
  : type _ID _LPAREN parameter _RPAREN body
  ;

type
  : _TYPE
  ;

parameter
  : /* empty */
  | params
  ;

params
  : type _ID
  | params _COMMA type _ID
  ;

body
  : _LBRACKET variable_list statement_list _RBRACKET
  ;

variable_list
  : /* empty */
  | variable_list variable
  ;

variable
  : type vars _SEMICOLON
  ;

   /* -----------------------
   Resenje: Zadatak 1
   ----------------------- */
vars 
  : var
  | vars _COMMA var // zamenjen _ID sa var zbog unsigned b = 5u, c = 10u;
  ;

 /* -----------------------
   Deklaracija sa inicijalizacijom 
   int a = 1; 
   ----------------------- */
var 
  : _ID
  | _ID _ASSIGN num_exp
  ;

statement_list
  : /* empty */
  | statement_list statement
  ;

statement
  : compound_statement
  | assignment_statement
  | if_statement
  | return_statement
  | select_statement // Z2
  | do_while_statement // Z3
  | for_statement // Z5
  | function_call_statement // Z6
  | increment_statement // Z4
  | dec_statement // dodatno
  ;

  /* -----------------------
   Resenje: Zadatak 2
   ----------------------- */
select_statement
  : _SELECT vars _FROM _ID _WHERE condition _SEMICOLON
  ;

condition
  : _LPAREN rel_exp _RPAREN
  ;

 /* -----------------------
   Resenje: Zadatak 3
   ----------------------- */
do_while_statement
  : _DO statement _WHILE condition _SEMICOLON
  ;

/* -----------------------
   Resenje: Zadatak 4
   ----------------------- */
increment_statement
  : _ID _INCREMENT _SEMICOLON
  ;

dec_statement
  : _ID _DEC _SEMICOLON
  ;

/* -----------------------
   Resenje: Zadatak 5
   ----------------------- */
for_statement
  : _FOR _ID _ASSIGN literal direction literal step statement _NEXT _ID

direction 
  : _TO
  | _DOWNTO
  ;

step
  : /* empty */
  | _STEP literal
  ;

compound_statement
  : _LBRACKET statement_list _RBRACKET
  ;

assignment_statement
  : _ID _ASSIGN num_exp _SEMICOLON
  ;

num_exp
  : exp
  | num_exp _AROP exp
  ;

exp
  : literal
  | _ID
  | _ID _INCREMENT // Zadatak 4
  | _ID _DEC  // dodatno
  | function_call
  | _LPAREN num_exp _RPAREN
  ;

literal
  : _INT_NUMBER
  | _UINT_NUMBER
  ;

function_call
  : _ID _LPAREN argument _RPAREN
  ;

/* -----------------------
   Resenje: Zadatak 6
   ----------------------- */

function_call_statement
  : function_call _SEMICOLON // poziv funkcije kao iskaz
  ;

argument
  : /* empty */
  | args
  ;

args 
  : num_exp
  | args _COMMA num_exp
  ;

if_statement
  : if_part %prec ONLY_IF
  | if_part _ELSE statement
  ;

if_part
  : _IF _LPAREN rel_exp _RPAREN statement
  ;

rel_exp
  : num_exp _RELOP num_exp
  ;

return_statement
  : _RETURN num_exp _SEMICOLON
  ;

%%

int yyerror(char *s) {
  fprintf(stderr, "\nline %d: ERROR: %s", yylineno, s);
  return 0;
}

int main() {
  return yyparse();
}
