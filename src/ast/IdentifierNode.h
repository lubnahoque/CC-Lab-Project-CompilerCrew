#ifndef IDENTIFIERNODE_H
#define IDENTIFIERNODE_H

#include "ExpressionNode.h"
#include <iostream>
#include <string>

class IdentifierNode : public ExpressionNode {
private:
    std::string name;

public:
    IdentifierNode(const std::string& n) : name(n) {}

    void print() override {
        std::cout << "Identifier: " << name << std::endl;
    }
};

#endif
