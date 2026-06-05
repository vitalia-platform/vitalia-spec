<!-- kit-v2/MANUAL.md | Atualizado em: 05-06-2026 13:08:00(GMT-04:00) -->

# Vitalia Spec Kit — Manual do Proprietário

Bem-vindo ao **Manual de Operação** do Vitalia Spec Kit.
Este documento cobre instalação, fluxo de trabalho, governança de contexto e resolução de problemas.

---

## 1. Visão Geral

O Vitalia Spec Kit é uma infraestrutura portátil de agentes de IA para projetos em saúde. Ele une dois mundos:

- **Spec-Driven Development (SDD)** — toda feature começa com uma spec aprovada antes de qualquer código
- **Medical Gate** — toda feature de saúde passa por classificação de risco clínico automático

### Os 5 Pilares

| Pilar | O que faz |
|---|---|
| **Constituição** | 23 artigos imutáveis que governam toda decisão |
| **Agentes** | 17 especialistas (dev, ciência, meta) |
| **Extensões** | 23 slash commands para workflows padronizados |
| **Medical Gate** | Gate de segurança clínica com constraints MC-NNN |
| **Contexto** | Memória dual-git sincronizada entre máquinas |

---

## 2. Instalação

### Pré-requisitos

- Antigravity (Gemini CLI) ou assistente compatível com `.specify/`
- Python 3.8+
- Git

### Instalação em um Projeto

```bash
# 1. Clone o kit em um local fixo da sua máquina
git clone git@github.com:vitalia-platform/vitalia-spec.git ~/vitalia-spec

# 2. Na raiz do seu projeto, execute o instalador
bash ~/vitalia-spec/scripts/install.sh

# 3. Quando solicitado, informe a URL do seu repositório de contexto:
#    git@github.com:SEU_USUARIO/seu-projeto-contexto.git

# 4. Valide a instalação
python3 .specify/scripts/validate-kit.py --target .

# 5. Inicie a sessão no assistente
/session-start
```

O `install.sh` cria os symlinks em `.specify/` apontando para o kit:

```
.specify/
├── extensions  → ~/vitalia-spec/extensions/
├── instructions → ~/vitalia-spec/instructions/
├── rules       → ~/vitalia-spec/rules/
├── templates   → ~/vitalia-spec/templates/
└── scripts     → ~/vitalia-spec/scripts/
```

### Importando Contexto da Nuvem

Se você já tem um repositório de contexto salvo:

```bash
cd .specify/memory/session
git remote add origin <URL_DO_SEU_REPO_DE_CONTEXTO>
git fetch origin
git reset --hard origin/main

# Atualiza o guardião de sincronia
cd ../..
python3 .specify/scripts/lib_sync_guard.py --action update --session-dir .specify/memory/session
```

Após isso: `/session-start` para a IA ler o contexto importado.

---

## 3. Fluxo de Trabalho SDD

Toda feature segue o mesmo pipeline:

```
/spec-specify   → spec.md aprovada pelo usuário
      ↓
[/medical-gate] → gate automático se domínio de saúde detectado
      ↓
/spec-plan      → plano técnico aprovado pelo usuário
      ↓
/spec-tasks     → tarefas granulares
      ↓
/spec-implement → código com TDD
```

### Iniciando uma Feature

```
Você: Quero criar uma feature de cálculo de zonas de treino por FC.

Assistente: Iniciando /spec-specify...
            [gera rascunho de spec]
            ✅ Aprovação necessária antes de avançar.

            🏥 Vitalia Medical Gate — Domínio de saúde detectado.
            Risco: 🟡 MEDIUM (score 3/7)
            Fatores: exibição ao usuário + fórmula fisiológica + dados individuais
            Constraints propostos: MC-GLOBAL-001 (FCmax), MC-GLOBAL-002 (Zonas ACSM)
            ✅ Confirma os constraints para avançar ao /spec-plan?
```

---

## 4. Medical Gate — Guia Rápido

### Gate I — Avaliação de Risco (após `/spec-specify`)

| Nível | Score | Protocolo |
|---|---|---|
| 🟢 LOW | 0 | Avança direto para `/spec-plan` |
| 🟡 MEDIUM | 1–2 | HITL: usuário aprova constraints MC-NNN |
| 🔴 HIGH | 3+ | HITL + revisão de profissional de saúde humano |

### Gate II — Aprovação de Publicação (antes de ir para produção)

```
DRAFT   → gerado pela IA (não exibível ao usuário)
REVIEW  → avaliado por especialista interno
ACTIVE  → aprovado por profissional de saúde ← único estado publicável
```

