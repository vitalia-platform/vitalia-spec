#!/usr/bin/env bash
# Script de Instalação do Kit de Agentes
# Inicializa o kit no diretório alvo através de symlinks e prepara o controle de sessão.

set -e

# Resolver o caminho real do script (seguindo symlinks) para obter o KIT_DIR correto
SCRIPT_REAL=$(python3 -c "import os,sys; print(os.path.realpath('${BASH_SOURCE[0]}'))" 2>/dev/null || realpath "${BASH_SOURCE[0]}" 2>/dev/null || echo "${BASH_SOURCE[0]}")
KIT_DIR="$(cd "$(dirname "$SCRIPT_REAL")/.." >/dev/null 2>&1 && pwd)"
TARGET_DIR="${PWD}"

AGENT_DIR="${TARGET_DIR}/.specify"
SESSION_DIR="${AGENT_DIR}/memory/session"

echo "🚀 Iniciando instalação do Kit de Agentes no projeto: $(basename "${TARGET_DIR}")"

# Verifica se a pasta .specify já existe
if [ -d "$AGENT_DIR" ]; then
    echo "⚠️ Diretório .specify já existe. Atualizando symlinks e configurações..."
fi

# Criação da estrutura e symlinks
echo "📦 Criando infraestrutura .specify..."
mkdir -p "$AGENT_DIR"

for item in instructions rules extensions templates scripts; do
    if [ -d "$KIT_DIR/$item" ]; then
        # Remove symlink/pasta antiga se existir para forçar recriação
        rm -rf "$AGENT_DIR/$item"
        ln -s "$KIT_DIR/$item" "$AGENT_DIR/$item"
        echo "   🔗 Symlink atualizado: $item -> $KIT_DIR/$item"
    fi
done

# Instalação do Plugin AGY (Antigravity)
AGY_PLUGINS_DIR="${HOME}/.gemini/config/plugins"
VITALIA_PLUGIN_DIR="${AGY_PLUGINS_DIR}/vitalia"
INTEGRATION_DIR="${KIT_DIR}/integrations/agy"

