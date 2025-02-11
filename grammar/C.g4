grammar C;

// Definição de programa principal: pode ter várias diretrizes, funções, structs, unions ou instruções
program : (directive | functionDef | structDef | unionDef | statement)* EOF ;

// Diretrizes de pré-processador
directive 
    : '#include' IncludeFile        // Incluir arquivos de cabeçalho
    | '#define' Identifier expression  // Definir macros
    ;

// Definição do caminho do arquivo para incluir, que pode ser entre < > ou " "
IncludeFile
    : '<' ~[<>]+ '>'        // Para arquivos com nome entre < e >
    ;

// Definição de função com tipo de retorno e parâmetros
functionDef 
    : type Identifier '(' paramList? ')' block
    ;

// Definição de estrutura com campos
structDef 
    : 'struct' Identifier '{' varDecl* '}' ';'   // Estruturas com declaração de variáveis
    ;

// Definição de união com campos
unionDef 
    : 'union' Identifier '{' varDecl* '}' ';'    // União com declaração de variáveis
    ;

// Declaração de instruções válidas no código (variáveis, atribuições, if, while, etc.)
statement 
    : varDecl
    | assignment
    | ifStatement
    | whileStatement
    | doWhileStatement
    | forStatement
    | switchStatement
    | functionCall ';'
    | inputOutputStatement ';'
    | ';'
    | block
    | breakStatement  
    | 'return' expression? ';'  // Instrução de retorno opcionalmente com valor
    ;

// Instrução de retorno, com ou sem expressão
returnStatement 
    : 'return' expression? ';'
    ;

// Bloco de código que agrupa instruções entre chaves
block 
    : '{' statement* '}'
    ;

// Declaração de variáveis, podendo ser arrays com tamanho definido
varDecl 
    : type Identifier arraySize? ('=' init)? ';'  // Variáveis simples ou arrays
    ;

// Tamanho de arrays definido por números
arraySize
    : '[' (Number)? ']'
    ;

// Inicialização das variáveis, pode ser uma expressão ou uma lista de inicializadores
init 
    : expression
    | initializerList
    ;

// Inicializadores compostos
initializerList 
    : '{' expression (',' expression)* '}'
    ;

// Atribuição de valores para variáveis
assignment 
    : (Identifier ('.' Identifier)*) '=' expression ';'      // Atribuição simples ou de campo
    | Identifier '[' expression ']' '=' expression ';'       // Atribuição em array
    ;

// Instrução de condição if, com ou sem else
ifStatement 
    : 'if' '(' expression ')' statement ('else' statement)?
    ;

// Laço while
whileStatement 
    : 'while' '(' expression ')' statement
    ;

// Laço do-while
doWhileStatement 
    : 'do' statement 'while' '(' expression ')' ';'
    ;

// Atribuição no cabeçalho de um laço for
forHeaderAssignment
    : Identifier '=' expression
    ;

// Laço for com expressão no cabeçalho
forStatement 
    : 'for' '(' (varDecl | forHeaderAssignment)? ';' expression? ';' forHeaderAssignment? ')' statement
    ;

// Comando switch-case para selecionar entre várias opções
switchStatement 
    : 'switch' '(' expression ')' '{' (caseBlock | defaultBlock)* '}'
    ;

// Comando de quebra, geralmente dentro de um laço ou switch
breakStatement
    : 'break' ';'
    ;

// Definição de um case dentro de switch
caseLabel 
    : 'case' expression ':' 
    ;

// Definição do bloco default em switch
defaultLabel 
    : 'default' ':' 
    ;

// Bloco de um case
caseBlock
    : caseLabel statement* breakStatement?
    ;

// Bloco de default em switch
defaultBlock
    : defaultLabel statement* breakStatement?
    ;

// Chamada de funções dentro do código
functionCall 
    : Identifier '(' argumentList? ')'
    ;

// Definição dos parâmetros para leitura no scanf, podendo ser um índice de array
scanfParam
    : Identifier ('[' expression ']')?
    ;

// Declaração de comandos de entrada e saída como printf, scanf, gets e puts
inputOutputStatement 
    : 'printf' '(' StringLiteral (',' expression)* ')'       // Função para imprimir
    | 'scanf' '(' StringLiteral (',' '&' scanfParam)* ')'    // Função para ler entrada
    | 'gets' '(' Identifier ')'                             // Função para ler uma string
    | 'puts' '(' (StringLiteral | expression) ')'            // Função para imprimir string ou expressão
    ;

// Definição das expressões válidas em C, com operações binárias, unárias e chamadas de função
expression 
    : '(' expression ')'
    | '-' expression
    | expression ('*' | '/' | '%') expression
    | expression ('+' | '-') expression
    | expression ('<' | '<=' | '>' | '>=') expression
    | expression ('==' | '!=') expression
    | expression ('&&' | '||') expression
    | Identifier
    | Identifier ('=' expression)   // <-- ADICIONE ISSO PARA SUPORTAR `x = x + 1;`
    | Number
    | StringLiteral
    | CharLiteral
    | expression '.' Identifier
    | Identifier ('[' expression ']')*
    | functionCall
    ;


// Lista de argumentos para funções
argumentList 
    : expression (',' expression)*
    ;

// Lista de parâmetros para funções
paramList 
    : type Identifier (',' type Identifier)*
    ;

// Tipos de variáveis possíveis em C
type 
    : 'int'
    | 'float'
    | 'double'
    | 'long double'
    | 'char'
    | 'short'
    | 'long'
    | 'unsigned'
    | 'unsigned char'
    | 'unsigned int'
    | 'unsigned short'
    | 'unsigned long'
    | 'long long'
    | 'unsigned long long'
    | 'struct' Identifier
    | 'union' Identifier
    | 'void'
    ;

// Tokens para valores numéricos, literais de caracteres e strings
Number 
    : [0-9]+ ('.' [0-9]+)?
    ;

CharLiteral
    : '\'' ~[\r\n'] '\''    // Definição de um único caractere
    ;

StringLiteral
    : '"' (ESCAPED_CHAR | ~["\\])* '"'
    | '"' (~["\\] | '\\' .)* '"'
    ;

fragment ESCAPED_CHAR
    : '\\' ["\\/bfnrt]   // Escapes básicos
    | '\\u' HEX HEX HEX HEX // Unicode
    ;

fragment HEX
    : [0-9a-fA-F]
    ;

Identifier 
    : [a-zA-Z_] [a-zA-Z0-9_]*    // Definição de identificadores válidos
    ;

// Espaços em branco e comentários
WS 
    : [ \t\r\n]+ -> skip   // Ignora espaços, tabs e novas linhas
    ;

COMMENT 
    : '//' ~[\r\n]* -> skip  // Comentários de uma linha
    ;

MULTILINE_COMMENT 
    : '/*' .*? '*/' -> skip   // Comentários multi-linhas
    ;
