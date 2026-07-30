#ifndef BINARYEXPRESSIONNODE_H
#define BINARYEXPRESSIONNODE_H

#include "ExpressionNode.h"
#include <iostream>
#include <string>
#include "../tac/TACGenerator.h"

extern TACGenerator tac;
class BinaryExpressionNode : public ExpressionNode
{
private:
    ExpressionNode* left;
    ExpressionNode* right;
    std::string op;

    std::string place;

public:
    BinaryExpressionNode(ExpressionNode* l,
                         const std::string& o,
                         ExpressionNode* r)
        : left(l), right(r), op(o)
    {
    }

    void print() override
    {
        std::cout << "Operator: " << op << std::endl;

        std::cout << "Left: ";
        left->print();

        std::cout << "Right: ";
        right->print();
    }

    std::string getType() override
    {
        std::string leftType = left->getType();
        std::string rightType = right->getType();

        // Arithmetic operators
        if (op == "+" || op == "-" || op == "*" ||
            op == "/" || op == "%")
        {
            if (leftType == "int" && rightType == "int")
                return "int";

            return "";
        }

        // Logical operators
        if (op == "&&" || op == "||")
        {
            if (leftType == "bool" && rightType == "bool")
                return "bool";

            return "";
        }

        // Comparison operators
        if (op == "==" || op == "!=" ||
            op == "<"  || op == ">"  ||
            op == "<=" || op == ">=")
        {
            if (leftType == rightType)
                return "bool";

            return "";
        }

        return "";
        }
        std::string getPlace() override
        {
    std::string leftPlace = left->getPlace();
    std::string rightPlace = right->getPlace();

    std::string temp = tac.newTemp();

    tac.emit(temp + " = " + leftPlace + " " + op + " " + rightPlace);

    return temp;
        }
};

#endif
