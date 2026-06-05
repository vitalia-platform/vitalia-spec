#!/usr/bin/env bash
# Vitalia Spec Kit — Instalador Remoto
# Uso: sh -c "$(wget -qO- https://raw.githubusercontent.com/vitalia-platform/vitalia-spec/main/install.sh)"
#   ou: sh -c "$(curl -fsSL https://raw.githubusercontent.com/vitalia-platform/vitalia-spec/main/install.sh)"
#
# Executa a partir do diretório raiz do seu projeto.
# Funciona em projetos novos e em projetos já iniciados.

set -e

# ─────────────────────────────────────────────
# Configurações
# ─────────────────────────────────────────────
REPO_URL="https://github.com/vitalia-platform/vitalia-spec.git"
KIT_DIR="${HOME}/.vitalia-spec"
TARGET_DIR="${PWD}"
AGENT_DIR="${TARGET_DIR}/.specify"
SESSION_DIR="${AGENT_DIR}/memory/session"
AGY_PLUGIN_DIR="${HOME}/.gemini/config/plugins/vitalia"

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║       Vitalia Spec Kit — Instalador      ║"
echo "╚══════════════════════════════════════════╝"
echo "📂 Projeto: $(basename "${TARGET_DIR}")"
echo ""

# ─────────────────────────────────────────────
# PASSO 1: Obter/Atualizar o kit em ~/.vitalia-spec
# ─────────────────────────────────────────────
echo "📦 PASSO 1 — Kit Vitalia..."
if [ -d "${KIT_DIR}/.git" ]; then
    echo "   🔄 Atualizando kit existente em ${KIT_DIR}..."
    git -C "${KIT_DIR}" pull --ff-only origin main 2>/dev/null || \
        echo "   ⚠️  Pull falhou (sem rede?). Usando versão local."
else
    echo "   ⬇️  Clonando kit em ${KIT_DIR}..."
    git clone --depth=1 "${REPO_URL}" "${KIT_DIR}"
fi
echo "   ✅ Kit em: ${KIT_DIR}"

# ─────────────────────────────────────────────
# PASSO 2: Criar/atualizar symlinks em .specify/
# ─────────────────────────────────────────────
echo ""
echo "🔗 PASSO 2 — Symlinks .specify/..."
mkdir -p "${AGENT_DIR}"

for item in instructions rules extensions templates scripts; do
    rm -rf "${AGENT_DIR}/${item}"
    ln -s "${KIT_DIR}/${item}" "${AGENT_DIR}/${item}"
    echo "   🔗 .specify/${item} → ${KIT_DIR}/${item}"
done
echo "   ✅ Symlinks criados."

