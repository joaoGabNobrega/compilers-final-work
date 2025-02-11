@echo off
REM ==============================
REM GERADOR DE GRAMÁTICA ATUALIZADO
REM ==============================
REM Este script remove arquivos antigos antes de gerar uma nova versão da gramática.
REM Atualização: Comentário adicionado para indicar a correção da gramática.
REM ==============================

REM Diretório da gramática
set GRAMMAR_DIR=%CD%
set ANTLR_JAR="D:\ANTLR4\antlr-4.13.2-complete.jar"

REM Remove arquivos antigos da gramática, se existirem
echo Limpando arquivos antigos da gramática...
if exist CParser.py del CParser.py
if exist CVisitor.py del CVisitor.py
if exist CLexer.py del CLexer.py

REM Gera os novos arquivos da gramática
echo Gerando nova gramática...
java -jar %ANTLR_JAR% -Dlanguage=Python3 -listener -visitor C.g4

echo Processo concluído com sucesso!
pause
