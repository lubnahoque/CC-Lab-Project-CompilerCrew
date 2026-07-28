#ifndef EXPRESSIONNODE_H
#define EXPRESSIONNODE_H

#include "ASTNode.h"
#include <string>

class ExpressionNode : public ASTNode
{
public:
    virtual std::string getType() = 0;

    virtual ~ExpressionNode() {}
};

#endif
