---
name: vitalia-medical-gate
description: >
  Gate de segurança clínica da Vitalia. Avalia o risco de uma spec em domínio de saúde
  (Gate I — Artigo VIII da Constituição) e verifica pré-condições de publicação de
  conteúdo médico (Gate II — Artigo IX). Acionar quando feature envolver: diagnóstico,
  sintomas, condições médicas, suplementação, biomarcadores, nutrição individualizada,
  dosagens, planos de saúde/wellness/fitness, ou fórmulas fisiológicas (FC, VO₂max, IMC).
---
<!-- integrations/agy/skills/vitalia-medical-gate/SKILL.md | Atualizado em: 05-06-2026 13:13:00(GMT-04:00) -->

# Vitalia Medical Gate

Executa o workflow definido em `.specify/extensions/medical-gate.md`.
Lógica completa em `.specify/extensions/lib/science/vitalia-medical-gate/SKILL.md`.
Constraints globais em `.specify/extensions/lib/science/vitalia-medical-gate/constraints-schema.yml`.

## Quando Acionar Automaticamente

Após qualquer `/spec-specify` que envolva domínios de saúde — **antes** de liberar `/spec-plan`.

## Comportamento

### Gate I — Avaliação de Risco (Artigo VIII)

Aplicar a matriz de risco e apresentar ao usuário:

| Fator | +Pontos |
|---|---|
| Conteúdo exibido ao usuário final | +1 |
| Dados individuais do usuário | +1 |
| Recomendação de ação | +1 |
| Fórmula ou cálculo fisiológico | +1 |
| Domínio de alto risco (dosagem, diagnóstico, tratamento) | +2 |

- **🟢 LOW (0)**: avançar para `/spec-plan`
- **🟡 MEDIUM (1-2)**: propor constraints MC-NNN, AGUARDAR aprovação HITL
- **🔴 HIGH (3+)**: exigir revisão de profissional de saúde humano

### Gate II — Aprovação de Publicação (Artigo IX)

Verificar antes de qualquer conteúdo médico ir para produção:
- Disclaimer educacional presente
- Todos MC-NNN com fonte científica A/B/C
- Aprovação de profissional de saúde registrada
- Status: `ACTIVE` (não `DRAFT` nem `REVIEW`)

## Invocação Manual

```
/medical-gate                        → avalia spec ativa
/medical-gate --gate=publicacao      → apenas Gate II
```
