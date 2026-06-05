---
name: vitalia-spec-tasks
description: >
  Terceiro passo do SDD Vitalia. Decompõe o plano técnico aprovado em tarefas
  granulares, sequenciais e individualmente testáveis com critérios de aceite.
  Acionar APÓS o plano técnico ter sido aprovado via vitalia-spec-plan.
---
<!-- integrations/agy/skills/vitalia-spec-tasks/SKILL.md | Atualizado em: 05-06-2026 13:16:00(GMT-04:00) -->

# Vitalia Spec Tasks

Executa o workflow em `.specify/extensions/spec-tasks.md`.

## Comportamento

1. Carregar o plano técnico aprovado
2. Decompor em tarefas atômicas — cada uma com:
   - Descrição clara do que fazer
   - Critério de aceite verificável
   - Dependências explícitas (se houver)
3. Garantir que nenhuma tarefa depende de outra não concluída para ser testada isoladamente (Art. II)
4. Apresentar checklist completo ao usuário para aprovação
