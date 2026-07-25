#ifndef UNARYEXPRESSIONNODE_H
#define UNARYEXPRESSIONNODE_H

#include "ExpressionNode.h"
#include <iostream>
#include <string>

class UnaryExpressionNode : public ExpressionNode
{
private:
    std::string op;
    ExpressionNode* expr;

public:
    UnaryExpressionNode(const std::string& o,
                        ExpressionNode* e)
        : op(o), expr(e)
    {
    }

    void print() override
    {
        std::cout << "Unary Operator: "
                  << op << std::endl;

        if (expr)
            expr->print();
    }
};

#endif
