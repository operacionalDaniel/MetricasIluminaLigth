# 💡 IluminaBoard · Dashboard Iluminação Pública · Içara/SC

> **Versão: Tema Claro (Light)**

Sistema de gestão visual para contratos de iluminação pública — **2 dashboards integrados** publicados via GitHub Pages.

🔗 **Acesse:** `https://<seu-usuario>.github.io/IluminaBoard/`

---

## 📊 Dashboards disponíveis

| Dashboard | Arquivo | Conteúdo |
|---|---|---|
| **Menu Central** | `index.html` | Página inicial com acesso aos dois painéis |
| **SLAs Contratuais** | `dashboard_sla.html` | CME, IE e 5 indicadores de qualidade + evolução anual |
| **Operacional** | `dashboard_operacional.html` | OS, origens, materiais, prazos, manutenções, bairros |

---

## 🗂 Estrutura de arquivos

```
IluminaBoard/
│
├── index.html                        ← Menu central (página inicial)
├── dashboard_sla.html                ← Dashboard SLAs Contratuais
├── dashboard_operacional.html        ← Dashboard Operacional
│
├── dados.json                        ← Dados SLA (gerado automaticamente)
├── dados_operacional.json            ← Dados Operacional (gerado automaticamente)
│
├── template_dashboard_ip_2026.xlsx   ← Template Excel para SLA
│
├── gerar_dados.py                    ← Converte planilha SLA → dados.json
├── gerar_dados.bat                   ← Atalho Windows para gerar_dados.py
│
├── processar_operacional.py          ← Processa planilhas operacionais → dados_operacional.json
├── processar_operacional.bat         ← Atalho Windows para processar_operacional.py
│
├── publicar.bat                      ← Publica atualizações no GitHub (Windows)
├── publicar.sh                       ← Publica atualizações no GitHub (Mac/Linux)
│
└── .nojekyll                         ← Necessário para GitHub Pages
```

---

## 🚀 Como publicar no GitHub Pages

### 1. Criar repositório
1. Acesse [github.com](https://github.com) → **New repository**
2. Nome: `IluminaBoard` · Visibilidade: **Public**
3. Clique em **Create repository**

### 2. Upload dos arquivos
1. Na página do repositório → **"uploading an existing file"**
2. Arraste **todos os arquivos** desta pasta (incluindo `.nojekyll`)
3. Clique em **Commit changes**

### 3. Ativar GitHub Pages
1. **Settings → Pages**
2. Source: `Deploy from a branch` → Branch: `main` → `/root`
3. **Save** → aguarde ~2 minutos

### 4. Acessar
```
https://<seu-usuario>.github.io/IluminaBoard/
```

---

## 📋 Fluxo mensal — Dashboard SLA

```
1. Abra template_dashboard_ip_2026.xlsx
2. Preencha a linha do mês (campos azuis)
3. Salve na pasta IluminaBoard
4. Execute: gerar_dados.bat   (Windows)
           ou publicar.bat
✓ Dashboard SLA atualizado em ~1 minuto
```

**Fontes de dados SLA por indicador:**

| SLA | Dado | Fonte |
|---|---|---|
| SLA 1 | Nf, Ni, Pt | Sistema de Telegerenciamento |
| SLA 2 | NCEi, NCEa | Sistema de OS / Call Center |
| SLA 3 | NCNEi, NCNEa | Sistema de OS |
| SLA 4 | Dm, Ti (min) | Log do Gerenciamento Remoto |
| SLA 5 | % Ótimo/Bom/Regular/Ruim | Exati (pesquisa de satisfação) |

---

## ⚙️ Fluxo mensal — Dashboard Operacional

**Opção A — Importação pelo browser (manual):**
```
1. Acesse o dashboard_operacional.html
2. Clique "⬆ Nova importação"
3. Arraste as planilhas exportadas do sistema:
   · Ocorrências (obrigatório) — exportação completa
   · Materiais (opcional) — materiais aplicados dia a dia
   · Prazos (opcional) — relatório de atendimentos por prazo
4. Clique "▶ Gerar Dashboard"
✓ Processado no browser, sem servidor
```

**Opção B — Script automático (publica para todos):**
```
1. Renomeie as planilhas exportadas para:
   · ocorrencias.xlsx
   · materiais.xlsx
   · prazos.xlsx
2. Coloque na pasta IluminaBoard
3. Execute: processar_operacional.bat
✓ Gera dados_operacional.json e publica no GitHub
✓ Todos que acessarem o link já veem os dados novos
```

---

## 📡 Origens das ocorrências mapeadas

| Código | Canal | Mapeamento |
|---|---|---|
| `origem_ronda` | Ronda própria | Detecção proativa pela equipe |
| `origem_callcenter` | Call Center | Reclamação por telefone |
| `origem_chatbot` | Chatbot | Atendimento digital automatizado |
| `origem_app` | App | Solicitação via aplicativo móvel |
| `origem_telegestao` | Tele Gestão | Detecção pelo sistema de telegerenciamento |

---

## ⚠️ Observações importantes

- O arquivo `.nojekyll` é **obrigatório** no GitHub Pages — sem ele arquivos com `_` no nome não funcionam
- Os dados ficam em `dados.json` (SLA) e `dados_operacional.json` (Operacional)
- Ambos os dashboards carregam automaticamente seus JSONs ao abrir
- Múltiplos meses podem ser importados — use a barra de meses para navegar
- Todos os cálculos (SLA, IE, CME, prazos) são feitos no browser

---

*Sistema desenvolvido para gestão de contratos de iluminação pública · Içara/SC · 2026*
