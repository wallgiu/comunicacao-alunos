# Guia de Marketing — SendPulse + Claude Code

**Engenharia de Dados Academy**
Versão 1.0 · 29 de Abril de 2026

Este guia ajuda o time de marketing a definir o público correto antes de cada campanha de e-mail. Para cada cenário, há uma **lógica de negócio** (em linguagem simples) e uma **pergunta-template** que você pode copiar e colar direto no Claude Code para receber a lista de contatos correta.

---

## Princípio central — funil de exclusão

Toda campanha de venda deve **excluir quem já comprou o produto que está sendo ofertado**. Pessoas que avançaram no funil para um produto de tier mais alto não devem receber pitch do produto de tier mais baixo.

**Visualização do funil:**

```
LEAD (topo)            →  E-books, Semana AIDE, Workshops, Fundamentos
                          ↓
MEIO                   →  AI Data Engineer na Prática (Claude Code)
                          ↓
PRODUTO PRINCIPAL      →  Formação AIDE
                          ↓
UPSELLS / PREMIUM      →  Bootcamp AIDE, Combo AIDE
```

Mesma lógica para a família Spark/Databricks (Semana Databricks → Formação Spark) e para Plumbers (lead → Comunidade Plumbers).

---

## Mapa de listas SendPulse (referência rápida)

### Família AIDE (AI Data Engineer)

| Lista | ID | Volume | Função |
|---|---|---:|---|
| `alunos-formacao-ai-native-engineer-ativos` | 641808 | ~319 | Cliente da Formação principal |
| `alunos-bootcamp-aide-ativos` | 647043 | ~186 | Cliente do Bootcamp (upsell) |
| `alunos-combo-aide-ativos` | 647044 | ~50 | Cliente do Combo (Formação + Bootcamp) |
| `alunos-ai-data-engineer-pratica-ativos` | 647045 | ~208 | Cliente da Prática com Claude Code |
| `alunos-semana-aide-ativos` | 641807 | ~898 | Aluno da Semana (lead aquecido) |
| `sku-ebook-nascimento-aide` | 647063 | ~40 | Lead de e-book |
| `sku-prompt-engineering-rag-genai` | 647059 | ~453 | Cliente de curso GenAI relacionado |
| `sku-workshop-agentic-ia` | 647060 | ~320 | Cliente de workshop relacionado |
| `ex-alunos-formacao-ai-native-engineer` | 644164 | 0 | Quem expirou na Formação |
| `ex-alunos-semana-aide` | 644165 | 0 | Quem comprou a Semana há mais de 1 ano |
| `ex-alunos-bootcamp-aide` | 647048 | 0 | Quem expirou no Bootcamp |
| `ex-alunos-combo-aide` | 647049 | 0 | Quem expirou no Combo |
| `ex-alunos-ai-data-engineer-pratica` | 647050 | 0 | Quem expirou na Prática |

### Família Spark / Databricks

| Lista | ID | Volume | Função |
|---|---|---:|---|
| `alunos-formacao-spark-databricks-ativos` | 641540 | ~904 | Cliente da Formação (vigência 2 anos) |
| `sku-semana-databricks` | 647055 | ~492 | Lead da Semana original |
| `sku-semana-databricks-2-0-ex` | 647053 | ~563 | Lead da Semana 2.0 externo |
| `sku-semana-databricks-2-0-it` | 647054 | ~368 | Lead da Semana 2.0 tráfego interno |
| `sku-semana-data-vault` | 647056 | ~425 | Lead Semana Data Vault |
| `sku-workshops-tecnicos` | 647064 | ~1.501 | Lead de workshops técnicos diversos |
| `sku-fundamentos-engenharia-dados` | 647061 | ~104 | Lead de fundamentos |
| `ex-alunos-formacao-spark-databricks` | 644167 | ~7 | Quem expirou na Formação Spark |

### Família Plumbers (Comunidade)

| Lista | ID | Volume | Função |
|---|---|---:|---|
| `alunos-comunidade-plumbers-ativos` | 641804 | ~327 | Membro ativo (vigência 1 ano) |
| `ex-alunos-comunidade-plumbers` | 644166 | ~27 | Ex-membro |

### Família Academy 2.0

| Lista | ID | Volume | Função |
|---|---|---:|---|
| `alunos-academy-2-0-ativos` | 647046 | ~234 | Cliente Academy 2.0 |
| `ex-alunos-academy-2-0` | 647051 | ~13 | Ex-cliente Academy 2.0 |

