#ifndef BOOLEANNODE_H
#define BOOLEANNODE_H

#include "ExpressionNode.h"
#include <iostream>

class BooleanNode : public ExpressionNode
{
private:
    bool value;

public:
    BooleanNode(bool v)
        : value(v)
    {
    }

    void print() override
    {
        std::cout << "Boolean: "
                  << (value ? "true" : "false")
                  << std::endl;
    }
};

#endif
