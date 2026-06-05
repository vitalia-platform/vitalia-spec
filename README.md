<!-- kit-v2/README.md | Atualizado em: 05-06-2026 13:05:00(GMT-04:00) -->

<div align="center">

# Vitalia Spec Kit

**Kit de Agentes Clínicos para Spec-Driven Development**

*Infraestrutura portátil de IA especializada em saúde, fisiologia e ciência — governada pela Constituição Vitalia.*

[![Versão](https://img.shields.io/badge/versão-2.1.0-blue)](./MANIFEST.md)
[![Constituição](https://img.shields.io/badge/constituição-v1.0%20ATIVA-green)](./rules/always-on/architect-constitution.md)
[![Licença](https://img.shields.io/badge/licença-MIT-lightgrey)](./LICENSE)

</div>

---

## O que é este kit?

O **Vitalia Spec Kit** é uma coleção portátil de agentes, skills, extensões e regras para assistentes de IA (Antigravity/Gemini CLI e compatíveis). Ele transforma qualquer projeto de software em saúde em um ambiente de desenvolvimento disciplinado, com:

- **Spec-Driven Development (SDD)** como metodologia única
- **Human-in-the-Loop (HITL)** obrigatório em todo conteúdo clínico
- **Medical Gate** automático que classifica risco e injeta constraints científicos
- **17 agentes especialistas** — de fisiologistas a desenvolvedores
- **23 extensões (slash commands)** prontas para uso
- **Constituição imutável** de 23 artigos que governa toda decisão

---

## Instalação Rápida

```bash
# 1. Clone o kit em seu projeto
bash .specify/scripts/install.sh

# 2. Valide a instalação
python3 .specify/scripts/validate-kit.py --target .

# 3. Inicie a sessão no seu assistente
/session-start
```

---

## Estrutura do Kit

```
vitalia-spec/
├── rules/
│   └── always-on/
│       ├── architect-constitution.md   ← Constituição v1.0 (23 artigos)
│       ├── hitl-medical.md
│       ├── smart-routing.md
│       ├── vitalia-core.md
│       └── infrastructure.md
├── extensions/
│   ├── medical-gate.md                 ← /medical-gate (Gate I + II)
│   ├── spec-specify.md                 ← /spec-specify
│   ├── spec-plan.md                    ← /spec-plan
│   ├── spec-tasks.md                   ← /spec-tasks
│   ├── spec-implement.md               ← /spec-implement
│   ├── session-start.md                ← /session-start
│   ├── session-end.md                  ← /session-end
│   ├── session-consolidate.md          ← /session-consolidate
│   └── lib/
│       ├── core/                       ← Smart Router, Context Engine, etc.
│       ├── science/
│       │   └── vitalia-medical-gate/   ← SKILL.md + constraints-schema.yml
│       └── dev/
├── instructions/                       ← 17 agentes especialistas
│   ├── dev/   (conductor, coder, reviewer, tester, shipper)
│   ├── science/ (biologist, endocrinologist, exercise-physiologist, ...)
│   └── meta/  (session-manager, knowledge-curator, bootstrapper)
├── templates/
│   ├── software.spec.md                ← Template base de spec
│   ├── medical-gate.spec.md            ← Template de spec com Medical Constraints
│   └── blueprint.spec.md
├── scripts/
│   ├── install.sh
│   ├── validate-kit.py
│   └── lib_machine.py
├── README.md       ← este arquivo
├── MANIFEST.md     ← catálogo completo de componentes
└── MANUAL.md       ← guia de operação detalhado
```

---

## Medical Gate — Segurança Clínica Integrada

O `/medical-gate` implementa os **Artigos VIII e IX da Constituição Vitalia**:

```
/spec-specify (feature de saúde detectada)
       ↓
   Medical Gate I — Classificação de Risco
   ┌─────────────────────────────────────────┐
   │ 🟢 LOW    → avança para /spec-plan      │
   │ 🟡 MEDIUM → constraints HITL aprovados  │
   │ 🔴 HIGH   → revisão profissional exigida│
   └─────────────────────────────────────────┘
       ↓
   /spec-plan → /spec-tasks → /spec-implement
       ↓
   Medical Gate II — Aprovação de Publicação
   DRAFT → REVIEW → ACTIVE (único estado publicável)
```

Constraints globais disponíveis: `extensions/lib/science/vitalia-medical-gate/constraints-schema.yml`

---

## Componentes

| Tipo | Quantidade |
|---|---|
| Agentes especialistas | 17 |
| Extensões (slash commands) | 23 |
| Rules always-on | 5 |
| Templates | 3 |
| Scripts | 5 |

Catálogo completo: [MANIFEST.md](./MANIFEST.md)

---

## Governança

Este kit é governado pela **[Constituição Vitalia v1.0](./rules/always-on/architect-constitution.md)** — 23 artigos imutáveis organizados em 6 seções:

| Seção | Artigos | Tema |
|---|---|---|
| Artigo 0 | — | Propósito (árbitro final) |
| Seção I | I–IV | Processo (SDD, TDD, Lei Zero) |
| Seção II | V–VII | Dados e Segurança |
| Seção III | VIII–XI | Saúde e IA (HITL, Evidência) |
| Seção IV | XII–XIV | Arquitetura |
| Seção V | XV–XVIII | Qualidade |
| Seção VI | XIX–XXIII | Produto e Evolução |

---

## Changelog

### v2.1.0 — 05-06-2026
- ✅ Constituição Vitalia v1.0 ratificada (23 artigos + Artigo 0)
- 🏥 Extensão `/medical-gate` implementada (Artigos VIII e IX)
- 📋 Catálogo de constraints globais MC-NNN (FCmax, Zonas, IMC)
- 📄 Template `medical-gate.spec.md` com seção Medical Constraints
- 🏗️ Migração para repositório independente `vitalia-spec`

### v2.0.0 — 04-06-2026
- Migração completa para arquitetura Spec Kit (`.specify/`)
- Isolamento da infraestrutura de contexto (`.specify/memory/session`)
- Taxonomia de extensões e instruções atualizada

### v0.3.0 — 19-05-2026
- Pipeline de Revisão Integrativa modular
- Skills científicas: `data-ingestion` e `llm-screener`

### v0.2.0 — 11-05-2026
- 5 novos agentes science
- `install.sh` e `validate-kit.py` estáveis

### v0.1.0 — 30-04-2026
- Release inicial — 12 agentes, 8 workflows, 6 rules

---

## Licença

MIT — use, modifique e distribua livremente.
Contribuições via Pull Request são bem-vindas.

---

*Vitalia Platform — Tecnologia a serviço da vida.*
