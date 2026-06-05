---
description: >
  Gate de segurança clínica da Vitalia. Avalia o risco de uma spec em domínio de saúde
  (Gate I — Artigo VIII) e verifica pré-condições de publicação de conteúdo médico
  (Gate II — Artigo IX). Acionado automaticamente após /spec-specify em domínios de saúde.
---
<!-- kit-v2/extensions/medical-gate.md | Atualizado em: 05-06-2026 12:54:00(GMT-04:00) -->

# /medical-gate — Gate de Segurança Clínica

$ARGUMENTS

---

## Propósito

Implementa os **Artigos VIII e IX da Constituição Vitalia v1.0**.

Nenhuma feature de saúde avança para `/spec-plan` sem passar pelo Gate I.
Nenhum conteúdo médico vai para produção sem passar pelo Gate II.

A lógica completa está em:
`kit-v2/extensions/lib/science/vitalia-medical-gate/SKILL.md`

---

## Comportamento

### Modo Automático (após `/spec-specify`)

O agente detecta silenciosamente se a spec envolve domínios de saúde.
Se sim, executa o Gate I antes de liberar `/spec-plan`.

**Domínios que disparam o gate automaticamente:**
diagnóstico · sintomas · condições médicas · protocolos de tratamento · suplementação ·
biomarcadores · nutrição individualizada · dosagens · planos personalizados de saúde /
wellness / fitness · fórmulas fisiológicas exibidas ao usuário (FC, VO₂max, IMC, etc.)

### Modo Manual

```
/medical-gate                        → avalia a spec mais recente
/medical-gate --spec=[nome].spec.md  → avalia spec específica
/medical-gate --gate=publicacao      → ativa apenas o Gate II (aprovação de conteúdo)
```

---

## Gate I — Avaliação de Risco (Artigo VIII)

1. Lê a spec indicada e aplica a matriz de risco do `SKILL.md`
2. Exibe o painel de avaliação ao usuário com score e nível
3. Para **LOW**: libera `/spec-plan` imediatamente
4. Para **MEDIUM**: propõe constraints MC-NNN e aguarda aprovação HITL
5. Para **HIGH**: exige confirmação de revisão por profissional de saúde humano

---

## Gate II — Aprovação de Publicação (Artigo IX)

1. Verifica se o conteúdo médico tem status `ACTIVE`
2. Confirma presença do disclaimer obrigatório
3. Confirma que todos os MC-NNN têm fonte científica com nível A, B ou C
4. Confirma aprovação de profissional de saúde registrada
5. Bloqueia ou libera a publicação

---

## Catálogo de Constraints

Constraints globais disponíveis: `kit-v2/extensions/lib/science/vitalia-medical-gate/constraints-schema.yml`

Constraints ativos na spec ficam na seção `## Medical Constraints` do arquivo `.spec.md`.
