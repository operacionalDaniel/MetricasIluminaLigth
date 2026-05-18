@echo off
chcp 65001 >nul
title Publicar Dashboard · Iluminação Pública

echo.
echo  ╔══════════════════════════════════════════════════════╗
echo  ║   DASHBOARD ILUMINAÇÃO PÚBLICA · Publicar no GitHub  ║
echo  ╚══════════════════════════════════════════════════════╝
echo.

:: ─────────────────────────────────────────────────────────
:: CONFIGURAÇÃO — edite apenas esta linha com o caminho da
:: pasta onde estão os arquivos do dashboard no seu PC
:: ─────────────────────────────────────────────────────────
set PASTA=C:\dashboard-iluminacao-publica

:: ─────────────────────────────────────────────────────────
cd /d "%PASTA%"
if errorlevel 1 (
    echo  [ERRO] Pasta nao encontrada: %PASTA%
    echo  Edite o arquivo .bat e corrija o caminho.
    pause & exit /b 1
)

echo  Pasta: %PASTA%
echo  Verificando alteracoes...
echo.

:: Verifica se ha algo para commitar
git status --short > tmp_status.txt 2>&1
for %%A in (tmp_status.txt) do set SIZE=%%~zA
del tmp_status.txt

if %SIZE%==0 (
    echo  Nenhuma alteracao encontrada.
    echo  Verifique se salvou a planilha antes de publicar.
    echo.
    pause & exit /b 0
)

:: Gera mensagem de commit com data e hora
for /f "tokens=1-3 delims=/" %%a in ("%date%") do (
    set DIA=%%a
    set MES=%%b
    set ANO=%%c
)
for /f "tokens=1-2 delims=:" %%a in ("%time%") do (
    set HORA=%%a
    set MIN=%%b
)
set MSG=Atualizacao %DIA%/%MES%/%ANO% %HORA%:%MIN%

echo  Arquivos modificados:
git status --short
echo.
echo  Mensagem do commit: "%MSG%"
echo.

set /p CONFIRM= Publicar agora? (S/N): 
if /i not "%CONFIRM%"=="S" (
    echo  Publicacao cancelada.
    pause & exit /b 0
)

echo.
echo  [1/3] Adicionando arquivos...
git add .

echo  [2/3] Salvando versao...
git commit -m "%MSG%"

echo  [3/3] Enviando para o GitHub...
git push origin main

if errorlevel 1 (
    echo.
    echo  [ERRO] Falha ao enviar. Verifique sua conexao ou credenciais.
    echo  Dica: abra o GitHub Desktop e tente publicar por la.
) else (
    echo.
    echo  ✓ Publicado com sucesso!
    echo  O dashboard ja esta atualizado em:
    echo.
    :: Lê o remote URL para exibir o link
    for /f "tokens=*" %%i in ('git remote get-url origin 2^>nul') do set REMOTE=%%i
    echo  %REMOTE%
    echo.
    echo  Aguarde ~1 minuto para o GitHub Pages atualizar.
)

echo.
pause
