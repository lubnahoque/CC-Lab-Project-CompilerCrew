#include <iostream>
#include <cstdio>

// Declare external flex/bison functions and variables
extern FILE* yyin;
extern int yyparse();

int main(int argc, char* argv[]) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <source_file>" << std::endl;
        return 1;
    }

    FILE* file = fopen(argv[1], "r");
    if (!file) {
        std::cerr << "Error: Could not open file " << argv[1] << std::endl;
        return 1;
    }

    // Set flex to read from the opened file
    yyin = file;

    std::cout << "Starting compilation of " << argv[1] << "..." << std::endl;
    int result = yyparse();
    fclose(file);

    if (result == 0) {
        std::cout << "Compilation/Parsing successful!" << std::endl;
    } else {
        std::cerr << "Compilation failed due to errors." << std::endl;
    }

    return result;
}
