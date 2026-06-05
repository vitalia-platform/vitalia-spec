---
name: vitalia-science-review
description: >
  Revisão científica de conteúdo de saúde gerado pela IA. Paralisa a implementação
  técnica e aciona a camada de especialistas científicos para verificar claims clínicos,
  fórmulas fisiológicas, recomendações de saúde ou qualquer conteúdo médico antes
  de ir para produção. Implementa o Gate II da Constituição (Art. IX).
---
<!-- integrations/agy/skills/vitalia-science-review/SKILL.md | Atualizado em: 05-06-2026 13:16:00(GMT-04:00) -->

# Vitalia Science Review

Executa o workflow em `.specify/extensions/science-review.md`.

## Comportamento

1. Identificar o conteúdo clínico a revisar
2. Detectar o domínio científico (fisiologia, endocrinologia, nutrição, etc.)
3. Acionar o especialista adequado para revisão (via smart-routing)
4. Verificar:
   - Todos os claims têm fonte com nível de evidência A, B ou C (Art. X)
   - Disclaimer educacional presente (Art. XI)
   - Nenhuma promessa terapêutica ou diagnóstica
5. Atualizar o status do conteúdo: `DRAFT` → `REVIEW`
6. Se aprovado pelo especialista: marcar como pronto para revisão de profissional humano
7. **NUNCA** marcar como `ACTIVE` sem aprovação de profissional de saúde humano (Art. IX)
