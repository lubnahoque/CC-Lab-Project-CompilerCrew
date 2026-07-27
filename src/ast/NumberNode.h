#ifndef NUMBERNODE_H
#define NUMBERNODE_H

#include "ExpressionNode.h"
#include <iostream>

class NumberNode : public ExpressionNode {
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
