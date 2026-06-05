---
name: vitalia-spec-plan
description: >
  Segundo passo do SDD Vitalia. Lê uma spec.md aprovada e propõe a arquitetura
  técnica, estrutura de pastas, modelagem de dados, APIs e dependências.
  Acionar APÓS a spec ter sido aprovada pelo usuário via vitalia-spec-specify.
  NUNCA executar sem uma spec aprovada precedente.
---
<!-- integrations/agy/skills/vitalia-spec-plan/SKILL.md | Atualizado em: 05-06-2026 13:16:00(GMT-04:00) -->

# Vitalia Spec Plan

Executa o workflow em `.specify/extensions/spec-plan.md`.

## Comportamento

1. Carregar o `[funcionalidade].spec.md` aprovado
2. Verificar que o Gate I do medical-gate foi aprovado (se domínio de saúde)
3. Avaliar infraestrutura atual e arquitetura existente
4. Gerar plano técnico com:
   - Estrutura de Pastas e Arquivos (novos ou modificados)
   - Modelagem de Dados
   - APIs / Contratos (ReadSerializer separado de WriteSerializer)
   - Dependências
   - Impacto em multi-tenancy, RBAC, performance (Art. IV)
5. **AGUARDAR aprovação explícita do usuário** antes de gerar tarefas
