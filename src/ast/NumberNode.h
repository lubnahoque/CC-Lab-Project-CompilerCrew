#ifndef NUMBERNODE_H
#define NUMBERNODE_H

#include "ASTNode.h"
#include <iostream>

class NumberNode : public ASTNode {
public:
    int value;

    NumberNode(int val) {
        value = val;
    }

    void print() override {
        std::cout << "Number: " << value << std::endl;
    }
};

#endif
