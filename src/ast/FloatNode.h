#ifndef FLOATNODE_H
#define FLOATNODE_H

#include "ExpressionNode.h"
#include <iostream>
#include <string>

class FloatNode : public ExpressionNode
{
public:
    float value;

    FloatNode(float val)
    {
        value = val;
    }

    void print() override
    {
        std::cout << "Float: " << value << std::endl;
    }

    std::string getType() override
    {
        return "float";
    }
};

#endif
