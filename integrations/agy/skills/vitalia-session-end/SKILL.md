---
name: vitalia-session-end
description: >
  Encerra a sessão de trabalho no Vitalia Kit em 4 fases: avaliação proativa
  de melhorias do kit, reflexão HITL da sessão, commit do repositório raiz,
  e gravação do shard local. NÃO sincroniza com a nuvem — use vitalia-session-consolidate após.
  Use ao terminar qualquer sessão de trabalho num projeto com o Vitalia Kit instalado.
---
<!-- integrations/agy/skills/vitalia-session-end/SKILL.md | Atualizado em: 05-06-2026 13:13:00(GMT-04:00) -->

# Vitalia Session End

Executa o workflow definido em `.specify/extensions/session-end.md`.

## Comportamento

Siga **exatamente** as instruções em `.specify/extensions/session-end.md`.

Resumo das 4 fases:
1. **Avaliação proativa**: identificar melhorias no kit (erros repetidos, processos manuais)
2. **Reflexão HITL**: propor resumo da sessão ao usuário e AGUARDAR aprovação
3. **Commit do repositório raiz**: sanitizar e commitar (sem push do contexto)
4. **Shard local**: gravar `.specify/memory/session/shards/[MACHINE_ID].md` e commitar localmente

**Não executar `git push` no repositório de contexto — isso é responsabilidade do vitalia-session-consolidate.**
