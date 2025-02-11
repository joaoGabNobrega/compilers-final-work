import sys
import os

# Adiciona o diretório "../gramatica" ao caminho de módulos
current_dir = os.path.dirname(__file__)
grammar_dir = os.path.abspath(os.path.join(current_dir, "../grammar"))
sys.path.append(grammar_dir)

from CLexer import CLexer
from CParser import CParser
from antlr4 import FileStream, CommonTokenStream
from interpretador import Interpretador, ReturnException

def main_exists(parse_tree):
    """
    Verifica se a árvore de análise sintática contém a definição da função main.
    Retorna True se encontrar, caso contrário, False.
    """
    for idx in range(parse_tree.getChildCount()):
        node = parse_tree.getChild(idx)
        if node.__class__.__name__ == "FunctionDefContext":
            # O primeiro filho é o tipo de retorno e o segundo é o nome da função.
            func_type = node.getChild(0).getText()
            func_name = node.getChild(1).getText()
            if func_name == "main":
                return True
    return False

def main(argv):
    # Verifica se o usuário informou o arquivo-fonte como argumento
    if len(argv) < 2:
        print("Uso: python main.py <arquivo_fonte.c>")
        return

    source_file = argv[1]
    input_stream = FileStream(source_file, encoding='utf-8')

    # Cria o lexer, o token stream e o parser para gerar a árvore sintática
    lexer = CLexer(input_stream)
    tokens = CommonTokenStream(lexer)
    parser = CParser(tokens)
    tree = parser.program()

    # Opção para exibir a árvore sintática (descomente para depurar)
    # print("\n=== Árvore Sintática ===")
    # print(tree.toStringTree(recog=parser))

    if not main_exists(tree):
        print("Erro: O código não define a função main(). Execução abortada.")
        return

    # Instancia o interpretador e registra todas as definições encontradas na árvore
    interpreter = Interpretador()
    interpreter.visit(tree)

    if "main" in interpreter.funcoes:
        print("Executando a função main:")
        main_context = interpreter.funcoes["main"]
        try:
            interpreter.visit(main_context.block())
        except ReturnException:
            pass
    else:
        print("Erro: Função main() não encontrada.")

    # Opção para exibir a tabela de símbolos (descomente se necessário)
    # print("\nTabela de Símbolos:")
    # for var, props in interpreter.tabela_simbolos.variaveis.items():
    #     print(f"{var}: {props}")

if __name__ == "__main__":
    main(sys.argv)
