%{
#include <iostream>
#include <string>
#include <cstring>
#include "../ast/ASTNode.h"
#include "../ast/NumberNode.h"
#include "../ast/IdentifierNode.h"
#include "../ast/BinaryExpressionNode.h"
#include "../ast/BooleanNode.h"
#include "../ast/UnaryExpressionNode.h"
#include "../semantic/SymbolTable.h"
// Declare external functions and variables from flex
extern int yylex();
extern int yylineno;
extern char* yytext;
void yyerror(const char* s);
SymbolTable symbolTable;
%}

%code requires {
class ASTNode;
}
%union {
    int num;
    char* str;
ASTNode* node;
}

%token <num> NUMBER
%token <str> IDENTIFIER

%token INT FLOAT BOOL
%token IF ELSE WHILE PRINT
%token TRUE FALSE

%token ASSIGN EQ NE GT LT GE LE AND OR NOT
%token PLUS MINUS MULT DIV MOD COMMA

%type <node> expression

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

declaration
    : INT IDENTIFIER
      {
          if (!symbolTable.insert($2, "int"))
          {
              std::cout << "Semantic Error: Variable '" << $2
                        << "' is already declared." << std::endl;
          }
          else
          {
              std::cout << "Parsed declaration: int " << $2 << std::endl;
          }

          free($2);
      }

    | BOOL IDENTIFIER
      {
          if (!symbolTable.insert($2, "bool"))
          {
              std::cout << "Semantic Error: Variable '" << $2
                        << "' is already declared." << std::endl;
          }
          else
          {
              std::cout << "Parsed declaration: bool " << $2 << std::endl;
          }

          free($2);
      }
    ;
    
             
assignment : IDENTIFIER ASSIGN expression {
    if (!symbolTable.exists($1))
    {
        std::cout << "Semantic Error: Variable '"
                  << $1
                  << "' is not declared."
                  << std::endl;
    }
    else
    {
        std::cout << "Parsed assignment: " << $1 << std::endl;

        std::cout << "Expression AST:" << std::endl;
        $3->print();

        symbolTable.print();
    }

    free($1);
}
;

print_stmt : PRINT expression { std::cout << "Parsed print statement" << std::endl; }
           ;
expression
    : NUMBER
      {
          $$ = new NumberNode($1);
      }
    | IDENTIFIER
      {
          $$ = new IdentifierNode($1);
          free($1);
      }
    | TRUE
{
    $$ = new BooleanNode(true);
}
    | FALSE
{
    $$ = new BooleanNode(false);
}
    | expression PLUS expression
{
    $$ = new BinaryExpressionNode(
            (ExpressionNode*)$1,
            "+",
            (ExpressionNode*)$3
         );
}
    | expression MINUS expression
{
    $$ = new BinaryExpressionNode(
            (ExpressionNode*)$1,
            "-",
            (ExpressionNode*)$3
         );
}
    | expression MULT expression
{
    $$ = new BinaryExpressionNode(
            (ExpressionNode*)$1,
            "*",
            (ExpressionNode*)$3
         );
}
    | expression DIV expression
{
    $$ = new BinaryExpressionNode(
            (ExpressionNode*)$1,
            "/",
            (ExpressionNode*)$3
         );
}
    | expression MOD expression
{
    $$ = new BinaryExpressionNode(
            (ExpressionNode*)$1,
            "%",
            (ExpressionNode*)$3
         );
}
| '(' expression ')'
{
    $$ = $2;
}   
    | expression GT expression
{
    $$ = new BinaryExpressionNode(
            (ExpressionNode*)$1,
            ">",
            (ExpressionNode*)$3
         );
}
    | expression LT expression
{
    $$ = new BinaryExpressionNode(
            (ExpressionNode*)$1,
            "<",
            (ExpressionNode*)$3
         );
}
    | expression GE expression
{
    $$ = new BinaryExpressionNode(
            (ExpressionNode*)$1,
            ">=",
            (ExpressionNode*)$3
         );
}
    | expression LE expression
{
    $$ = new BinaryExpressionNode(
            (ExpressionNode*)$1,
            "<=",
            (ExpressionNode*)$3
         );
}
    | expression EQ expression
{
    $$ = new BinaryExpressionNode(
            (ExpressionNode*)$1,
            "==",
            (ExpressionNode*)$3
         );
}
    | expression NE expression
{
    $$ = new BinaryExpressionNode(
            (ExpressionNode*)$1,
            "!=",
            (ExpressionNode*)$3
         );
}
    | expression AND expression
{
    $$ = new BinaryExpressionNode(
            (ExpressionNode*)$1,
            "&&",
            (ExpressionNode*)$3
         );
}
    | expression OR expression
{
    $$ = new BinaryExpressionNode(
            (ExpressionNode*)$1,
            "||",
            (ExpressionNode*)$3
         );
}
    | NOT expression
{
    $$ = new UnaryExpressionNode(
            "!",
            (ExpressionNode*)$2
         );
}
    ;
%%

void yyerror(const char* s) {
    std::cerr << "Syntax Error: " << s << " at line " << yylineno << " near '" << yytext << "'" << std::endl;
}
