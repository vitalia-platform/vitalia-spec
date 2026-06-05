<!-- kit-v2/MANIFEST.md | Atualizado em: 05-06-2026 13:33:00(GMT-04:00) -->

# Vitalia Spec Kit — MANIFEST

> Catálogo completo de componentes do kit.

**Versão**: 2.1.0
**Última atualização**: 05-06-2026 13:33:00(GMT-04:00)
**Compatível com**: Antigravity (Gemini CLI) e qualquer ferramenta que suporte `.specify/`
**Instalação**: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/vitalia-platform/vitalia-spec/main/install.sh)"`

---

## 🤖 Agentes / Instructions (17)

`instructions/`

| # | Categoria | Agente | Arquivo | Trigger Principal |
|---|---|---|---|---|
| 1 | **Dev** | Conductor | `dev/conductor.md` | full stack, orquestre, múltiplos domínios |
| 2 | **Dev** | Coder | `dev/coder.md` | continue, implemente, próximo passo |
| 3 | **Dev** | Reviewer | `dev/reviewer.md` | revise, code review, checar qualidade |
| 4 | **Dev** | Tester | `dev/tester.md` | testes, TDD, cobertura, pytest |
| 5 | **Dev** | Shipper | `dev/shipper.md` | release, deploy, changelog, publicar |
| 6 | **Science** | Biologist | `science/biologist.md` | fisiologia, anatomia, sistema nervoso |
| 7 | **Science** | Endocrinologist | `science/endocrinologist.md` | hormônio, cortisol, metabolismo |
| 8 | **Science** | Exercise Physiologist | `science/exercise-physiologist.md` | exercício, VO₂max, zona de treino, HIIT |
| 9 | **Science** | Longevity Specialist | `science/longevity-specialist.md` | longevidade, aging, epigenética, NAD+ |
| 10 | **Science** | Nutritionist | `science/nutritionist.md` | nutrição, dieta, alérgenos |
| 11 | **Science** | Psychologist | `science/psychologist.md` | ansiedade, comportamento, hábito |
| 12 | **Science** | Research Analyst | `science/research-analyst.md` | analisar artigo, nível de evidência, paper |
| 13 | **Science** | Sleep Specialist | `science/sleep-specialist.md` | sono, REM, insônia, ritmo circadiano |
| 14 | **Science** | Supplement Pharmacologist | `science/supplement-pharmacologist.md` | suplemento, dosagem, interação |
| 15 | **Meta** | Session Manager | `meta/session-manager.md` | session-start, onde parei, contexto |
| 16 | **Meta** | Knowledge Curator | `meta/knowledge-curator.md` | aprendi, extraia padrão, crie agente |
| 17 | **Meta** | Bootstrapper | `meta/bootstrapper.md` | novo projeto, bootstrap, do zero |

---

## ⚡ Extensões / Slash Commands (23)

`extensions/`

### SDD — Spec-Driven Development

| Comando | Arquivo | Função | Artigo Constitucional |
|---|---|---|---|
| `/spec-specify` | `spec-specify.md` | Traduz pedido em spec aprovada | Art. I |
| `/spec-plan` | `spec-plan.md` | Plano técnico a partir da spec | Art. I |
| `/spec-tasks` | `spec-tasks.md` | Tarefas granulares do plan | Art. II |
| `/spec-implement` | `spec-implement.md` | Implementação TDD | Art. III |

### Saúde e Clínica

| Comando | Arquivo | Função | Artigo Constitucional |
|---|---|---|---|
| `/medical-gate` | `medical-gate.md` | Gate de risco I (spec) e II (publicação) | Art. VIII, IX |
| `/science-review` | `science-review.md` | Revisão científica de conteúdo | Art. X, XI |
| `/screener` | `screener.md` | Triagem de literatura científica | Art. X |
| `/integrative-review` | `integrative-review.md` | Pipeline completo de revisão | Art. X |

### Sessão e Contexto

| Comando | Arquivo | Função |
|---|---|---|
| `/session-start` | `session-start.md` | Recupera contexto ao iniciar |
| `/session-end` | `session-end.md` | Salva shard e commita local |
| `/session-consolidate` | `session-consolidate.md` | Sincroniza nuvem e atualiza dashboard |
| `/continue` | `continue.md` | Retoma tarefa inacabada |

