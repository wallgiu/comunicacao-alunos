# Templates de E-mail

Templates HTML branded da Formação Spark & Databricks, prontos para usar no SendPulse.

| Arquivo | Momento do funil | Tipo |
|---|---|---|
| `email-beerops-detalhes.html` | Pré-evento (D-7 do BeerOps) | Promocional — detalhes dos 4 blocos |
| `email-beerops-liberado.html` | Pós-evento BeerOps | Anúncio — workshop liberado na plataforma |
| `email-datagenie-mas.html` | Pré-evento principal DataGenie | Promocional — hot take + 5 fases |
| `email-datagenie-mas-d2.html` | D-2 do DataGenie | Lembrete — checklist de preparação técnica |
| `email-datagenie-mas-d0.html` | Dia do evento DataGenie | Urgência — badge "ao vivo" + box de acesso Zoom |
| `email-workshop-remarcado.html` | Avulso | Comunicado — workshop remarcado |

## Identidade visual

- Background: `#0B1419` (Deep) + `#1B3139` (Oxide cards)
- Gradient flame: `#FFA628` → `#FF6028` → `#FF3621` → `#E25A1C`
- Tipografia: Urbanist (fallback sans-serif)
- Dark-first

## Variáveis SendPulse usadas

- `{{name}}` — nome do destinatário (variável padronizada em todas as listas)
- `{{unsubscribe_url}}` — link de descadastro
- `{{banner_url}}` — placeholder para imagem hero (apenas em emails que tinham banner)

## Pre-header

Todos os templates incluem pre-header invisível que:
1. Aparece como descrição na caixa de entrada ao lado do assunto (melhora taxa de abertura)
2. Impede o Gmail de comprimir o conteúdo nos "três pontinhos" característicos do "modo conversa"

## Como usar no SendPulse

1. **Templates → Criar template → HTML**
2. Cole o conteúdo do arquivo `.html`
3. Faça preview e teste antes de disparar
4. Substitua `{{banner_url}}` (se houver) pelo link da imagem hospedada
5. Configure remetente como `comunicacao@engenhariadadosacademy.com.br`

## Estrutura editorial

Todos os templates seguem o padrão:

1. Header com nome da Engenharia de Dados Academy + tag "Formação Spark & Databricks"
2. (Opcional) Badge contextual — `🟢 Workshop liberado`, `🔴 Ao vivo`, `📅 Comunicado`
3. Saudação personalizada com `{{name}}`
4. Card hero do evento com data
5. Conteúdo principal — pitch, detalhes, recap
6. CTA único e dominante em pill com gradient
7. Sign-off "Time Engenharia de Dados Academy"
8. Footer com unsubscribe e disclaimers

Voz aplicada: dark-first, casual-técnica, direta, opinionated (sem corporativismo).
