%{
#include "parser.tab.hpp"
#include <iostream>
#include <cstdlib>
#include <cstring>
%}

%option noyywrap
%option yylineno

%%

"int"           { return INT; }
"float"         { return FLOAT; }
"bool"          { return BOOL; }
"if"            { return IF; }
"else"          { return ELSE; }
"while"         { return WHILE; }
"print"         { return PRINT; }
"true"          { return TRUE; }
"false"         { return FALSE; }
"="             { return ASSIGN; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MULT; }
"/"             { return DIV; }
"%"             { return MOD; }
"=="            { return EQ; }
"!="            { return NE; }
">="            { return GE; }
"<="            { return LE; }
">"             { return GT; }
"<"             { return LT; }
"&&"            { return AND; }
"||"            { return OR; }
"!"             { return NOT; }
","             { return COMMA; }
";"             { return ';'; }
"{"             { return '{'; }
"}"             { return '}'; }
"("             { return '('; }
")"             { return ')'; }

[a-zA-Z_][a-zA-Z0-9_]* {
    yylval.str = strdup(yytext);
    return IDENTIFIER;
}

[0-9]+ {
    yylval.num = atoi(yytext);
    return NUMBER;
}

[ \t\r\n]+      { /* ignore whitespace */ }
"//"[^\n]*      { /* ignore comments */ }

. {
    std::cerr << "Lexical Error: Invalid token '" << yytext << "' at line " << yylineno << std::endl;
    return -1; // return error token or exit
}

%%
