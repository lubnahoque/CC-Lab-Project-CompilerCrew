#include "TACGenerator.h"

std::string TACGenerator::newTemp()
{
    return "t" + std::to_string(++tempCount);
}

std::string TACGenerator::newLabel()
{
    return "L" + std::to_string(++labelCount);
}

void TACGenerator::emit(const std::string& instruction)
{
    code.push_back(instruction);
}

void TACGenerator::print()
{
    std::cout << "\n===== Three Address Code =====" << std::endl;

    for (const auto& line : code)
    {
        std::cout << line << std::endl;
    }

    std::cout << "==============================" << std::endl;
}

std::vector<std::string>& TACGenerator::getCode()
{
    return code;
}
