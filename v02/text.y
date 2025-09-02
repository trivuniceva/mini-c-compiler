%{
  #include <stdio.h>

  int dot_sentence_counter = 0;
  int questrion_mark_counter = 0;
  int exclamation_mark_counter = 0;

  int yylex(void);
  int yyparse(void);
  int yyerror(char *);
  extern int yylineno;
%}

%token  _DOT
%token  _CAPITAL_WORD
%token  _WORD

/* -----------------------
   Resenje: Zadatak 1
   ----------------------- */
%token  _QUESTION_MARK
%token  _EXCLAMATION_MARK

/* -----------------------
   Resenje: Zadatak 2
   ----------------------- */
%token _COMMA

%%

text 
  : sentence
  | text sentence
  ;
          
sentence 
  : words end
  ;

/* -----------------------
   Resenje: Zadatak 1
   ----------------------- */
end 
  : _DOT { dot_sentence_counter++; }
  | _QUESTION_MARK { questrion_mark_counter++; }
  | _EXCLAMATION_MARK { exclamation_mark_counter++; }
  ;

/* -----------------------
   Resenje: Zadatak 2
   Prosirujemo words tako da osiguramo da na zarez ne bude pre _DOT
   ----------------------- */
words 
  : _CAPITAL_WORD
  | words comma _WORD
  | words comma _CAPITAL_WORD 
  ;

comma 
  : /* empty */
  | _COMMA
  ;

%%

int main() {
  yyparse();

  printf("Broj izjavnih recenica: %d\n", dot_sentence_counter);
  printf("Broj upitnih recenica: %d\n", questrion_mark_counter);
  printf("Broj uzvicnih recenica: %d\n", exclamation_mark_counter);

  return 0;
}

int yyerror(char *s) {
  fprintf(stderr, "line %d: SYNTAX ERROR %s\n", yylineno, s);

  return 0;
} 

