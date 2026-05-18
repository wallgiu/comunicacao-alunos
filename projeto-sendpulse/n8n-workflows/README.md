# Workflows n8n — SendPulse

Workflows exportados como JSON, prontos para importar na instância n8n.

| Arquivo | Trigger | Função |
|---|---|---|
| `academy-sendpulse-initial-load.json` | Manual + Webhook `POST /initial-load-sendpulse` | Carga inicial em massa de buyers ativos do Supabase para as listas SendPulse |
| `eduzz-sale-sendpulse-welcome.json` | Webhook `POST /eduzz-sale` (Eduzz) | Welcome em tempo real — adiciona comprador na lista correta e remove de ex-alunos |
| `academy-sendpulse-cleanup-expired.json` | Schedule diário 10h UTC + Webhook teste | Move buyers expirados de ativos para ex-alunos conforme regras de vigência |

## Importar no n8n

1. Acesse https://owshq.app.n8n.cloud
2. **Workflows → Import from File**
3. Selecione o JSON
4. Configure credenciais referenciadas (pelo nome):
   - `supabase-data-analytics-brain-anon`
   - `sendpulse-api-agenda`
   - `sendpulse-oauth2-api-agenda`
5. Ative o workflow

## Credenciais

Os JSONs **NÃO contêm credenciais** — apenas referências por nome. Você precisa criar essas credenciais manualmente na sua instância n8n antes de importar (ou reusar as existentes se já tiver com os mesmos nomes).
