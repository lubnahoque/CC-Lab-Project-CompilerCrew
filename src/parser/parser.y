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
#include "../ast/FloatNode.h"
#include "../semantic/SymbolTable.h"
#include "../tac/TACGenerator.h"
// Declare external functions and variables from flex
extern int yylex();
extern int yylineno;
extern char* yytext;
void yyerror(const char* s);
SymbolTable symbolTable;
TACGenerator tac;
%}

%code requires {
class ASTNode;
}
%union {
    int num;
    float fnum;
    char* str;
    ASTNode* node;
}

%token <num> NUMBER
%token <fnum> FLOAT_NUMBER
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
block
    : '{'
      {
          symbolTable.enterScope();
      }
      statements
      '}'
      {
          symbolTable.exitScope();
      }
    ;

if_stmt
    : IF '(' expression ')' block
      {
          ExpressionNode* expr = (ExpressionNode*)$3;

          if (expr->getType() != "bool")
          {
              std::cout << "Semantic Error: Condition must be boolean."
                        << std::endl;
          }

          std::cout << "Parsed if statement" << std::endl;
      }

    | IF '(' expression ')' block ELSE block
      {
          ExpressionNode* expr = (ExpressionNode*)$3;

          if (expr->getType() != "bool")
          {
              std::cout << "Semantic Error: Condition must be boolean."
                        << std::endl;
          }

          std::cout << "Parsed if-else statement" << std::endl;
      }
    ;


while_stmt
    : WHILE '(' expression ')' block
      {
          ExpressionNode* expr = (ExpressionNode*)$3;

          if (expr->getType() != "bool")
          {
              std::cout << "Semantic Error: Condition must be boolean."
                        << std::endl;
          }

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

    | FLOAT IDENTIFIER
      {
          if (!symbolTable.insert($2, "float"))
          {
              std::cout << "Semantic Error: Variable '" << $2
                        << "' is already declared." << std::endl;
          }
          else
          {
              std::cout << "Parsed declaration: float " << $2 << std::endl;
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

    ExpressionNode* expr = (ExpressionNode*)$3;

    std::string variableType = symbolTable.getType($1);
    std::string expressionType = expr->getType();

    if (expressionType == "")
{
    std::cout << "Semantic Error: Invalid expression."
              << std::endl;
}
else if (variableType != expressionType)
{
    std::cout << "Semantic Error: Type mismatch in assignment."
              << std::endl;
}
else
{
    tac.emit(std::string($1) + " = " + expr->getPlace());
}

    std::cout << "Expression AST:" << std::endl;
    expr->print();

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
    | FLOAT_NUMBER
{
    $$ = new FloatNode($1);
}
    | IDENTIFIER
{
    std::string type = "";

    if (!symbolTable.exists($1))
    {
        std::cout << "Semantic Error: Variable '"
                  << $1
                  << "' is not declared."
                  << std::endl;
    }
    else
    {
        type = symbolTable.getType($1);
    }

    $$ = new IdentifierNode($1, type);
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
