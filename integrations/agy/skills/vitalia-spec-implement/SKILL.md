---
name: vitalia-spec-implement
description: >
  Quarto passo do SDD Vitalia. Implementa o código seguindo TDD rigoroso:
  testes escritos e aprovados antes da implementação (Red → Green → Refactor).
  Acionar APÓS as tarefas terem sido geradas e aprovadas via vitalia-spec-tasks.
  NUNCA implementar sem testes escritos e confirmados falhando primeiro.
---
<!-- integrations/agy/skills/vitalia-spec-implement/SKILL.md | Atualizado em: 05-06-2026 13:16:00(GMT-04:00) -->

# Vitalia Spec Implement

Executa o workflow em `.specify/extensions/spec-implement.md`.

## Comportamento (TDD obrigatório — Art. III)

Para cada tarefa:
1. **Red**: escrever os testes → mostrar ao usuário → confirmar que falham
2. **Green**: implementar o mínimo para os testes passarem
3. **Refactor**: limpar o código sem quebrar os testes

## Cobertura mínima obrigatória

| Camada | Mínimo |
|---|---|
| Services / Use Cases | 90% |
| Views / Controllers | 70% |
| Utilities / Helpers | 80% |
| Models (métodos customizados) | 85% |

## Regras de implementação

- Zero hardcoding — toda constante vem de ENV ou config (Art. XII)
- Queries relacionais com eager loading (Art. XVIII)
- Input validado via schema antes de processar (Art. VII)
- Nenhum commit quebra o build (Art. II)