### Família Dataship

| Lista | ID | Volume | Função |
|---|---|---:|---|
| `alunos-dataship-ativos` | 647047 | ~26 | Cliente Dataship |
| `ex-alunos-dataship` | 647052 | 0 | Ex-cliente Dataship |

### Eventos pontuais

| Lista | ID | Volume | Função |
|---|---|---:|---|
| `sku-sunset-plumbers-premium` | 647057 | ~27 | Aluno Sunset 2025 - Premium (Plumbers) |
| `sku-sunset-externo-standard` | 647058 | ~17 | Aluno Sunset 2025 - Standard (público externo) |
| `sku-ebook-processos-seletivos` | 647062 | ~69 | Lead e-book carreira |

---

## Cenários práticos — lógica + pergunta pronta

### 1. Lançamento de nova turma — Formação AIDE

**Quando usar:** abriu inscrições para uma nova turma da Formação AIDE e quer aproveitar a base aquecida.

**Lógica:** oferecer para quem demonstrou interesse em AI/Engenharia de Dados (Semana AIDE, e-books, workshops da família) mas ainda não comprou nenhum produto da família AIDE.

**Pergunta para o Claude Code:**
> Me liste os contatos que estão em pelo menos uma das listas `alunos-semana-aide-ativos`, `sku-ebook-nascimento-aide`, `sku-prompt-engineering-rag-genai`, `sku-workshop-agentic-ia`, `sku-fundamentos-engenharia-dados`, ou `ex-alunos-formacao-ai-native-engineer`, mas que NÃO estão em nenhuma das listas `alunos-formacao-ai-native-engineer-ativos`, `alunos-bootcamp-aide-ativos`, `alunos-combo-aide-ativos`, `alunos-ai-data-engineer-pratica-ativos`. Retorne email, name, data_ultima_compra, telefone.

---

### 2. Lançamento de nova turma — Formação Spark & Databricks

**Quando usar:** abriu inscrições para nova turma Spark.

**Lógica:** oferecer para leads de Semanas Databricks e Workshops, mas excluir quem já tem a Formação Spark (vigência 2 anos cobre quase todo histórico).

**Pergunta para o Claude Code:**
> Me liste os contatos que estão em pelo menos uma das listas `sku-semana-databricks-2-0-ex`, `sku-semana-databricks-2-0-it`, `sku-semana-databricks`, `sku-semana-data-vault`, `sku-workshops-tecnicos`, `sku-fundamentos-engenharia-dados`, ou `ex-alunos-formacao-spark-databricks`, mas que NÃO estão em `alunos-formacao-spark-databricks-ativos`. Retorne email, name, data_ultima_compra, telefone.

---

### 3. Black Friday — oferta da Formação AIDE com desconto

**Quando usar:** vai dar desconto agressivo na Formação AIDE em data sazonal.

**Lógica:** oferecer pra base inteira, exceto quem já tem qualquer produto da família AIDE (cliente AIDE que recebe desconto retroativo fica irritado).

**Pergunta para o Claude Code:**
> Me liste todos os contatos únicos da base SendPulse que NÃO estão em nenhuma das listas `alunos-formacao-ai-native-engineer-ativos`, `alunos-bootcamp-aide-ativos`, `alunos-combo-aide-ativos`, `alunos-ai-data-engineer-pratica-ativos`. Retorne email, name, telefone.

---

### 4. Black Friday — oferta da Formação Spark com desconto

**Pergunta para o Claude Code:**
> Me liste todos os contatos únicos da base SendPulse que NÃO estão em `alunos-formacao-spark-databricks-ativos`. Retorne email, name, telefone.

---

### 5. Upsell — AIDE → Bootcamp

**Quando usar:** quer vender o Bootcamp AIDE para clientes da Formação que ainda não pegaram.

**Lógica:** oferecer Bootcamp para quem tem Formação AIDE pura, ainda não tem Bootcamp, ainda não tem Combo.

**Pergunta para o Claude Code:**
> Me liste os contatos que estão em `alunos-formacao-ai-native-engineer-ativos` mas NÃO estão em `alunos-bootcamp-aide-ativos` nem em `alunos-combo-aide-ativos`. Retorne email, name, data_ultima_compra, telefone.

---

### 6. Upsell — AIDE → Combo (Formação + Bootcamp pacote)

**Pergunta para o Claude Code:**
> Me liste os contatos que estão em `alunos-formacao-ai-native-engineer-ativos` ou em `alunos-bootcamp-aide-ativos`, mas NÃO estão em `alunos-combo-aide-ativos`. Retorne email, name, data_ultima_compra, telefone.

