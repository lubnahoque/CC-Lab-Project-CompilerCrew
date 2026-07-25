#ifndef BINARYEXPRESSIONNODE_H
#define BINARYEXPRESSIONNODE_H

#include <string>
#include "ExpressionNode.h"

class BinaryExpressionNode : public ExpressionNode {
public:
    ExpressionNode* left;
    std::string op;
    ExpressionNode* right;

    BinaryExpressionNode(ExpressionNode* l, const std::string& o, ExpressionNode* r)
        : left(l), op(o), right(r) {}

    void print() override {
        std::cout << "(";
        left->print();
        std::cout << " " << op << " ";
        right->print();
        std::cout << ")";
    }
};

#endif
