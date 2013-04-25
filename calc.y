%{
#include <stdio.h>
#include <math.h>
int sym[26];
%}

%token VARIABLE ASSIGN INTEGER NEWLINE BRACEL BRACER
%left GREATER LESSER
%left MINUS PLUS
%left TIMES DIVISION
%left POW
%left MODULO

%%

program: program statement
	| 
	;

statement: expr NEWLINE		{ printf("%d\n", $1); }
	| VARIABLE ASSIGN expr NEWLINE { sym[$1] = $3; }
	;

expr: INTEGER			{ $$ = $1; }
	| VARIABLE		{ $$ = sym[$1]; }
	| expr PLUS expr	{ $$ = $1 + $3; }
	| expr TIMES expr	{ $$ = $1 * $3; }
	| expr MODULO expr	{ $$ = $1 % $3; }
	| expr MINUS expr	{ $$ = $1 - $3; }
	| expr DIVISION expr	{ $$ = $1 / $3; }
	| expr LESSER expr	{ $$ = $1 < $3; }
	| expr GREATER expr	{ $$ = $1 > $3; }
	| BRACEL expr BRACER	{ $$ = $2; } 
	| expr POW expr		{ $$ = pow($1, $3); } 
	;
%%

int yyerror(char *s) {
	fprintf(stderr, "%s\n", s);
	return 0;
}

int main() {
	yyparse();
	return 0;
}
