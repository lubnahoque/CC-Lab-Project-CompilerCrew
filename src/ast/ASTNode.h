#ifndef ASTNODE_H
#define ASTNODE_H

#include <iostream>

class ASTNode {
public:
    virtual void print() = 0;
    virtual ~ASTNode() {}
};

#endif
