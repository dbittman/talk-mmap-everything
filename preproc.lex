/*** Definition section ***/

%{
/* C code to be copied verbatim */
#include <stdio.h>
static int doing_code = 0;
%}

KEYWORD if|while|else|break|continue|do|for|typedef|volatile|return
TYPE " int "|" char "|u?int[:digit:]+_t|u?intptr_t|" short "|" long "|" unsigned "|" signed "|" _Atomic "|" fd_set "
VALUE (0x)?[0-9]+|false|true|NULL
/* This tells flex to read only one input file */
%option noyywrap

%%

^".HIGHLIGHT" {
	doing_code = !doing_code;
	if(doing_code)
		printf(".nf\n");
	else
		printf(".ad\n");
}

{KEYWORD} {
	if(doing_code)
		printf("\\m[cyan]%s\\m[]", yytext);
	else
		printf("%s", yytext);
}

{VALUE} {
	if(doing_code)
		printf("\\m[green]%s\\m[]", yytext);
	else
		printf("%s", yytext);
}
{TYPE} {
	if(doing_code)
		printf("\\m[yellow]%s\\m[]", yytext);
	else
		printf("%s", yytext);
}
\t {
	if(doing_code)
		printf("    ");
	else
		printf("%s", yytext);
}
.|\n    {   printf("%s", yytext);   }

%%
/*** C Code section ***/

int main(void)
{
    /* Call the lexer, then quit. */
    yylex();
    return 0;
}
