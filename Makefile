CXX = g++
CXXFLAGS = -std=gnu++11 -Wall -Isrc/parser

# Target executable
TARGET = compiler.exe

# Sources
SRCS = src/main.cpp src/parser/parser.tab.cpp src/lexer/lex.yy.cpp
OBJS = $(SRCS:.cpp=.o)

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(OBJS)

src/parser/parser.tab.cpp src/parser/parser.tab.hpp: src/parser/parser.y
	bison -d -o src/parser/parser.tab.cpp src/parser/parser.y

src/lexer/lex.yy.cpp: src/lexer/lexer.l src/parser/parser.tab.hpp
	flex -o src/lexer/lex.yy.cpp src/lexer/lexer.l

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	-rm -f src/parser/parser.tab.cpp src/parser/parser.tab.hpp src/lexer/lex.yy.cpp src/main.o src/parser/parser.tab.o src/lexer/lex.yy.o $(TARGET)
	-del /q src\parser\parser.tab.cpp src\parser\parser.tab.hpp src\lexer\lex.yy.cpp src\main.o src\parser\parser.tab.o src\lexer\lex.yy.o $(TARGET) 2>nul

.PHONY: all clean
