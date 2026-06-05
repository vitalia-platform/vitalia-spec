<!-- kit-v2/AGENTS.md | Atualizado em: 05-06-2026 13:16:00(GMT-04:00) -->

# AGENTS.md — Vitalia Spec Kit

> Tabela de roteamento operacional do Smart Router (Art. XXII da Constituição).
> Este arquivo é a fonte da verdade para mapeamento domínio → especialista.
> A constituição carrega o **princípio** — este arquivo carrega a **tabela**.

---

## Domínio: Desenvolvimento

| Intenção detectada | Palavras-chave / Padrões | Agente |
|---|---|---|
| Continuar código, implementar | "continue", "implemente", "próximo passo", referência a arquivo .py/.ts/.js | `coder` |
| Pair programming | "pair", "vamos trabalhar juntos", "em pares" | `coder` (modo pair) |
| Bug / erro | "erro", "bug", "não funciona", "quebrou", "exception", stack trace | `coder` |
| Code review | "revise", "review", "verifique o código" | `reviewer` |
| Testes / TDD | "teste", "TDD", "cobertura", "pytest", "jest", "vitest" | `tester` |
| Deploy / release | "deploy", "publicar", "release", "produção", "CI/CD" | `shipper` |
| Arquitetura / full stack | "full stack", "arquitetura", "planeje", "toda a feature" | `conductor` |

---

## Domínio: Saúde e Ciência

| Intenção detectada | Palavras-chave / Padrões | Agente |
|---|---|---|
| Fisiologia do exercício | "exercício", "VO₂max", "zona de treino", "FC", "HIIT", "treino" | `exercise-physiologist` |
| Endocrinologia | "hormônio", "cortisol", "insulina", "testosterona", "tireoide", "metabolismo" | `endocrinologist` |
| Nutrição | "nutrição", "dieta", "proteína", "alérgenos", "calorias", "alimentação" | `nutritionist` |
| Suplementação | "suplemento", "dosagem", "creatina", "vitamina", "interação" | `supplement-pharmacologist` |
| Sono e recovery | "sono", "REM", "insônia", "ritmo circadiano", "recovery" | `sleep-specialist` |
| Longevidade | "longevidade", "aging", "epigenética", "NAD+", "anti-aging" | `longevity-specialist` |
| Psicologia / hábitos | "ansiedade", "hábito", "comportamento", "mindfulness", "aderência" | `psychologist` |
| Biologia geral | "fisiologia", "anatomia", "homeostase", "células", "sistema nervoso" | `biologist` |
| Literatura científica | "analisar artigo", "nível de evidência", "RCT", "paper", "meta-análise" | `research-analyst` |

---

## Domínio: Saúde — Triggers de Gate Automático

Os seguintes domínios acionam o `vitalia-medical-gate` **antes** de qualquer `/spec-plan`:

```
diagnóstico · sintomas · condições médicas · protocolos de tratamento
suplementação · biomarcadores · nutrição individualizada · dosagens
planos personalizados de saúde / wellness / fitness
fórmulas fisiológicas exibidas ao usuário (FC, VO₂max, IMC, zonas de treino)
```

---

## Domínio: SDD — Workflows

| Intenção detectada | Palavras-chave / Padrões | Skill |
|---|---|---|
| Nova feature / sistema | "quero criar", "preciso de", "feature de", "sistema que" | `vitalia-spec-specify` |
| Plano técnico | "como implementar", "arquitetura para", spec aprovada presente | `vitalia-spec-plan` |
| Decomposição | "quebre em tarefas", "lista de tarefas", plan aprovado presente | `vitalia-spec-tasks` |
| Implementação | "implemente agora", "código", tasks aprovadas presentes | `vitalia-spec-implement` |

---

## Domínio: Sessão e Meta

| Intenção detectada | Palavras-chave / Padrões | Skill |
|---|---|---|
| Iniciar sessão | "onde parei", "session-start", "contexto", "começar" | `vitalia-session-start` |
| Encerrar sessão | "acabou", "session-end", "encerrar", "salvar contexto" | `vitalia-session-end` |
| Sincronizar nuvem | "consolidar", "dashboard", "sync", "outras máquinas" | `vitalia-session-consolidate` |
| Revisão científica | "revisar conteúdo", "válido clinicamente", "science-review" | `vitalia-science-review` |
| Gate clínico | "risco clínico", "medical gate", "constraint MC" | `vitalia-medical-gate` |
| Novo projeto | "novo projeto", "do zero", "bootstrap" | `bootstrapper` |
| Memorizar padrão | "aprendi", "memorize", "crie um skill" | `knowledge-curator` |

---

## Regras de Seleção

### 1 domínio → agente direto
```
"Calcula as zonas de FC para o usuário"
→ exercício + fórmula fisiológica → exercise-physiologist + medical-gate (MEDIUM)
```

### 2 domínios relacionados → sequência
```
"Implementa o endpoint de biometria com ranges clínicos corretos"
→ tech + endocrinologia → endocrinologist valida primeiro → coder implementa com MC-NNN
```

### 3+ domínios / arquitetural → conductor
```
"Cria a feature completa de plano de saúde personalizado com IA"
→ múltiplos domínios → conductor orquestra o time
```

### Override manual sempre disponível
```
@exercise-physiologist → bypassa roteamento automático
@coder → usa coder diretamente
```

---

## Skills AGY Instalados

Após `bash scripts/install.sh`, os seguintes skills ficam disponíveis no Antigravity:

| Skill | Descrição curta |
|---|---|
| `vitalia-session-start` | Inicia sessão com briefing de contexto |
| `vitalia-session-end` | Encerra sessão e grava shard local |
| `vitalia-session-consolidate` | Sincroniza nuvem e atualiza dashboard |
| `vitalia-medical-gate` | Gate de segurança clínica (Art. VIII/IX) |
| `vitalia-spec-specify` | Traduz pedido em spec aprovada |
| `vitalia-spec-plan` | Plano técnico a partir da spec |
| `vitalia-spec-tasks` | Decomposição em tarefas atômicas |
| `vitalia-spec-implement` | Implementação TDD |
| `vitalia-science-review` | Revisão científica de conteúdo médico |
