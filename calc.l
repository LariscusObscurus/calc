%{
extern int yylval; 
extern int sym[];
#include "y.tab.h"
%}

%%

[a-z]   {
	yylval = *yytext - 'a';
	return VARIABLE;
}

[0-9]+  {  
	yylval = atoi(yytext);
	return INTEGER;
}

0x[A-Fa-f0-9]+ {
	yylval = (int) strtol(yytext, NULL, 0);
	return INTEGER;
}

":="    return ASSIGN;
"+"     return PLUS;
"-"	return MINUS;
"/"	return DIVISION;
"*"     return TIMES;
"%"	return MODULO;
"<"	return LESSER;
">"	return GREATER;
"<="	return LTEQ;
">="	return GTEQ;
"=="	return EQ;
"!="	return NEQ;
"("	return BRACEL;
")"	return BRACER;
"^"	return POW;
"min"	return MIN;
"max"	return MAX;
","	return SEP;
"?"	return COND;
":"	return OPT;

"\n"    return NEWLINE;

[ \t]   ;

.       yyerror("Invalid character");

%%

int yywrap() {
	return 1;
}