---

### 7. Cross-sell — cliente Spark → oferta AIDE

**Quando usar:** quer oferecer AIDE para data engineers que já fizeram Spark com a gente.

**Lógica:** quem tem Spark mas não tem nenhum produto AIDE é o público mais natural pra evoluir pra AI.

**Pergunta para o Claude Code:**
> Me liste os contatos que estão em `alunos-formacao-spark-databricks-ativos` mas NÃO estão em nenhuma das listas `alunos-formacao-ai-native-engineer-ativos`, `alunos-bootcamp-aide-ativos`, `alunos-combo-aide-ativos`, `alunos-ai-data-engineer-pratica-ativos`. Retorne email, name, telefone.

---

### 8. Cross-sell — cliente AIDE → oferta Spark

**Pergunta para o Claude Code:**
> Me liste os contatos que estão em `alunos-formacao-ai-native-engineer-ativos` mas NÃO estão em `alunos-formacao-spark-databricks-ativos`. Retorne email, name, telefone.

---

### 9. Cross-sell — qualquer cliente → Comunidade Plumbers

**Quando usar:** Plumbers como complemento natural a qualquer formação.

**Pergunta para o Claude Code:**
> Me liste os contatos que estão em qualquer lista que termine com `-ativos` (qualquer formação) mas NÃO estão em `alunos-comunidade-plumbers-ativos`. Retorne email, name, telefone.

---

### 10. Reativação — ex-alunos Plumbers

**Quando usar:** quer trazer de volta quem perdeu acesso à Comunidade.

**Lógica:** comunicar com quem expirou e ainda não renovou.

**Pergunta para o Claude Code:**
> Me liste os contatos que estão em `ex-alunos-comunidade-plumbers` mas NÃO estão em `alunos-comunidade-plumbers-ativos`. Retorne email, name, data_ultima_compra, telefone.

---

### 11. Reativação — ex-alunos Spark

**Pergunta para o Claude Code:**
> Me liste os contatos que estão em `ex-alunos-formacao-spark-databricks` mas NÃO estão em `alunos-formacao-spark-databricks-ativos`. Retorne email, name, data_ultima_compra, telefone.

---

### 12. Reativação — ex-alunos AIDE (qualquer produto da família)

**Pergunta para o Claude Code:**
> Me liste os contatos que estão em pelo menos uma das listas `ex-alunos-formacao-ai-native-engineer`, `ex-alunos-bootcamp-aide`, `ex-alunos-combo-aide`, `ex-alunos-ai-data-engineer-pratica`, mas NÃO estão em nenhuma das listas ativos da família AIDE. Retorne email, name, data_ultima_compra, telefone.

---

### 13. Renovação — Plumbers com vigência expirando em 60 dias

**Quando usar:** aviso de renovação para quem está perto de expirar (campanha interna, não promocional).

**Lógica:** filtrar pela variável `vigencia_expira_em` da lista.

**Pergunta para o Claude Code:**
> Me liste os contatos da lista `alunos-comunidade-plumbers-ativos` cujo `vigencia_expira_em` está nos próximos 60 dias a partir de hoje. Retorne email, name, vigencia_expira_em, telefone.

---

### 14. Renovação — Formação AIDE com vigência expirando

**Pergunta para o Claude Code:**
> Me liste os contatos da lista `alunos-formacao-ai-native-engineer-ativos` cujo `vigencia_expira_em` está nos próximos 30 dias a partir de hoje. Retorne email, name, vigencia_expira_em, telefone.

---

### 15. Renovação — Formação Spark com vigência expirando

**Pergunta para o Claude Code:**
> Me liste os contatos da lista `alunos-formacao-spark-databricks-ativos` cujo `vigencia_expira_em` está nos próximos 30 dias a partir de hoje. Retorne email, name, vigencia_expira_em, telefone.

---

### 16. Newsletter geral — conteúdo de valor para toda a base

**Quando usar:** newsletter mensal, dicas técnicas, conteúdo educacional sem CTA de venda.

**Lógica:** enviar para todos os contatos únicos de todas as listas (sem exclusões).

**Pergunta para o Claude Code:**
> Me liste todos os contatos únicos de todas as listas ativos do SendPulse, deduplicados por email. Retorne email, name, telefone.

---

### 17. Conteúdo técnico — específico de Spark/Databricks

