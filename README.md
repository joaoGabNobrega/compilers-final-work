# Mini C Compiler

## 1. Descrição do Projeto
Este projeto é um compilador desenvolvido para um subconjunto simplificado da linguagem C, como parte da disciplina de **Compiladores**. O objetivo é entender e demonstrar as etapas de compilação de maneira prática, desde a análise léxica até a geração de código executável ou interpretação direta.

## 2. Ferramentas Utilizadas
- **Linguagem de Programação:** Python
- **Analisador Léxico e Sintático:** [PLY (Python Lex-Yacc)](https://www.dabeaz.com/ply/)
- **Controle de Versão:** Git e GitHub

## 3. Grámatica

program        : declaration_list
declaration_list : declaration declaration_list | ε
declaration    : var_declaration | fun_declaration
var_declaration : type_specifier ID ';' | type_specifier ID '=' literal ';'
fun_declaration : type_specifier ID '(' params ')' compound_stmt
type_specifier : 'int' | 'float' | 'char'
params         : param_list | 'void'
param_list     : param ',' param_list | param
param          : type_specifier ID
compound_stmt  : '{' local_declarations statement_list '}'
local_declarations : var_declaration local_declarations | ε
statement_list : statement statement_list | ε
statement      : expression_stmt | compound_stmt | selection_stmt
expression_stmt : expression ';' | ';'
selection_stmt : 'if' '(' expression ')' statement
expression     : ID '=' expression | simple_expression
simple_expression : additive_expression relop additive_expression
relop          : '==' | '!=' | '<' | '>'
additive_expression : additive_expression addop term | term
addop          : '+' | '-'
term           : term mulop factor | factor
mulop          : '*' | '/'
factor         : '(' expression ')' | ID | literal
literal        : NUM | CHAR

## 4. Tokens (RegEx)

ID    : [a-zA-Z_][a-zA-Z0-9_]*
NUM   : [0-9]+(\.[0-9]+)?
CHAR  : '[a-zA-Z]'
PLUS  : '\+'
MINUS : '-'
MUL   : '\*'
DIV   : '/'
EQ    : '=='
NEQ   : '!='
LT    : '<'
GT    : '>'
LPAREN: '\('
RPAREN: '\)'
LBRACE: '\{'
RBRACE: '\}'
SEMI  : ';'
COMMA : ','
ASSIGN: '='