### Desenvolvimento

| Comando | Arquivo | Função |
|---|---|---|
| `/pair` | `pair.md` | Pair programming chunk-a-chunk |
| `/review` | `review.md` | Revisão de código |
| `/test` | `test.md` | TDD orientado |
| `/debug` | `debug.md` | Diagnóstico de erros |
| `/adr` | `adr.md` | Architecture Decision Record |
| `/release` | `release.md` | Empacotamento e changelog |

### Projeto e Meta

| Comando | Arquivo | Função |
|---|---|---|
| `/bootstrap` | `bootstrap.md` | Inicializa projeto do zero |
| `/blueprint-specify` | `blueprint-specify.md` | Spec de blueprint |
| `/blueprint-plan` | `blueprint-plan.md` | Plan de blueprint |
| `/brainstorming` | `brainstorming.md` | Sessão estruturada de ideias |
| `/skill-evaluation` | `skill-evaluation.md` | Avalia e melhora skills do kit |
| `/resolve-ids` | `resolve-ids.md` | Resolve conflitos de IDs |

---

## 📜 Regras Always-On (5)

`rules/always-on/`

| Arquivo | Função | Artigos |
|---|---|---|
| `architect-constitution.md` | **Constituição Vitalia v1.0** — 23 artigos + Art. 0 | Todos |
| `vitalia-core.md` | Identidade, propósito e espírito do kit | Art. 0 |
| `hitl-medical.md` | HITL obrigatório para conteúdo clínico | Art. VIII, IX |
| `smart-routing.md` | Roteamento contextual automático | Art. XXII |
| `infrastructure.md` | Selo de tempo, symlinks e ambiente | Art. XV, XXIII |

---

## 🧠 Skills / Lib (14)

`extensions/lib/`

### Core

| Skill | Diretório | Trigger |
|---|---|---|
| Smart Router | `core/smart-router/` | sempre ativo |
| Context Engine | `core/context-engine/` | contexto, sessão, CONTEXT.md |
| Agent Factory | `core/agent-factory/` | criar agente, template |
| Behavioral Modes | `core/behavioral-modes/` | modo par, modo revisão |
| Intelligent Routing | `core/intelligent-routing/` | detecção de domínio |

### Science

| Skill | Diretório | Trigger |
|---|---|---|
| **Vitalia Medical Gate** | `science/vitalia-medical-gate/` | domínio de saúde detectado |
| Evidence Grading | `science/evidence-grading/` | nível de evidência, RCT |

### Dev

| Skill | Diretório | Trigger |
|---|---|---|
| Plan Writing | `dev/plan-writing/` | spec-plan, plano técnico |
| MCP Builder | `dev/mcp-builder/` | MCP, ferramenta externa |
| Parallel Agents | `dev/parallel-agents/` | múltiplos agentes |
| Lint and Validate | `dev/lint-and-validate/` | validar, checar qualidade |

---

## 📄 Templates (3)

`templates/`

| Arquivo | Uso |
|---|---|
| `software.spec.md` | Template base de spec (SDD) |
| `medical-gate.spec.md` | Template de spec com seção Medical Constraints |
| `blueprint.spec.md` | Template de spec de blueprint |

---

## 🔧 Scripts (5)

`scripts/`

| Script | Função |
|---|---|
| `install.sh` (**raiz**) | Instalador remoto — clona `~/.vitalia-spec`, symlinks, plugin AGY |
| `scripts/install.sh` | Instalador local (chamado pelo remoto após clone) |
| `scripts/validate-kit.py` | Valida integridade e sincronia do kit |
| `scripts/lib_machine.py` | Gera e recupera Machine ID da máquina local |
| `scripts/lib_sync_guard.py` | Controle de ETag e lock de sincronia |
| `scripts/session-resolve.sh` | Resolução interativa de conflitos de contexto |

---

## 📊 Totais

| Tipo | Quantidade |
|---|---|
| Agentes | 17 |
| Extensões (slash commands) | 23 |
| Rules always-on | 5 |
| Skills / Lib | 14 |
| Templates | 3 |
| Scripts | 6 |
| **Skills AGY (plugin)** | **9** |
| **Constraints MC-GLOBAL** | **3** (FCmax, Zonas, IMC) |
| **Total de componentes** | **80** |
