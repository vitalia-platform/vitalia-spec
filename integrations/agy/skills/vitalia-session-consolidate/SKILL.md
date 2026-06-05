---
name: vitalia-session-consolidate
description: >
  Consolida os shards de todas as máquinas, reconstrói o DASHBOARD.md,
  atualiza CONTEXT.md e SESSION_HISTORY.md, e sincroniza com a nuvem via push.
  Gerencia lock distribuído para evitar conflitos entre máquinas.
  Use após vitalia-session-end, ou a qualquer momento para ver o estado global do projeto.
---
<!-- integrations/agy/skills/vitalia-session-consolidate/SKILL.md | Atualizado em: 05-06-2026 13:13:00(GMT-04:00) -->

# Vitalia Session Consolidate

Executa o workflow definido em `.specify/extensions/session-consolidate.md`.

## Comportamento

Siga **exatamente** as instruções em `.specify/extensions/session-consolidate.md`.

Resumo dos 8 passos:
1. Obter Machine ID: `python3 .specify/scripts/lib_machine.py --get-id`
2. Validar se o shard local não está desatualizado (aviso se > 1h)
3. Pull do repositório de contexto (`git pull origin main --rebase`)
4. Verificar lock no `CONSOLIDATION_LOG.md` — pausar se outra máquina estiver consolidando
5. Adquirir lock (commitar + push imediato)
6. Ler todos os shards em `shards/*.md`
7. Reconstruir `DASHBOARD.md`, atualizar `CONTEXT.md`, inserir em `SESSION_HISTORY.md`
8. Liberar lock + push final + exibir dashboard ao usuário
