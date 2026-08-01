# Mini Programming Language Compiler

## Compiler Construction Laboratory Project

Department of Computer Science and Engineering  
Metropolitan University, Bangladesh

---

## Team Information

**Team Name:** Compiler Crew

| Role | Name |
|------|------|
| Team Leader | Lubna |
| Member 2 | Maisha Rahman |
| Member 3 | Dahala Hoque |

---

# Project Description

This project implements a Mini Programming Language Compiler using Flex and Bison. The compiler performs lexical analysis, syntax analysis, semantic analysis, Abstract Syntax Tree (AST) generation, Symbol Table management, and Three Address Code (TAC) generation.

The compiler supports variable declarations, arithmetic expressions, relational expressions, logical expressions, assignment statements, conditional statements, loops, and print statements while detecting lexical, syntax, and semantic errors.

---

# Features

Implemented compiler phases:

- Lexical Analysis
- Syntax Analysis
- Abstract Syntax Tree (AST)
- Symbol Table
- Semantic Analysis
- Three Address Code (TAC)

Supported language features:

- int
- float
- bool
- Variable declaration
- Assignment statements
- Arithmetic operators
- Relational operators
- Logical operators
- if
- if-else
- while
- print

Error detection:

- Lexical errors
- Syntax errors
- Undeclared variables
- Redeclaration
- Scope violations
- Type mismatch
- Invalid assignments

---

# Project Structure

```
CC-Lab-Project-CompilerCrew/

├── docs/
│
├── examples/
│   ├── valid/
│   └── invalid/
│
├── tests/
│   ├── valid/
│   └── invalid/
│
├── src/
│   ├── lexer/
│   ├── parser/
│   ├── ast/
│   ├── semantic/
│   └── tac/
│
├── README.md
├── Makefile
└── compiler.exe
```

---

# Requirements

- Ubuntu Linux
- Flex
- Bison
- g++
- make
- Git

---

# Build Instructions

Compile the project using:

```bash
make
```

---

# Run Instructions

Execute the compiler:

```bash
./compiler.exe <source_file>
```

Example:

```bash
./compiler.exe test_run.txt
```

---

# Test Programs

The repository contains sample programs inside:

```
tests/
```

- tests/valid/
- tests/invalid/

These test programs verify lexical analysis, syntax analysis, semantic analysis, and TAC generation.

---

# Example Programs

Example programs are provided inside:

```
examples/
```

- examples/valid/
- examples/invalid/

---

# Technologies Used

- Flex
- Bison
- C++
- GNU Make
- Git
- GitHub
- Ubuntu Linux

---

# AI Usage

AI tools such as ChatGPT were used only as learning and development assistants. Every team member understands the submitted implementation and can explain the compiler during the demonstration and viva.

---

# Repository

GitHub Repository:

https://github.com/lubnahoque/CC-Lab-Project-CompilerCrew

---

# Acknowledgement

This project was developed as part of the Compiler Construction Laboratory course at Metropolitan University, Bangladesh.
