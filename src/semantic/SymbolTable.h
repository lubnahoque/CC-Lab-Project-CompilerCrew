#ifndef SYMBOLTABLE_H
#define SYMBOLTABLE_H

#include <string>
#include <unordered_map>
#include <iostream>

class SymbolTable
{
private:
    std::unordered_map<std::string, std::string> table;

public:

    bool insert(const std::string& name, const std::string& type)
{
    if (exists(name))
    {
        return false;
    }

    table[name] = type;
    return true;
}

    bool exists(const std::string& name)
    {
        return table.find(name) != table.end();
    }

    std::string getType(const std::string& name)
    {
        if (exists(name))
            return table[name];

        return "";
    }

    void print()
    {
        std::cout << "\n===== Symbol Table =====" << std::endl;

        for (const auto& entry : table)
        {
            std::cout << entry.first
                      << " : "
                      << entry.second
                      << std::endl;
        }

        std::cout << "========================" << std::endl;
    }
};

#endif
