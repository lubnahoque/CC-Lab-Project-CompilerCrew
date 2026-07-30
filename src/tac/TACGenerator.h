#ifndef TACGENERATOR_H
#define TACGENERATOR_H

#include <iostream>
#include <string>
#include <vector>

class TACGenerator
{
private:
    std::vector<std::string> code;
    int tempCount;
    int labelCount;

public:
    TACGenerator();

    std::string newTemp();
    std::string newLabel();

    void emit(const std::string& instruction);

    void print();

    std::vector<std::string>& getCode();
};

#endif
