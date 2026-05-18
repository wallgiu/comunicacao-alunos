# comunicacao-alunos
 
Monorepo com as ferramentas de comunicação com alunos da Engenharia de Dados Academy.
 
## Objetivo
 
Centralizar, versionar e organizar todos os fluxos automatizados (n8n) responsáveis por enviar avisos, lembretes e comunicados aos alunos por diferentes canais. Cada canal vive em sua própria pasta, com seus workflows, templates e documentação, mas todos compartilham o mesmo objetivo: garantir que o aluno receba a informação certa, no canal certo, na hora certa.
 
## Estrutura
 
```
comunicacao-alunos/
├── email-sender/          Ferramenta de envio de e-mails (n8n)
│   ├── workflows/         Workflows exportados em JSON
│   ├── templates/         Templates HTML / corpo das mensagens
│   └── README.md          Como usar, credenciais necessárias, fluxo
│
├── whatsapp-sender/       Ferramenta de envio de WhatsApp (n8n)
│   ├── workflows/         Workflows exportados em JSON
│   ├── templates/         Templates de mensagem (texto / variáveis)
│   └── README.md          Como usar, credenciais necessárias, fluxo
│
├── docs/                  Documentação geral do monorepo
│   ├── arquitetura.md     Visão geral, como os fluxos se conectam
│   ├── convencoes.md      Padrões de nome, tags, versionamento
│   └── runbook.md         O que fazer quando algo falha
│
├── .gitignore
└── README.md              (este arquivo)
```
 
## Projetos
 
### email-sender
Workflows n8n que disparam e-mails para listas de alunos. Casos de uso típicos:
 
- Lembrete de aula ao vivo
- Confirmação de inscrição
- Avisos de plataforma (manutenção, novo conteúdo)
- Newsletter da formação
### whatsapp-sender
Workflows n8n que enviam mensagens via WhatsApp (UnniChat / API oficial). Casos de uso típicos:
 
- Boas-vindas após inscrição
- Lembrete de live com link
- Mensagens de reativação
- Broadcasts segmentados por tag
### docs
Documentação que vale para os dois projetos: arquitetura, convenções de nomenclatura, runbook de incidentes.
 
## Como contribuir
 
1. Crie uma branch a partir de `main` com o padrão `feat/<canal>-<descricao-curta>` ou `fix/<canal>-<descricao>`.
2. Faça as alterações dentro da pasta do canal correspondente.
3. Exporte o workflow do n8n e salve em `workflows/` com nome descritivo (ver `docs/convencoes.md`).
4. Atualize o README da pasta do canal se mudar o comportamento.
5. Abra um PR descrevendo o que mudou e qual é o impacto para o aluno.
## Stack
 
- **n8n** (owshq.app.n8n.cloud) — orquestração dos fluxos
- **UnniChat** — API de WhatsApp oficial
- **SendPulse / SMTP** — envio de e-mails
## Convenções rápidas
 
- Workflows seguem o padrão de nomenclatura definido em `docs/convencoes.md`
- Credenciais nunca vão para o repo — ficam no n8n
- Mudanças em produção sempre passam por PR
## Status
 
| Canal    | Status        | Responsável |
|----------|---------------|-------------|
| Email    | Em produção   | Giu         |
| WhatsApp | Em produção   | Giu         |
---

*Mantido por Giulia Parede · Engenharia de Dados Academy*
