---
name: vitalia-session-start
description: >
  Inicia sessão de trabalho no Vitalia Kit. Valida o ambiente (.specify/),
  verifica sincronia do contexto (ETag), lê CONTEXT.md e sprint_atual.md,
  e apresenta o estado atual do projeto com o próximo passo prioritário.
  Use ao começar qualquer sessão de trabalho num projeto com o Vitalia Kit instalado.
---
<!-- integrations/agy/skills/vitalia-session-start/SKILL.md | Atualizado em: 05-06-2026 13:13:00(GMT-04:00) -->

# Vitalia Session Start

Executa o workflow definido em `.specify/extensions/session-start.md`.

## Setup Obrigatório

O projeto deve ter o Vitalia Kit instalado:
```bash
bash ~/vitalia-spec/scripts/install.sh
```

## Comportamento

Siga **exatamente** as instruções em `.specify/extensions/session-start.md`.

Resumo dos passos:
1. Executar `python3 .specify/scripts/validate-kit.py --target .`
2. Se houver conflito de ETag: executar `bash .specify/scripts/session-resolve.sh`
3. Ler `.specify/memory/session/CONTEXT.md` e `sprint_atual.md`
4. Apresentar briefing: status, concluído recentemente, P0 (próximo passo), constraints ativos
5. Perguntar ao usuário se confirma o foco ou tem outro objetivo para a sessão