# ─────────────────────────────────────────────
# PASSO 3: Plugin AGY (Antigravity)
# ─────────────────────────────────────────────
echo ""
echo "🤖 PASSO 3 — Plugin AGY..."
if [ -d "${KIT_DIR}/integrations/agy" ]; then
    mkdir -p "${HOME}/.gemini/config/plugins"
    rm -rf "${AGY_PLUGIN_DIR}"
    ln -s "${KIT_DIR}/integrations/agy" "${AGY_PLUGIN_DIR}"
    echo "   🔗 Plugin: ~/.gemini/config/plugins/vitalia → ${KIT_DIR}/integrations/agy"
    echo "   ✅ Skills disponíveis no AGY:"
    for skill_dir in "${KIT_DIR}/integrations/agy/skills"/*/; do
        echo "      • $(basename "${skill_dir}")"
    done
else
    echo "   ⚠️  Integração AGY não encontrada. Pulando."
fi

# ─────────────────────────────────────────────
# PASSO 4: Repositório de Contexto de Sessão
# ─────────────────────────────────────────────
echo ""
echo "📂 PASSO 4 — Contexto de sessão..."

if [ -d "${SESSION_DIR}/.git" ]; then
    echo "   ✅ Repositório de sessão já existe. Pulando."
else
    echo "   ❓ Conectar a um repositório de contexto no GitHub? (s/N)"
    echo "      (Informe 's' mesmo que o repositório esteja vazio)"
    read -p "   > " choice
    if [ "${choice}" = "s" ] || [ "${choice}" = "S" ]; then
        read -p "   URL do repositório (git@github.com:...): " repo_url
        if [ -n "${repo_url}" ]; then
            rm -rf "${SESSION_DIR}"
            if git clone "${repo_url}" "${SESSION_DIR}" 2>/dev/null; then
                echo "   ✅ Repositório clonado."
                # Inicializar se estiver vazio
                if ! git -C "${SESSION_DIR}" rev-parse HEAD &>/dev/null; then
                    echo "   📄 Repositório vazio — criando estrutura inicial..."
                    cd "${SESSION_DIR}"
                    git checkout -b main 2>/dev/null || git checkout main 2>/dev/null || true
                    TIMESTAMP=$(python3 -c "from datetime import datetime; print(datetime.now().strftime('%d-%m-%Y %H:%M:%S'))(GMT-04:00)" 2>/dev/null || date '+%d-%m-%Y %H:%M:%S')
                    echo "<!-- INSTRUÇÃO: Leia a constituição em ~/.vitalia-spec/rules/always-on/architect-constitution.md antes de prosseguir. -->" > CONTEXT.md
                    echo "<!-- .specify/memory/session/CONTEXT.md | Atualizado em: ${TIMESTAMP}(GMT-04:00) -->" >> CONTEXT.md
                    echo "# Contexto de Sessão" >> CONTEXT.md
                    echo "" >> CONTEXT.md
                    echo "Estado atual do projeto, gerenciado pelo agente de IA." >> CONTEXT.md
                    echo "" > SESSION_HISTORY.md
                    git add . && git commit -m "chore: initial session context"
                    git push -u origin main 2>/dev/null || echo "   ⚠️  Push falhou — verifique permissões SSH. Contexto salvo localmente."
                    cd "${TARGET_DIR}"
                fi
            else
                echo "   ❌ Falha ao clonar. Inicializando localmente."
                _init_local_session
            fi
        fi
    else
        mkdir -p "${SESSION_DIR}"
        cd "${SESSION_DIR}"
        git init -q && git checkout -b main 2>/dev/null || true
        echo "# Contexto de Sessão" > CONTEXT.md
        git add . && git commit -qm "chore: local session init"
        cd "${TARGET_DIR}"
        echo "   ✅ Sessão local inicializada."
    fi
fi

# ─────────────────────────────────────────────
# PASSO 5: .gitignore
# ─────────────────────────────────────────────
GITIGNORE="${TARGET_DIR}/.gitignore"
if [ ! -f "${GITIGNORE}" ]; then touch "${GITIGNORE}"; fi
if ! grep -q "\.specify/memory/session" "${GITIGNORE}"; then
    printf "\n# Vitalia Spec Kit — contexto de sessão da IA (repo Git separado)\n" >> "${GITIGNORE}"
    echo ".specify/memory/session/" >> "${GITIGNORE}"
    echo "   🔒 .specify/memory/session/ protegido no .gitignore"
fi

# ─────────────────────────────────────────────
# PASSO 6: Identidade da máquina + Validação
# ─────────────────────────────────────────────
echo ""
echo "🆔 PASSO 6 — Identidade e validação..."
MACHINE_ID=$(python3 "${KIT_DIR}/scripts/lib_machine.py" --get-id)
python3 "${KIT_DIR}/scripts/lib_machine.py" --register "${SESSION_DIR}" "${MACHINE_ID}" "$(hostname)"
echo "   ✅ Máquina: $(hostname) (${MACHINE_ID})"

echo ""
python3 "${KIT_DIR}/scripts/validate-kit.py" --target "${TARGET_DIR}"

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║  ✅  Instalação concluída com sucesso!   ║"
echo "╚══════════════════════════════════════════╝"
echo ""
echo "  Próximos passos:"
echo "  1. No seu assistente (Antigravity), execute:"
echo "     /session-start"
echo ""
echo "  2. Para desinstalar:"
echo "     rm -rf ~/.vitalia-spec ~/.gemini/config/plugins/vitalia .specify"
echo ""