**Pergunta para o Claude Code:**
> Me liste os contatos únicos que estão em pelo menos uma das listas `alunos-formacao-spark-databricks-ativos`, `sku-semana-databricks`, `sku-semana-databricks-2-0-ex`, `sku-semana-databricks-2-0-it`, `sku-semana-data-vault`, ou `ex-alunos-formacao-spark-databricks`. Retorne email, name, telefone.

---

### 18. Conteúdo técnico — específico de AI/AIDE

**Pergunta para o Claude Code:**
> Me liste os contatos únicos que estão em pelo menos uma das listas da família AIDE (`alunos-formacao-ai-native-engineer-ativos`, `alunos-bootcamp-aide-ativos`, `alunos-combo-aide-ativos`, `alunos-ai-data-engineer-pratica-ativos`, `alunos-semana-aide-ativos`, `sku-ebook-nascimento-aide`, `sku-prompt-engineering-rag-genai`, `sku-workshop-agentic-ia`). Retorne email, name, telefone.

---

### 19. Conteúdo "premium" — apenas clientes pagantes

**Quando usar:** material exclusivo para quem comprou produto pago (não enviar para leads de eventos gratuitos ou semana barata).

**Pergunta para o Claude Code:**
> Me liste os contatos únicos que estão em pelo menos uma das listas que começam com `alunos-` e terminam com `-ativos` (todas as 9 famílias de alunos pagantes). Retorne email, name, telefone.

---

### 20. Análise pré-campanha — quantificar overlap

**Quando usar:** antes de disparar uma campanha, quer saber quantos serão impactados após exclusões.

**Pergunta para o Claude Code:**
> Quantos contatos únicos resultam da seguinte regra: estão em [LISTA ALVO] e NÃO estão em [LISTA EXCLUSÃO 1] nem [LISTA EXCLUSÃO 2]. Quero o total e uma amostra de 10 contatos.

---

## Templates "do" / "don't"

### ✅ Faça assim (gera bons resultados)

- **Sempre nomeie a lista alvo e a lista de exclusão explicitamente.** Use o nome técnico (ex: `alunos-formacao-ai-native-engineer-ativos`), não apelidos.
- **Especifique os campos de retorno.** "Retorne email, name, telefone, data_ultima_compra" — assim você já recebe pronto pra importar como CSV.
- **Antes de disparar, peça contagem.** "Quantos contatos resultam dessa regra?" — você valida o tamanho antes de comprometer envio.
- **Use a variável `vigencia_expira_em` para campanhas de renovação.** É a forma certa de filtrar quem está perto de expirar.
- **Para campanhas de venda, sempre exclua TODOS os tiers acima do produto ofertado.** Não só o produto exato.

### ❌ Evite (causa problemas)

- "Mande para todos os alunos" — sem especificar quem é "todos", o resultado é ambíguo. Diga sempre "todos os contatos únicos das listas X, Y e Z".
- "Mande pra Semana AIDE" — falta a exclusão. 19% dessa lista já comprou a Formação. Sempre adicione "exceto quem está em [família AIDE]".
- "Tira os repetidos" — diga "deduplique por email" para ser específico.
- Criar listas de campanha manualmente no SendPulse copiando emails — em vez disso, exporte pelo Claude Code (que aplica a regra correta) e importe como segmento de envio.
- Esquecer das listas de ex-alunos em campanhas de venda — quem expirou também é candidato relevante (e provavelmente quer voltar).

---

## Variáveis disponíveis em todo contato

Toda lista do SendPulse tem essas variáveis populadas para todos os contatos ativos importados via Supabase:

| Variável | Tipo | Exemplo | Uso em template |
|---|---|---|---|
| `name` | string | "João Silva" | `{{name}}` para personalização |
| `phone` | nativo | 5511999998888 | (campo nativo, não variável) |
| `data_ultima_compra` | string YYYY-MM-DD | "2026-04-18" | `{{data_ultima_compra}}` |
| `vigencia_expira_em` | string YYYY-MM-DD | "2027-04-18" | `{{vigencia_expira_em}}` |

**Exemplos de uso em templates:**

```
Olá, {{name}}!

Sua assinatura na Comunidade Plumbers expira em {{vigencia_expira_em}}.

Garanta sua renovação antes dessa data: [link]
```

```
Oi {{name}}, faz {{data_ultima_compra}} que você comprou conosco.

Que tal dar o próximo passo? Conheça o Bootcamp AIDE: [link]
```

---

## Fluxo recomendado para uma nova campanha

