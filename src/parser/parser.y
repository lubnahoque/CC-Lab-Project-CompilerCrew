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

%token INT FLOAT BOOL
%token IF ELSE WHILE PRINT
%token TRUE FALSE

%token ASSIGN EQ NE GT LT GE LE AND OR NOT
%token PLUS MINUS MULT DIV MOD COMMA

%left OR
%left AND
%left EQ NE
%left GT LT GE LE
%left PLUS MINUS
%left MULT DIV MOD
%right NOT
%right ASSIGN

%%

program : statements
        ;

statements : statement
           | statements statement
           ;

statement
    : declaration ';'
    | assignment ';'
    | print_stmt ';'
    | if_stmt
    | while_stmt
    ;

if_stmt
    : IF '(' expression ')' '{' statements '}'
      {
          std::cout << "Parsed if statement" << std::endl;
      }
    | IF '(' expression ')' '{' statements '}' ELSE '{' statements '}'
      {
          std::cout << "Parsed if-else statement" << std::endl;
      }
    ;

while_stmt
    : WHILE '(' expression ')' '{' statements '}'
      {
          std::cout << "Parsed while statement" << std::endl;
      }
    ;

declaration : INT IDENTIFIER { std::cout << "Parsed declaration: int " << $2 << std::endl; free($2); }
            | BOOL IDENTIFIER { std::cout << "Parsed declaration: bool " << $2 << std::endl; free($2); }
            ;

assignment : IDENTIFIER ASSIGN expression { std::cout << "Parsed assignment: " << $1 << " = ..." << std::endl; free($1); }
           ;

print_stmt : PRINT expression { std::cout << "Parsed print statement" << std::endl; }
           ;

expression
    : NUMBER
    | IDENTIFIER { free($1); }
    | TRUE
    | FALSE
    | expression PLUS expression
    | expression MINUS expression
    | expression MULT expression
    | expression DIV expression
    | expression MOD expression
    | '(' expression ')'
    | expression GT expression
    | expression LT expression
    | expression GE expression
    | expression LE expression
    | expression EQ expression
    | expression NE expression
    | expression AND expression
    | expression OR expression
    | NOT expression
    ;
%%

void yyerror(const char* s) {
    std::cerr << "Syntax Error: " << s << " at line " << yylineno << " near '" << yytext << "'" << std::endl;
}
