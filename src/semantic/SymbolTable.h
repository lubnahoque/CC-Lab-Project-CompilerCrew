#ifndef SYMBOLTABLE_H
#define SYMBOLTABLE_H

#include <string>
#include <unordered_map>
#include <vector>
#include <iostream>

class SymbolTable
{
private:
    std::vector<std::unordered_map<std::string, std::string>> scopes;

public:
SymbolTable()
{
    scopes.push_back(std::unordered_map<std::string, std::string>());
}
    bool insert(const std::string& name, const std::string& type)
{
    if (scopes.back().find(name) != scopes.back().end())
    {
        return false;
    }

    scopes.back()[name] = type;
    return true;
}

    bool exists(const std::string& name)
{
    for (int i = scopes.size() - 1; i >= 0; i--)
    {
        if (scopes[i].find(name) != scopes[i].end())
        {
            return true;
        }
    }

    return false;
}

    std::string getType(const std::string& name)
{
    for (int i = scopes.size() - 1; i >= 0; i--)
    {
        auto it = scopes[i].find(name);

        if (it != scopes[i].end())
        {
            return it->second;
        }
    }

    return "";
}

    void print()
{
    std::cout << "\n===== Symbol Table =====" << std::endl;

    for (int i = 0; i < scopes.size(); i++)
    {
        std::cout << "Scope " << i << ":" << std::endl;

        for (const auto& entry : scopes[i])
        {
            std::cout << "  "
                      << entry.first
                      << " : "
                      << entry.second
                      << std::endl;
        }
    }

    std::cout << "========================" << std::endl;
}

void enterScope()
{
    scopes.push_back(std::unordered_map<std::string, std::string>());
}

void exitScope()
{
    if (scopes.size() > 1)
    {
        scopes.pop_back();
    }
}

};

#endif