1. **Definir o objetivo:** que produto quer vender? Qual ação espera do destinatário?
2. **Identificar o cenário** neste guia (1-20). Se nenhum bater 100%, adapte o mais próximo.
3. **Copiar a pergunta-template** para o Claude Code, ajustando se necessário.
4. **Pedir contagem primeiro** ("Quantos contatos resultam disso?") — valida que a regra está certa antes de exportar lista grande.
5. **Pedir amostra de 10 contatos** — confere que dados batem com expectativa.
6. **Exportar lista completa** para CSV ou JSON.
7. **Subir no SendPulse** como segmento da campanha (ou usar diretamente como filtro).
8. **Disparar a campanha.**

---

## Disparo direto pelo Claude (automatizado ponta a ponta)

Você pode pedir pro Claude **calcular o público + criar a campanha + disparar tudo de uma vez**, sem precisar entrar manualmente no SendPulse. Esta seção explica como funciona, o que pedir, e quais validações o Claude sempre faz antes de disparar.

### Como o Claude executa um disparo

Como o MCP do SendPulse não expõe a "exclusão nativa" no endpoint de criar campanha, o Claude resolve isso criando uma **lista temporária** no SendPulse com a regra já aplicada. Sequência:

1. Calcula o público via Supabase (lista alvo MENOS listas de exclusão).
2. Mostra pra você o tamanho do público + amostra de 3-5 contatos.
3. **Pede sua confirmação explícita** antes de tocar no SendPulse.
4. Cria uma lista temporária no SendPulse com nome `temp-<campanha>-<data>` e popula com os contatos calculados.
5. Cria a campanha no SendPulse apontando pra essa lista temporária + template + remetente.
6. Dispara (ou agenda, se você pediu agendamento).
7. Reporta de volta: link da campanha, status, e oferece deletar a lista temporária ou manter pra auditoria.

### Pergunta-template para disparo direto

```
Claude, dispara uma campanha:

- Nome: [ex: "lancamento-aide-maio-2026"]
- Template: [nome do template já existente no SendPulse]
- Assunto: [linha de assunto]
- Remetente: comunicacao@engenhariadadosacademy.com.br
- Público alvo: [descrição em português, ex: "alunos da Semana AIDE
  que ainda não compraram a Formação AIDE, Bootcamp, Combo nem Prática"]
- Agendamento: [agora / "hoje às 14h" / "amanhã às 9h"]

Antes de disparar:
- Me mostra o tamanho final do público
- Me mostra 5 contatos de amostra pra eu validar
- Espera minha confirmação
```

### Exemplo prático real

**Pergunta do marketing:**

> Claude, dispara uma campanha pra venda relâmpago da Formação AIDE.
>
> - Template: `lancamento-aide-maio-2026`
> - Assunto: "Última chance: Formação AIDE com 30% off"
> - Remetente: `comunicacao@engenhariadadosacademy.com.br`
> - Público: alunos da Semana AIDE que ainda não têm a Formação AIDE, Bootcamp, Combo nem Prática
> - Agendamento: hoje às 14h
>
> Antes de disparar, me mostra o tamanho do público e 5 contatos de amostra.

**O que o Claude vai responder:**

> Calculei o público. Tamanho final: **729 contatos** (Semana AIDE = 898 ativos; subtraindo 169 que já têm algum produto da família AIDE).
>
> Amostra de 5 contatos:
>
> 1. ana.faria@gmail.com — Ana Karen Faria (compra Semana: 2026-04-15)
> 2. marcos.silva@hotmail.com — Marcos Silva (compra Semana: 2026-03-22)
> 3. paula.lima@outlook.com — Paula Lima (compra Semana: 2026-04-08)
> 4. joao.santos@gmail.com — João Santos (compra Semana: 2026-04-01)
> 5. clara.mendes@yahoo.com — Clara Mendes (compra Semana: 2026-03-15)
>
> Vou criar uma lista temporária `temp-aide-relampago-20260501` no SendPulse, popular com esses 729 contatos, criar a campanha apontando pro template `lancamento-aide-maio-2026` com o assunto solicitado, e agendar pra hoje às 14h.
>
> **Confirma o disparo?** Responda "sim" pra prosseguir, ou me diga o que ajustar.

**Você responde "sim"** → Claude executa e reporta:

> ✅ Lista temporária criada (ID 647100, 729 contatos populados).
> ✅ Campanha criada (ID 19283, status: scheduled, dispara 2026-05-01 14:00).
> Acompanhe os resultados em [link]. Quer que eu delete a lista temporária após o disparo concluir?