### Domínios que acionam o gate automaticamente

```
diagnóstico · sintomas · condições médicas · protocolos de tratamento
suplementação · biomarcadores · nutrição individualizada · dosagens
planos de saúde/wellness/fitness · fórmulas fisiológicas (FC, VO₂max, IMC)
```

### Constraints Globais Disponíveis

| ID | Descrição | Fonte | Nível |
|---|---|---|---|
| MC-GLOBAL-001 | FCmax = 208 − 0,7 × idade (Tanaka) | JACC 2001 | A |
| MC-GLOBAL-002 | Zonas de treino por % FCmax (5 zonas) | ACSM 2022 | B |
| MC-GLOBAL-003 | IMC — Classificação OMS | WHO 2004 | A |

Catálogo completo: `extensions/lib/science/vitalia-medical-gate/constraints-schema.yml`

---

## 5. Gestão de Sessão e Contexto

### Arquitetura Dual-Git

O kit usa dois repositórios Git independentes:

```
Repositório Principal (seu código)
    └── .specify/memory/session/  ← Repositório de Contexto (Git separado)
            ├── CONTEXT.md           Estado atual do projeto
            ├── README.md            Dashboard (exibido no GitHub)
            ├── SESSION_HISTORY.md   Histórico de sessões (cronologia reversa)
            ├── CONSOLIDATION_LOG.md Lock distribuído de consolidação
            ├── sprint_atual.md      Checklist da sprint atual
            └── shards/
                └── [MACHINE_ID].md  Estado de cada máquina
```

### Comandos de Sessão

| Comando | Quando usar |
|---|---|
| `/session-start` | Sempre ao iniciar — valida ambiente e carrega contexto |
| `/session-end` | Ao encerrar — salva shard local e commita |
| `/session-consolidate` | Após session-end — sincroniza nuvem e atualiza dashboard |

### Controle de Concorrência (ETags)

O `lib_sync_guard.py` previne conflitos entre máquinas:

1. **Ao iniciar**: lê ETag remoto — bloqueia se divergir, exige `/session-resolve.sh`
2. **Ao consolidar**: adquire lock no `CONSOLIDATION_LOG.md` antes de empurrar
3. **Lock liberado**: após push bem-sucedido do dashboard atualizado

---

## 6. Regras da Constituição — Referência Rápida

A [Constituição Vitalia v1.0](./rules/always-on/architect-constitution.md) governa tudo. Resumo das regras mais relevantes para o dia a dia:

| Artigo | Regra |
|---|---|
| **Art. 0** | Propósito é o árbitro final de qualquer conflito |
| **Art. I** | Nenhum código sem spec aprovada precedente |
| **Art. III** | Testes escritos antes da implementação (Red → Green → Refactor) |
| **Art. V** | Dado de saúde pertence ao Participante — criptografia obrigatória |
| **Art. VI** | Segredos nunca entram no Git |
| **Art. VIII** | Gate HITL obrigatório antes de `/spec-plan` em domínios de saúde |
| **Art. IX** | Conteúdo médico: somente `ACTIVE` vai para produção |
| **Art. X** | Todo MC-NNN tem fonte científica com nível A, B ou C |
| **Art. XV** | Timestamp obrigatório — fuso `(GMT-04:00)` em todo artefato |

---

## 7. Troubleshooting

| Problema | Solução |
|---|---|
| `validate-kit.py` reporta symlink quebrado | `bash .specify/scripts/install.sh` — recria os symlinks |
| `CONFLICT (Remote > Lock)` ao iniciar | `bash .specify/scripts/session-resolve.sh` → opção 1 (Pull) |
| Kit não aparece no assistente | Verificar se `.specify/extensions/` aponta para `kit-v2/extensions/` |
| Conteúdo médico bloqueado sem gate | Usar `/medical-gate` para classificar e aprovar constraints |
| Timestamp sem horário | Corrigir para formato `DD-MM-YYYY HH:MM:SS(GMT-04:00)` |

### Comandos de Diagnóstico

```bash
# Validar integridade completa
python3 .specify/scripts/validate-kit.py --target .

# Verificar Machine ID
python3 .specify/scripts/lib_machine.py --get-id

# Resolver conflito de contexto
bash .specify/scripts/session-resolve.sh

# Verificar ETag manualmente
python3 .specify/scripts/lib_sync_guard.py --action check --session-dir .specify/memory/session
```

---

*Vitalia Platform — Tecnologia a serviço da vida.*
*Constituição Vitalia v1.0 — ratificada em 05-06-2026 12:16:00(GMT-04:00)*
