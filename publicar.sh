#!/bin/bash
# ─────────────────────────────────────────────────────────────
# DASHBOARD ILUMINAÇÃO PÚBLICA · Publicar no GitHub
# Mac / Linux — execute com duplo clique ou no Terminal
# ─────────────────────────────────────────────────────────────

# ── CONFIGURAÇÃO ─────────────────────────────────────────────
# Edite apenas esta linha com o caminho da pasta no seu Mac/Linux
PASTA="$HOME/dashboard-iluminacao-publica"
# ─────────────────────────────────────────────────────────────

echo ""
echo "╔══════════════════════════════════════════════════════╗"
echo "║  DASHBOARD ILUMINAÇÃO PÚBLICA · Publicar no GitHub   ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""

# Verifica a pasta
if [ ! -d "$PASTA" ]; then
  echo "  [ERRO] Pasta não encontrada: $PASTA"
  echo "  Edite o arquivo publicar.sh e corrija o caminho."
  read -p "  Pressione Enter para fechar..." && exit 1
fi

cd "$PASTA"
echo "  Pasta: $PASTA"
echo "  Verificando alterações..."
echo ""

# Verifica se há alterações
STATUS=$(git status --short 2>&1)
if [ -z "$STATUS" ]; then
  echo "  Nenhuma alteração encontrada."
  echo "  Verifique se salvou a planilha antes de publicar."
  echo ""
  read -p "  Pressione Enter para fechar..." && exit 0
fi

# Mensagem de commit com data/hora
MSG="Atualização $(date '+%d/%m/%Y %H:%M')"

echo "  Arquivos modificados:"
echo "$STATUS" | sed 's/^/  /'
echo ""
echo "  Mensagem do commit: \"$MSG\""
echo ""

read -p "  Publicar agora? (s/N): " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Ss]$ ]]; then
  echo "  Publicação cancelada."
  read -p "  Pressione Enter para fechar..." && exit 0
fi

echo ""
echo "  [1/3] Adicionando arquivos..."
git add .

echo "  [2/3] Salvando versão..."
git commit -m "$MSG"

echo "  [3/3] Enviando para o GitHub..."
git push origin main

if [ $? -ne 0 ]; then
  echo ""
  echo "  [ERRO] Falha ao enviar. Verifique sua conexão ou credenciais."
else
  echo ""
  echo "  ✓ Publicado com sucesso!"
  REMOTE=$(git remote get-url origin 2>/dev/null)
  echo "  Repositório: $REMOTE"
  echo ""
  echo "  Aguarde ~1 minuto para o GitHub Pages atualizar."
fi

echo ""
read -p "  Pressione Enter para fechar..."
