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

%token _WHILE
%token _BREAK

%token _FOR 
%token _INC 

%token _ADDOP 
%token _MULOP 

%left _ADDOP
%left _MULOP

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

function
  : type _ID _LPAREN parameter _RPAREN body
  ;

type
  : _TYPE
  ;

parameter
  : /* empty */
  | type _ID
  ;

body
  : _LBRACKET variable_list statement_list _RBRACKET
  ;

variable_list
  : /* empty */
  | variable_list variable
  ;


/* -----------------------
   Resenje: Zadatak 1 - definisanje a
   ----------------------- */

variable
  : type vars _SEMICOLON
  ;

vars 
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
  | while_statement
  | break_statement
  | for_statement
  | increment_statement
  ;

/* -----------------------
   Resenje: Zadatak 1 - while
   ----------------------- */
while_statement
  : _WHILE condition statement
  ;

condition
  : _LPAREN rel_exp _RPAREN
  ;

/* -----------------------
   Resenje: Zadatak 2 - break
   ----------------------- */
break_statement
  : _BREAK _SEMICOLON
  ;

/* -----------------------
   Resenje: Zadatak 3 - for
   ----------------------- */
for_statement
  : _FOR _LPAREN for_condition _RPAREN statement
  ;

for_condition
  : assignment_statement rel_exp _SEMICOLON increment_statement 
  ;

increment_statement
  : _ID _INC 
  ;

compound_statement
  : _LBRACKET statement_list _RBRACKET
  ;

assignment_statement
  : _ID _ASSIGN num_exp _SEMICOLON
  ;


// _ADDOP imaju nizi prioritet od _MULOP
num_exp
  : exp
  | num_exp _ADDOP num_exp
  | num_exp _MULOP num_exp
  ;

exp
  : literal
  | _ID
  | _ID _INC
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

argument
  : /* empty */
  | num_exp
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
