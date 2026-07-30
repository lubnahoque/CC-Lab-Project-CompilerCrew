#ifndef NUMBERNODE_H
#define NUMBERNODE_H

#include "ExpressionNode.h"
#include <iostream>
#include <string>

class NumberNode : public ExpressionNode
{
public:
    int value;

    NumberNode(int val)
    {
        value = val;
    }

    void print() override
    {
        std::cout << "Number: " << value << std::endl;
    }

    std::string getType() override
    {
        return "int";
    }

    std::string getPlace() override
    {
        return std::to_string(value);
    }
};

#endif
