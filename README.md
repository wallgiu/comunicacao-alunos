# Comunicação com Alunos

Monorepo da Engenharia de Dados Academy com projetos de automação de comunicação por e-mail, segmentação de base e integração entre Eduzz · Supabase · n8n · SendPulse.

---

## Projetos

| Projeto | Descrição | Status |
|---|---|---|
| [`projeto-sendpulse/`](./projeto-sendpulse/) | Segmentação da base de alunos no SendPulse, regras de vigência por família de produto, workflows de carga inicial, welcome de venda e cleanup diário de expirados. Inclui guia editorial para o time de marketing e templates de e-mail branded. | ✅ Em produção |

---

## Stack comum

- **Supabase** (`data-analytics-brain` — projeto `nvqlfhcojmcxzmkpytnw`) — fonte única de verdade dos dados de vendas Eduzz + classificações para segmentação
- **n8n** (`owshq.app.n8n.cloud`) — orquestração de webhooks, sync diário e disparos automatizados
- **SendPulse** — provider de e-mail marketing
- **Eduzz** — plataforma de venda dos produtos

---

## Como contribuir

1. Clone o repositório:
   ```bash
   git clone https://github.com/wallgiu/comunicacao-alunos.git
   cd comunicacao-alunos
   ```
2. Abra o README do projeto que você quer mexer.
3. Faça suas alterações em um branch novo (`feature/nome-da-feature`).
4. Abra Pull Request com descrição clara do que mudou e por quê.

---

*Mantido por Giulia Parede · Engenharia de Dados Academy*
