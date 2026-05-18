# Projeto SendPulse — Segmentação e Automação da Base de Alunos

Reorganização completa da base de alunos no SendPulse com segmentação por família e SKU de produto, sanitização por vigência, e automação ponta a ponta via n8n + Supabase.

---

## Visão geral

O projeto resolve três dores principais:

1. **Listas desorganizadas no SendPulse** — base misturada, sem segmentação por produto, com variáveis inconsistentes (`name` vs `Name` vs `Nome`)
2. **Comunicação para clientes que já compraram** — venda relâmpago da Formação AIDE indo para alunos que já tinham comprado
3. **Falta de regras de vigência** — quem expirou ficava nas listas de ativos indefinidamente

A solução é uma arquitetura onde o **Supabase é a fonte única de verdade**: toda regra de classificação (família, SKU, vigência) vive no SQL. Workflows n8n consomem essas regras via RPCs e mantêm o SendPulse sincronizado automaticamente.

---

## Resultados em produção (abril/2026)

- **30 listas SendPulse organizadas** — 21 listas de ativos (9 família + 12 SKU) + 9 listas de ex-alunos
- **6.951 buyers ativos populados** com nome, telefone, data da última compra e data de expiração de vigência
- **3 workflows n8n em produção** rodando welcome em tempo real, cleanup diário e carga inicial sob demanda
- **Domínio `engenhariadadosacademy.com.br` autenticado** com SPF, DKIM e DMARC publicados
- **Validação amostral de 99% de match** entre SendPulse e Supabase

---

## Estrutura do projeto

```
projeto-sendpulse/
├── README.md                    # você está aqui
├── docs/                        # documentação técnica e editorial
│   ├── documentacao-sendpulse.docx     # documentação técnica completa
│   ├── guia-marketing-sendpulse.md     # guia para o time de marketing
│   ├── guia-marketing-sendpulse.pdf    # versão PDF do guia
│   └── fluxo-disparo-claude.excalidraw # fluxograma do ciclo de disparo
├── emails/                      # templates HTML branded
│   ├── email-beerops-detalhes.html     # email pré-evento BeerOps
│   ├── email-beerops-liberado.html     # email pós-evento BeerOps liberado
│   ├── email-datagenie-mas.html        # email principal DataGenie
│   ├── email-datagenie-mas-d2.html     # email D-2 com checklist
│   ├── email-datagenie-mas-d0.html     # email dia do evento
│   └── email-workshop-remarcado.html   # comunicado de remarcação
├── n8n-workflows/               # workflows exportados como JSON
│   ├── academy-sendpulse-initial-load.json
│   ├── eduzz-sale-sendpulse-welcome.json
│   └── academy-sendpulse-cleanup-expired.json
└── supabase/
    └── migrations/              # view + RPCs do Supabase
        ├── 001_create_view_buyer_list_mapping.sql
        └── 002_create_rpcs.sql
```

---

## Workflows n8n

### `academy-sendpulse-initial-load`
**Trigger:** webhook `POST /initial-load-sendpulse` ou manual.
**O que faz:** lê todos os buyers ativos do Supabase via RPC, agrupa por lista de destino, faz chunks de 100 e-mails e popula no SendPulse via API com retry e batching.
**Quando rodar:** carga inicial após mudança de regras de vigência ou de classificação de produto.

### `eduzz-sale-sendpulse-welcome`
**Trigger:** webhook do Eduzz em cada venda paga.
**O que faz:** identifica o produto comprado, chama a RPC `get_sendpulse_lists_for_product` para descobrir lista de destino, adiciona o comprador na lista correta e remove da ex-alunos correspondente (caso esteja).
**Em produção contínuo:** todas as vendas pagas via Eduzz passam por aqui.

### `academy-sendpulse-cleanup-expired`
**Trigger:** schedule diário às 10h UTC (7h BRT) ou webhook de teste.
**O que faz:** identifica buyers cuja vigência expirou (regras: Plumbers/AIDE/Bootcamp/Combo/Prática/Semana AIDE/Academy/Dataship/Sunset = 1 ano · Spark/Databricks = 2 anos), move da lista de ativos para a respectiva ex-alunos.

---

## Supabase

### View principal
**`public.v_sendpulse_buyer_list_mapping`** — classifica cada venda do Eduzz em (active_list_id, ex_alunos_list_id, retention_days) baseado em padrões ILIKE no nome do produto. Inclui as colunas calculadas `data_ultima_compra`, `vigencia_expira_em` e `is_active`.

### RPCs (SECURITY DEFINER)
- **`get_sendpulse_all_active_json()`** — retorna JSONB com todos os ativos. Usada pelo initial-load.
- **`get_sendpulse_all_expired_json()`** — retorna JSONB com expirados. Usada para popular ex-alunos.
- **`get_sendpulse_lists_for_product(p_product_name text)`** — dado um nome de produto, retorna `(active_list_id, ex_alunos_list_id, retention_days)`. Usada pelo welcome em tempo real.

---

## Templates de e-mail

Todos os emails seguem a identidade visual da **Formação Spark & Databricks** (paleta flame: amber `#FFA628` → coral `#FF6028` → lava red `#FF3621` → spark orange `#E25A1C` em fundo deep `#0B1419` com cards `#1B3139`). Tipografia Urbanist. Variáveis SendPulse: `{{name}}` e `{{unsubscribe_url}}`.

Cada template foi pensado para um momento específico do funil:
- **Pré-evento** com detalhes do conteúdo e CTA para a plataforma
- **D-2 / D-1** com checklist de preparação técnica
- **D0** com badge "ao vivo" e box de acesso ao Zoom destacado
- **Pós-evento** comunicando liberação do replay
- **Comunicado** sóbrio para remarcações ou avisos críticos

Todos têm pre-header otimizado para evitar o problema dos três pontinhos do Gmail e melhorar o preview na caixa de entrada.

---

## Como importar os workflows no n8n

1. Acesse a instância n8n (https://owshq.app.n8n.cloud)
2. **Workflows → Import from File**
3. Selecione o JSON desejado de `n8n-workflows/`
4. Configure as credenciais (referenciadas pelo nome no JSON):
   - `supabase-data-analytics-brain-anon` (HTTP Header Auth com a anon key)
   - `sendpulse-api-agenda` (SendPulse API credentials)
   - `sendpulse-oauth2-api-agenda` (SendPulse OAuth2)
5. Ative o workflow

---

## Como aplicar as migrations no Supabase

```bash
# Via Supabase CLI
supabase db push

# Ou via SQL Editor no painel
# 1. Copie o conteúdo de cada arquivo .sql
# 2. Cole no SQL Editor
# 3. Execute na ordem (001 → 002)
```

---

## Documentação completa

- **`docs/documentacao-sendpulse.docx`** — documentação técnica oficial com histórico de mudanças, regras de negócio, validações e aprendizados sobre o SendPulse
- **`docs/guia-marketing-sendpulse.pdf`** — guia editorial para o time de marketing com 20 cenários de campanha, templates de pergunta para Claude Code e protocolo de aprovação de disparo
- **`docs/fluxo-disparo-claude.excalidraw`** — fluxograma editável do ciclo de validação para disparos via Claude Code

---

## Contato

Mantenedora: **Giulia Parede** · giulia.luca@owshq.com
