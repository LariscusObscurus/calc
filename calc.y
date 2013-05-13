%{
#include <stdio.h>
#include <math.h>
#include <string.h>
int sym[26];
int arr[10] = {0};
int count = 0;

/*int min(int a, int b);
int max(int a, int b);*/
int min();
int max();
void append(int a);
%}

%token VARIABLE ASSIGN INTEGER NEWLINE BRACEL BRACER SEP
%left GREATER LESSER EQ NEQ GTEQ LTEQ
%left MINUS PLUS
%left TIMES DIVISION
%left POW MIN MAX
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
	| expr LTEQ expr	{ $$ = $1 <= $3;}
	| expr GTEQ expr	{ $$ = $1 >= $3;}
	| expr EQ expr		{ $$ = $1 == $3;}
	| expr NEQ expr		{ $$ = $1 != $3;}
	| BRACEL expr BRACER	{ $$ = $2; } 
	| expr POW expr		{ $$ = pow($1, $3);} 
	| MIN BRACEL listloop BRACER
				{ $$ = min();
				memset(arr, 0, 10*sizeof(int));
				count = 0;
				}
	| MAX BRACEL listloop BRACER
				{ $$ = max();
				memset(arr, 0, 10*sizeof(int));
				count = 0;
				}
	;

listloop: expr			{append($1);}
	| listloop SEP expr	{append($3);}
	;

%%

void append(int a)
{
	arr[count] = a;
	count++;
}

int min()
{
	int i;
	int min = arr[0];
	for(i = 0; i < count; i++) {
		if(arr[i]< min) {
			min = arr[i];
		}
	}
	return min;
}

int max()
{
	int i;
	int max = arr[0];
	for(i = 0; i < count; i++) {
		if(arr[i]> max) {
			max = arr[i];
		}
	}
	return max;
}

int yyerror(char *s) {
	fprintf(stderr, "%s\n", s);
	return 0;
}

int main() {
	yyparse();
	return 0;
}
