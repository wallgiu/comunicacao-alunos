# Supabase — View e RPCs

Migrations SQL para o projeto `data-analytics-brain` (`nvqlfhcojmcxzmkpytnw`).

## Estrutura

```
migrations/
├── 001_create_view_buyer_list_mapping.sql   # view de classificação
└── 002_create_rpcs.sql                      # 3 RPCs SECURITY DEFINER
```

## Como aplicar

### Opção 1 — SQL Editor do Supabase (mais simples)
1. Acesse o painel do projeto
2. SQL Editor → New query
3. Copie e cole o conteúdo de cada arquivo na ordem (001 → 002)
4. Execute

### Opção 2 — Supabase CLI
```bash
supabase db push
```

## Objetos criados

| Tipo | Nome | Função |
|---|---|---|
| View | `public.v_sendpulse_buyer_list_mapping` | Classifica cada venda Eduzz em (active_list_id, ex_alunos_list_id) + calcula vigência |
| RPC | `get_sendpulse_all_active_json()` | Retorna todos buyers ativos como JSONB (usada pelo initial-load) |
| RPC | `get_sendpulse_all_expired_json()` | Retorna buyers expirados (para popular ex-alunos) |
| RPC | `get_sendpulse_lists_for_product(text)` | Dado um nome de produto, retorna `(active_list_id, ex_alunos_list_id, retention_days)` |

## Dependências

A view consulta as tabelas:
- `eduzz.eduzz_sales_raw`
- `eduzz.eduzz_customers_raw`

Que são populadas pelos workflows de sync diário do Eduzz (fora do escopo deste projeto).