### Checkpoints obrigatórios antes de qualquer disparo

O Claude sempre executa estas validações automaticamente:

1. **Pré-validação de tamanho.** Mostra o número final de contatos antes de criar qualquer coisa no SendPulse. Se você ver um número estranho (ex: 5 quando esperava 500, ou 50.000 quando esperava 5.000), aborta.
2. **Amostra de contatos.** 5 emails reais que vão ser impactados. Confirme que são as pessoas certas.
3. **Confirmação humana.** Nada é criado no SendPulse antes de você dizer "sim". O Claude nunca dispara silenciosamente.
4. **Limite de tamanho de público sem aprovação adicional.** Disparos para listas até 500 contatos podem ser aprovados pelo solicitante. **Disparos acima de 500 contatos exigem segunda aprovação** (ex: print no Discord pro Mateus ou Luan validar antes).
5. **Validação de template.** O Claude confirma que o template existe e mostra o assunto que vai sair. Se o template tiver variáveis (`{{name}}`, `{{vigencia_expira_em}}`, etc.), avisa quais campos espera.
6. **Janela de silêncio pós-compra.** Quem comprou nas últimas 48h é automaticamente removido do público de qualquer campanha de venda. (Implementação a ser feita: filtro automático na regra de exclusão.)
7. **Hard suppression list.** Quem reclamou (marcou como spam), bounce permanente ou pediu descadastro nunca é incluído. SendPulse já trata nativamente.

### Protocolo de aprovação por tamanho

| Tamanho do público | Aprovação necessária |
|---|---|
| Até 100 contatos | Marketing solicitante |
| 100 - 500 contatos | Marketing solicitante (com print de validação no Discord #automações) |
| 500 - 2.000 contatos | Marketing + Mateus ou Luan |
| Acima de 2.000 contatos | Marketing + Mateus ou Luan + janela de teste com 100 contatos primeiro |

### Cuidados especiais (não esquecer)

- **Reputação do domínio.** Disparos malfeitos queimam o SPF/DKIM/DMARC que acabamos de configurar. Recuperar reputação leva semanas. Sempre prefira começar pequeno.
- **Frequência por contato.** Não dispare mais que 3 e-mails por semana pro mesmo contato. O Claude pode te avisar se o público alvo já recebeu e-mail recentemente — basta perguntar antes: *"Claude, dos 729 contatos do público, quantos já receberam e-mail nos últimos 7 dias?"*
- **Horário de envio.** Evite disparos entre 23h e 6h (BRT) ou em domingo de manhã — taxas de spam disparam. Recomendado: terça a quinta, entre 9h e 11h ou 14h e 16h.
- **Segunda-feira é arriscado.** Caixas cheias após o fim de semana → engagement baixo, classificação como promoção/spam mais provável.
- **Campanhas de venda em data sensível.** Black Friday, Cyber Monday e janeiro têm volume alto de e-mail competindo pela atenção. Templates precisam ser MUITO bons pra performar.

### Como cancelar / reverter um disparo

Se você disparou e percebeu erro **antes da campanha ser efetivamente enviada** (ex: agendou pra daqui 2h):

> Claude, cancela a campanha [nome ou ID]. Não dispara mais.

O Claude executa `email_campaigns_delete` ou `email_campaigns_update` setando status pra cancelado. **Funciona apenas se a campanha ainda está em "scheduled".**

Se já foi disparada, **não tem volta** — apenas mitigação:
- Disparar imediatamente um e-mail de correção pra mesma lista (pedindo desculpas, retratando, etc.)
- Avisar o suporte pra antecipar tickets que vão chegar
- Documentar o erro pra evitar reincidência

---

## Quando bater nessa documentação não resolve

Se o cenário que você precisa não está listado aqui, ou se as regras precisam ser combinadas de forma incomum, peça ajuda à Giulia. Casos típicos:

- Combinação de critério de lista + valor pago (ex: "high-value clients" — variável que ainda não foi populada).
- Filtro por região geográfica.
- Análise de engajamento (quem abriu/clicou e-mails recentes).
- Campanhas com gatilhos comportamentais (carrinho abandonado, etc.).

Esses cenários requerem criação de novas variáveis ou novas regras na view do Supabase, e devem ser tratados como projeto.

---

**Fim do guia.**
*Esta é a versão 1.0 — atualizada conforme novas regras forem definidas.*
