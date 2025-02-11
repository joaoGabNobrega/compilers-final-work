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