if [ -d "$INTEGRATION_DIR" ]; then
    echo "🤖 Instalando plugin Vitalia no Antigravity (AGY)..."
    mkdir -p "$AGY_PLUGINS_DIR"
    # Remove instalação anterior e recria via symlink
    rm -rf "$VITALIA_PLUGIN_DIR"
    ln -s "$INTEGRATION_DIR" "$VITALIA_PLUGIN_DIR"
    echo "   🔗 Plugin vinculado: $VITALIA_PLUGIN_DIR -> $INTEGRATION_DIR"
    echo "   ✅ Skills disponíveis no AGY:"
    for skill_dir in "$INTEGRATION_DIR/skills"/*/; do
        skill_name=$(basename "$skill_dir")
        echo "      • $skill_name"
    done
else
    echo "   ⚠️  Diretório de integração AGY não encontrado em $INTEGRATION_DIR. Pulando."
fi

# Configuração do Contexto Desconectado (Nested Git)
echo "📂 Configurando repositório de sessão isolado..."

if [ ! -d "$SESSION_DIR/.git" ]; then
    echo "❓ Deseja conectar a um repositório de contexto existente no GitHub? (s/N)"
    echo "   (Informe 's' mesmo que o repositório esteja vazio — ele será inicializado automaticamente)"
    read -p "> " choice
    if [ "$choice" == "s" ] || [ "$choice" == "S" ]; then
        read -p "URL do repositório (git@github.com:...): " repo_url
        if [ -n "$repo_url" ]; then
            # NÃO cria a pasta antes: o git clone precisa que o destino não exista
            rm -rf "$SESSION_DIR"
            echo "   ⬇️  Clonando repositório de contexto..."
            if git clone "$repo_url" "$SESSION_DIR"; then
                echo "   ✅ Repositório clonado."
                # Verifica se o repo está vazio (sem commits)
                if ! git -C "$SESSION_DIR" rev-parse HEAD &>/dev/null; then
                    echo "   📄 Repositório vazio detectado. Criando estrutura inicial..."
                    cd "$SESSION_DIR"
                    git checkout -b main 2>/dev/null || git checkout main 2>/dev/null || true
                    echo "<!-- INSTRUÇÃO: Leia a constituição em kit-v2/rules/always-on/architect-constitution.md antes de prosseguir. -->" > CONTEXT.md
                    echo "<!-- .specify/memory/session/CONTEXT.md | Atualizado em: \$(date '+%d-%m-%Y %H:%M:%S') -->" >> CONTEXT.md
                    echo "# Contexto de Sessão" >> CONTEXT.md
                    echo "Estado atual da revisão integrativa, gerenciado pelo agente de IA." >> CONTEXT.md
                    echo "" >> CONTEXT.md
                    echo "_Gerado automaticamente em \$(date '+%Y-%m-%d')._ " >> CONTEXT.md
                    echo "" > SESSION_HISTORY.md
                    git add .
                    git commit -m "chore: initial session context structure"
                    git push -u origin main || echo "   ⚠️  Push falhou — verifique permissões SSH. Contexto salvo localmente."
                    cd "$TARGET_DIR"
                fi
            else
                echo "   ❌ Falha ao clonar. Verifique a URL e suas chaves SSH."
                echo "   ℹ️  Inicializando repositório de sessão localmente (sem sincronização remota)."
                mkdir -p "$SESSION_DIR"
                cd "$SESSION_DIR"
                git init > /dev/null
                git checkout -b main 2>/dev/null || true
                echo "<!-- INSTRUÇÃO: Leia a constituição em kit-v2/rules/always-on/architect-constitution.md antes de prosseguir. -->" > CONTEXT.md
                echo "<!-- .specify/memory/session/CONTEXT.md | Atualizado em: \$(date '+%d-%m-%Y %H:%M:%S') -->" >> CONTEXT.md
                echo "# Contexto de Sessão" >> CONTEXT.md
                git add . > /dev/null
                git commit -m "chore: local session fallback" > /dev/null
                cd "$TARGET_DIR"
            fi
        else
            echo "   ⚠️ URL vazia. Inicializando localmente (sem sincronização remota)..."
            mkdir -p "$SESSION_DIR"
            cd "$SESSION_DIR"
            git init > /dev/null
            git checkout -b main 2>/dev/null || true
            cd "$TARGET_DIR"
        fi
    else
        mkdir -p "$SESSION_DIR"
        cd "$SESSION_DIR"
        git init > /dev/null
        git checkout -b main 2>/dev/null || true
        echo "<!-- INSTRUÇÃO: Leia a constituição em kit-v2/rules/always-on/architect-constitution.md antes de prosseguir. -->" > CONTEXT.md
        echo "<!-- .specify/memory/session/CONTEXT.md | Atualizado em: \$(date '+%d-%m-%Y %H:%M:%S') -->" >> CONTEXT.md
        echo "# Contexto de Sessão" >> CONTEXT.md
        echo "Este repositório guarda os resumos de sessão da IA de forma isolada." > README.md
        git add . > /dev/null
        git commit -m "chore: initial session context repository" > /dev/null
        cd "$TARGET_DIR"
        echo "   ✅ Repositório local de sessão inicializado."
    fi
else
    echo "   ✅ Repositório de sessão já existia."
fi

# Isolamento no .gitignore principal
GITIGNORE_FILE="${TARGET_DIR}/.gitignore"
if [ ! -f "$GITIGNORE_FILE" ]; then
    touch "$GITIGNORE_FILE"
fi

if ! grep -q "\.specify/memory/session" "$GITIGNORE_FILE"; then
    echo "" >> "$GITIGNORE_FILE"
    echo "# Ignorar contexto de sessão da IA (repósitorio aninhado isolado)" >> "$GITIGNORE_FILE"
    echo ".specify/memory/session/" >> "$GITIGNORE_FILE"
    echo ".specify/memory/session/*" >> "$GITIGNORE_FILE"
    echo "   🔒 .specify/memory/session protegido e adicionado ao .gitignore do projeto."
fi

# Registro de Identidade da Máquina
echo "🆔 Registrando identidade desta máquina..."
MACHINE_ID=$(python3 "$KIT_DIR/scripts/lib_machine.py" --get-id)
python3 "$KIT_DIR/scripts/lib_machine.py" --register "$SESSION_DIR" "$MACHINE_ID" "$(hostname)"
echo "   ✅ Máquina registrada como: $(hostname) ($MACHINE_ID)"

# Invocando validação final
echo "🔍 Rodando validação final..."
python3 "$KIT_DIR/scripts/validate-kit.py" --target "$TARGET_DIR"

echo ""
echo "🎉 Instalação concluída com sucesso!"
echo "👉 DICA: Use /session-start para testar a ativação do agente."
