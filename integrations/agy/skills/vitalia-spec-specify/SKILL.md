---
name: vitalia-spec-specify
description: >
  Primeiro passo do SDD Vitalia. Traduz o pedido do usuário em uma spec.md formal
  com requisitos, histórias de usuário e critérios de aceite. Acionar quando o usuário
  descrever uma nova feature, funcionalidade ou sistema a ser construído.
  NUNCA escrever código antes desta spec estar aprovada pelo usuário.
---
<!-- integrations/agy/skills/vitalia-spec-specify/SKILL.md | Atualizado em: 05-06-2026 13:15:00(GMT-04:00) -->

# Vitalia Spec Specify

Executa o workflow em `.specify/extensions/spec-specify.md`.
Use o template em `.specify/templates/software.spec.md` como base.
Se o domínio for de saúde, use `.specify/templates/medical-gate.spec.md`.

## Comportamento

1. Receber a descrição da feature ou sistema
2. Verificar se há ambiguidades — interagir para esclarecer
3. Analisar viabilidade e aderência à Constituição (Art. IV — Lei Zero)
4. Gerar o arquivo `[funcionalidade].spec.md` com:
   - Requisitos Funcionais e Não-Funcionais
   - Histórias de Usuário
   - Critérios de Aceite
   - Escopo Negativo
5. Se domínio de saúde detectado: acionar `vitalia-medical-gate` (Gate I) antes de prosseguir
6. **AGUARDAR aprovação explícita do usuário** antes de liberar o `/spec-plan`

## Gate SDD (Art. I)

```
spec aprovada → /spec-plan → /spec-tasks → /spec-implement
```
Nenhuma etapa posterior é executada sem aprovação da etapa anterior.
