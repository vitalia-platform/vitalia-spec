---
name: vitalia-medical-gate
description: >
  Gate de segurança clínica da Vitalia. Avalia o risco de saúde de qualquer
  feature (Artigo VIII) e bloqueia publicação de conteúdo médico sem aprovação
  de profissional humano (Artigo IX). Ativo automaticamente em domínios de saúde.
version: 1.0.0
trigger: after_specify, after_plan
---
<!-- kit-v2/extensions/lib/science/vitalia-medical-gate/SKILL.md | Atualizado em: 05-06-2026 12:53:00(GMT-04:00) -->

# Vitalia Medical Gate — Gate de Segurança Clínica

> Implementa os Artigos VIII e IX da Constituição Vitalia v1.0.
> Nenhuma feature de saúde avança sem passar por este gate.

---

## Quando Acionar

Este skill é acionado **automaticamente** após `/spec-specify` quando a spec contém
qualquer um dos seguintes domínios:

```
diagnóstico · sintomas · condições médicas · protocolos de tratamento
suplementação · biomarcadores · nutrição individualizada · dosagens
planos personalizados de saúde/wellness/fitness
fórmulas fisiológicas exibidas ao usuário (FC, VO₂max, zonas de treino, IMC)
```

Pode ser invocado manualmente com `/medical-gate` a qualquer momento.

---

## Gate I — Avaliação de Risco da Spec (Artigo VIII)

### Passo 1: Classificar o Risco

Leia a spec em análise e aplique a matriz abaixo:

| Fator de Risco | Pontuação |
|---|---|
| Conteúdo exibido diretamente ao usuário final | +1 |
| Dados individuais do usuário (não agregados) | +1 |
| Recomendação de ação (não apenas informação) | +1 |
| Fórmula ou cálculo fisiológico | +1 |
| Domínio de alto risco (dosagem, diagnóstico, tratamento) | +2 |

**Score → Nível**:

| Score | Nível | Cor |
|---|---|---|
| 0 | LOW | 🟢 |
| 1–2 | MEDIUM | 🟡 |
| 3+ | HIGH | 🔴 |

### Passo 2: Apresentar o Resultado ao Usuário

```
┌──────────────────────────────────────────────────────────────────┐
│ 🏥 VITALIA MEDICAL GATE — Avaliação de Risco                     │
│                                                                  │
│ Feature:    [nome da spec]                                       │
│ Risco:      [🟢 LOW | 🟡 MEDIUM | 🔴 HIGH]                       │
│ Score:      [N]/7                                                │
│                                                                  │
│ Fatores identificados:                                           │
│   • [fator 1]                                                    │
│   • [fator 2]                                                    │
│                                                                  │
│ Protocolo:  [ver abaixo]                                         │
└──────────────────────────────────────────────────────────────────┘
```

### Passo 3: Aplicar Protocolo por Nível

**🟢 LOW** — Avançar diretamente para `/spec-plan`.

**🟡 MEDIUM** — Gate HITL obrigatório:
1. Exibir avaliação ao usuário
2. Propor constraints MC-NNN relevantes (ver schema em `constraints-schema.yml`)
3. AGUARDAR aprovação explícita dos constraints antes de liberar `/spec-plan`
4. Registrar constraints aprovados na spec com o prefixo `## Medical Constraints`

**🔴 HIGH** — Gate HITL + Revisão Profissional:
1. Exibir avaliação ao usuário
2. Marcar a spec como `STATUS: AGUARDANDO_REVISAO_CLINICA`
3. Listar os constraints obrigatórios
4. EXIGIR confirmação explícita de revisão por profissional de saúde humano
5. SOMENTE ENTÃO liberar `/spec-plan`

---

## Gate II — Aprovação de Publicação (Artigo IX)

Acionado antes de qualquer conteúdo médico ir para produção.

### Estados de Conteúdo Clínico

```
DRAFT      → gerado pela IA, não exibível ao usuário
REVIEW     → em avaliação por especialista científico interno
ACTIVE     → aprovado por profissional de saúde → único estado publicável
```

### Checklist de Publicação (bloqueante)

Antes de marcar conteúdo clínico como `ACTIVE`, verificar:

- [ ] Disclaimer obrigatório presente:
  > "Esta informação é de natureza educacional. Consulte um profissional de saúde habilitado antes de tomar decisões médicas."
- [ ] Todos os constraints MC-NNN têm fonte científica com nível A, B ou C
- [ ] Aprovação de profissional de saúde registrada (nome + data + especialidade)
- [ ] Conteúdo não faz promessa terapêutica ou diagnóstica

---

## Injeção de Constraints na Spec

Quando constraints MC-NNN forem aprovados pelo usuário, injetá-los na spec:

```markdown
## Medical Constraints

> Definidos pelo vitalia-medical-gate em: DD-MM-YYYY HH:MM:SS(GMT-04:00)
> Nível de risco: [MEDIUM | HIGH]

| ID | Constraint | Evidência | Nível |
|---|---|---|---|
| MC-001 | [descrição do constraint] | [fonte] | [A/B/C] |
| MC-002 | [descrição do constraint] | [fonte] | [A/B/C] |
```

---

## Exemplos de Constraints MC-NNN

Ver `constraints-schema.yml` para o catálogo completo e o schema de criação.

**Exemplos de uso**:

```yaml
# MC-GLOBAL-001 — FC Máxima (Fórmula de Tanaka)
id: MC-GLOBAL-001
formula: "208 - 0.7 * age"
fonte: "Tanaka et al., 2001 — Med Sci Sports Exerc"
nivel_evidencia: A
restricoes:
  - "Não aplicar a cardiopatas sem avaliação médica prévia"
  - "Não usar em menores de 18 anos sem ajuste pediátrico"
```

---

## Formato de Invocação Manual

```
/medical-gate                        → avalia a spec ativa
/medical-gate --spec=[nome].spec.md  → avalia spec específica
/medical-gate --gate=publicacao      → ativa apenas o Gate II
```
