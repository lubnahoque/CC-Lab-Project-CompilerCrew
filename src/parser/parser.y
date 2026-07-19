%{
#include <iostream>
#include <string>
#include <cstring>

// Declare external functions and variables from flex
extern int yylex();
extern int yylineno;
extern char* yytext;
void yyerror(const char* s);
%}

%union {
    int num;
    char* str;
}

%token <num> NUMBER
%token <str> IDENTIFIER
%token INT BOOL IF ELSE WHILE PRINT TRUE FALSE
%token ASSIGN EQ NE GT LT AND OR

%%

program : statements
        ;

statements : statement
           | statements statement
           ;

statement : declaration ';'
          | assignment ';'
          | print_stmt ';'
          ;

declaration : INT IDENTIFIER { std::cout << "Parsed declaration: int " << $2 << std::endl; free($2); }
            | BOOL IDENTIFIER { std::cout << "Parsed declaration: bool " << $2 << std::endl; free($2); }
            ;

assignment : IDENTIFIER ASSIGN expression { std::cout << "Parsed assignment: " << $1 << " = ..." << std::endl; free($1); }
           ;

print_stmt : PRINT expression { std::cout << "Parsed print statement" << std::endl; }
           ;

expression : NUMBER
           | IDENTIFIER { free($1); }
           | TRUE
           | FALSE
           ;

%%

void yyerror(const char* s) {
    std::cerr << "Syntax Error: " << s << " at line " << yylineno << " near '" << yytext << "'" << std::endl;
}
