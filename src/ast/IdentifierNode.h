#ifndef IDENTIFIERNODE_H
#define IDENTIFIERNODE_H

#include "ExpressionNode.h"
#include <iostream>
#include <string>

class IdentifierNode : public ExpressionNode
{
private:
    std::string name;
    std::string type;

public:
    IdentifierNode(const std::string& n,
                   const std::string& t)
        : name(n), type(t)
    {
    }

    void print() override
    {
        std::cout << "Identifier: "
                  << name
                  << std::endl;
    }

    std::string getName() const
    {
        return name;
    }

    std::string getType() override
    {
        return type;
    }
    std::string getPlace() override
    {
    return name;
    }
};

#endif
