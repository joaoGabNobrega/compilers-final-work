# Interpretador C - Projeto de Análise e Execução de Código

Este projeto implementa um **interpretador** para a linguagem C, capaz de analisar e executar código escrito em C usando **ANTLR4** e **Python**. A ferramenta processa arquivos `.c`, interpreta suas estruturas e executa comandos diretamente.

---

## 📌 Funcionalidades
- **Suporte à sintaxe básica da linguagem C**
  - Declaração de variáveis, funções, estruturas (`struct`), uniões (`union`)
  - Controle de fluxo (`if`, `while`, `do-while`, `for`, `switch`)
  - Entrada e saída (`printf`, `scanf`, `gets`, `puts`)
  - Expressões aritméticas e lógicas

- **Análise de código com ANTLR4**
  - 🔍 Reconhece tokens da linguagem C
  - 🔍 Implementa um **Visitor Pattern** para visitar e interpretar a AST (Abstract Syntax Tree)

- **Execução de código interpretado**
  - ⚡ Simula a execução do código em tempo real sem necessidade de compilação

---

## 🛠️ Tecnologias Utilizadas
- **ANTLR4** → Para a criação do analisador léxico e sintático  
- **Python 3.11** → Para implementação da lógica do interpretador  
- **Biblioteca ANTLR4-Python3-runtime** → Para executar a gramática  
- **Arquitetura baseada em AST (Abstract Syntax Tree)**  

---

## 📂 Estrutura do Projeto
```
projeto-interpretador-c
│── grammar                 # Arquivos da gramática ANTLR
│   │── C.g4                # Definição da gramática C
│   │── CParser.py          # Gerado pelo ANTLR (Parser)
│   │── CLexer.py           # Gerado pelo ANTLR (Lexer)
│   │── CVisitor.py         # Gerado pelo ANTLR (Visitor)
│
│── src                     # Código-fonte principal do interpretador
│   │── main.py             # Arquivo principal que executa o interpretador
│   │── interpretador.py     # Implementação do visitor para interpretação
│   │── tabela_simbolos.py   # Gerenciamento de variáveis, structs e unions
│
│── testes                   # Testes e exemplos de código C
│   │── teste1.c
│   │── teste2.c           # Código C usado para teste
│
│── README.md               # Documentação do projeto
│── requirements.txt        # Dependências do projeto
```

---

## 🚀 Como Executar o Interpretador

### 1️⃣ Instalar as Dependências
Antes de rodar o interpretador, é necessário instalar o **ANTLR4** e as bibliotecas Python necessárias.

```bash
pip install -r requirements.txt
```

Caso ainda não tenha o **ANTLR4**, instale manualmente:

```bash
pip install antlr4-python3-runtime
```

### 2️⃣ Gerar os arquivos da gramática
Caso precise gerar novamente os arquivos de análise léxica e sintática:

```bash
java -jar antlr-4.13.2-complete.jar -Dlanguage=Python3 -visitor -listener grammar/C.g4
```

### 3️⃣ Executar o Interpretador
Para rodar o interpretador em um arquivo C:

```bash
python src/main.py testes/teste1.c
```

O interpretador irá processar o código e exibir os resultados na saída do terminal.

---

## 📝 Exemplo de Código C para Teste
Este código pode ser salvo como `testes/teste2.c` e executado pelo interpretador:

```c
#include <stdio.h>

struct Usuario {
    int idade;
    char inicial;
};

union Registro {
    int inteiro;
    float decimal;
};

int somar(int a, int b) {
    return a + b;
}

int main() {
    struct Usuario u;
    u.idade = 25;
    u.inicial = 'A';

    printf("Idade: %d, Inicial: %c\n", u.idade, u.inicial);

    int resultado = somar(10, 20);
    printf("Soma: %d\n", resultado);

    return 0;
}
```



## 📚 Licença
Este projeto é **open-source** e pode ser utilizado livremente para fins educacionais e acadêmicos. ⚡

