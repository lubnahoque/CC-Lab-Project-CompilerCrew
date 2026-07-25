#ifndef BINARYEXPRESSIONNODE_H
#define BINARYEXPRESSIONNODE_H

#include "ExpressionNode.h"
#include <iostream>
#include <string>

class BinaryExpressionNode : public ExpressionNode {
private:
    ExpressionNode* left;
    ExpressionNode* right;
    std::string op;

public:
    BinaryExpressionNode(ExpressionNode* l,
                         const std::string& o,
                         ExpressionNode* r)
        : left(l), op(o), right(r) {}

    void print() override {
        std::cout << "Operator: " << op << std::endl;

        std::cout << "Left: ";
        left->print();

        std::cout << "Right: ";
        right->print();
    }
};

#endif
