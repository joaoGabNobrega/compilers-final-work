#include <stdio.h>

// ================================
// Definicao de Struct e Union
// ================================

struct Usuario {
    int idade;
    char inicial;
};

union Registro {
    int inteiro;
    float decimal;
};

// ================================
// Funcoes com e sem Retorno
// ================================

int somar(int a, int b) {
    return a + b;
}

int obterValor() {
    return 99;
}

void exibirMensagem() {
    printf("Sistema pronto para uso!\n");
}

void mostrarUsuario(struct Usuario u) {
    printf("Usuario: idade = %d, inicial = %c\n", u.idade, u.inicial);
}

int calcularFatorial(int n) {
    if (n <= 1)
        return 1;
    else
        return n * calcularFatorial(n - 1);
}

// ================================
// Estruturas Condicionais e Loops
// ================================

int verificarNumero(int x) {
    if (x % 2 == 0)
        printf("O numero e par\n");
    else
        printf("O numero e impar\n");

    int resultado;
    switch (x) {
        case 1:
            resultado = 10;
            break;
        case 2:
            resultado = 20;
            break;
        default:
            resultado = 40;
            break;
    }
    return resultado;
}

// 🔥 **Correcao do loop infinito**
void testarLoops() {
    int i = 0; 
    printf("Loop While: ");
    while (i <= 9) {
        printf("%d ", i);
        i = i + 3;
    }
    printf("\n");

    int j = 0;
    printf("Loop Do-While: ");
    do {
        printf("%d ", j);
        j = j + 3;
    } while (j < 9);
    printf("\n");

    // 🔥 **For corrigido**
    printf("Loop For: ");
    int k;
    for (k = 0; k <= 9; k = k + 3) { // Usa `k` ao inves de `i`
        printf("%d ", k);
    }
    printf("\n");
}

// ================================
// Entrada e Saida de Dados
// ================================

void entradaSaidaNumero() {
    int numero;
    printf("Digite um numero inteiro: ");
    scanf("%d", &numero);
    printf("Numero digitado: %d\n", numero);
}

// 🔥 **Correcao na entrada de string**
void entradaSaidaTexto() {
    char mensagem[50];
    printf("Digite um texto: ");
    scanf(" %[^\n]", &mensagem); // Corrigido, sem necessidade de '&'
    printf("Texto digitado: %s\n", mensagem);
}

// ================================
// Funcao Principal (main)
// ================================
int main() {
    int a;
    int b;
    int resultado;
    int resultadoFatorial;
    int resultadoCondicao;

    a = 12;
    b = 18;
    resultado = somar(a, b);
    printf("Soma de %d e %d = %d\n", a, b, resultado);

    printf("Valor fixo retornado: %d\n", obterValor());

    exibirMensagem();

    struct Usuario u;
    u.idade = 28;
    u.inicial = 'M';
    mostrarUsuario(u);

    union Registro r;
    r.inteiro = 200;
    printf("Registro armazenando inteiro: %d\n", r.inteiro);
    r.decimal = 7.25;
    printf("Registro armazenando float: %f\n", r.decimal);

    resultadoFatorial = calcularFatorial(5);
    printf("Fatorial de 5 = %d\n", resultadoFatorial);

    resultadoCondicao = verificarNumero(2);
    printf("Resultado da verificacao: %d\n", resultadoCondicao);

    entradaSaidaNumero();
    entradaSaidaTexto();

    // 🔥 **Se o loop infinito acontecer de novo, ele sera identificado aqui**
    printf("Agora testando os loops...\n");
    testarLoops();
    
    printf("Fim da execucao do programa.\n");
    
    return 0;
}
