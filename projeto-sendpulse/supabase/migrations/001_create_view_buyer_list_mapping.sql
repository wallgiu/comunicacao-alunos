-- ============================================================
-- View: v_sendpulse_buyer_list_mapping
-- Classifica cada comprador Eduzz na lista SendPulse correta
-- aplicando regras de vigência por família de produto.
-- ============================================================

DROP VIEW IF EXISTS public.v_sendpulse_buyer_list_mapping CASCADE;

CREATE VIEW public.v_sendpulse_buyer_list_mapping AS
WITH classification AS (
  SELECT
    s.product_cod AS content_id,
    s.product_name,
    LOWER(TRIM(s.cus_email)) AS email,
    INITCAP(TRIM(s.cus_name)) AS name,
    c.phone_full AS phone,
    s.trans_paiddate,
    CASE
      WHEN s.product_name ILIKE '%bootcamp%ai data engineer%' OR s.product_name ILIKE '%bootcamp | ai data engineer%' THEN 647043
      WHEN s.product_name ILIKE '%combo ai data engineer%' THEN 647044
      WHEN s.product_name ILIKE '%ai data engineer na prática%' OR s.product_name ILIKE '%ai data engineer na pratica%' THEN 647045
      WHEN s.product_name ILIKE '%formação ai data engineer%' OR s.product_name ILIKE '%formacao ai data engineer%' THEN 641808
      WHEN s.product_name ILIKE '%semana ai data engineer%' OR s.product_name ILIKE '%semana aide%' THEN 641807
      WHEN s.product_name ILIKE '%semana databricks 2.0 ex%' THEN 647053
      WHEN s.product_name ILIKE '%semana databricks 2.0 it%' THEN 647054
      WHEN s.product_name ILIKE '%semana databricks%' THEN 647055
      WHEN s.product_name ILIKE '%semana data vault%' THEN 647056
      WHEN s.product_name ILIKE '%sunset%plumbers%' OR s.product_name ILIKE '%sunset 2025 - plumbers%' THEN 647057
      WHEN s.product_name ILIKE '%sunset%' THEN 647058
      WHEN (s.product_name ILIKE '%plumbers%' OR s.product_name ILIKE '%the plumbers%') AND s.product_name NOT ILIKE '%sunset%' AND s.product_name NOT ILIKE '%imersão%' AND s.product_name NOT ILIKE '%imersao%' THEN 641804
      WHEN s.product_name ILIKE '%apache spark%databricks%' OR s.product_name ILIKE '%formação%spark%' OR s.product_name ILIKE '%spark programming%' OR s.product_name ILIKE '%databricks%' OR s.product_name ILIKE '%data engineering com apache spark%' OR s.product_name ILIKE '%especialização%spark%' THEN 641540
      WHEN s.product_name ILIKE '%academy 2.0%' OR s.product_name ILIKE '%comunidade academy%' THEN 647046
      WHEN s.product_name ILIKE '%dataship%' THEN 647047
      WHEN s.product_name ILIKE '%prompt engineering%' OR s.product_name ILIKE '%genai%' THEN 647059
      WHEN s.product_name ILIKE '%agentic ia%' OR s.product_name ILIKE '%workshop agentic%' THEN 647060
      WHEN s.product_name ILIKE '%fundamentos de engenharia%' THEN 647061
      WHEN s.product_name ILIKE '%e-book: como se destacar%' OR s.product_name ILIKE '%ebook: como se destacar%' THEN 647062
      WHEN s.product_name ILIKE '%e-book: o nascimento%' OR s.product_name ILIKE '%ebook: o nascimento%' THEN 647063
      WHEN s.product_name ILIKE '%workshop%' OR s.product_name ILIKE '%ws0%' OR s.product_name ILIKE '%ws1%' THEN 647064
      ELSE NULL
    END AS active_list_id,
    CASE
      WHEN s.product_name ILIKE '%bootcamp%ai data engineer%' OR s.product_name ILIKE '%bootcamp | ai data engineer%' THEN 647048
      WHEN s.product_name ILIKE '%combo ai data engineer%' THEN 647049
      WHEN s.product_name ILIKE '%ai data engineer na prática%' OR s.product_name ILIKE '%ai data engineer na pratica%' THEN 647050
      WHEN s.product_name ILIKE '%formação ai data engineer%' OR s.product_name ILIKE '%formacao ai data engineer%' THEN 644164
      WHEN s.product_name ILIKE '%semana ai data engineer%' OR s.product_name ILIKE '%semana aide%' THEN 644165
      WHEN (s.product_name ILIKE '%plumbers%' OR s.product_name ILIKE '%the plumbers%') AND s.product_name NOT ILIKE '%sunset%' AND s.product_name NOT ILIKE '%imersão%' THEN 644166
      WHEN s.product_name ILIKE '%apache spark%databricks%' OR s.product_name ILIKE '%formação%spark%' OR s.product_name ILIKE '%databricks%' OR s.product_name ILIKE '%spark programming%' OR s.product_name ILIKE '%data engineering com apache spark%' THEN 644167
      WHEN s.product_name ILIKE '%academy 2.0%' OR s.product_name ILIKE '%comunidade academy%' THEN 647051
      WHEN s.product_name ILIKE '%dataship%' THEN 647052
      ELSE NULL
    END AS ex_alunos_list_id,
    CASE
      WHEN s.product_name ILIKE '%plumbers%' OR s.product_name ILIKE '%academy%' OR s.product_name ILIKE '%formação ai data engineer%' OR s.product_name ILIKE '%bootcamp%ai data engineer%' OR s.product_name ILIKE '%combo ai data engineer%' OR s.product_name ILIKE '%ai data engineer na prática%' OR s.product_name ILIKE '%semana ai data engineer%' OR s.product_name ILIKE '%sunset%' OR s.product_name ILIKE '%dataship%' THEN 365
      WHEN s.product_name ILIKE '%apache spark%' OR s.product_name ILIKE '%databricks%' OR s.product_name ILIKE '%spark%' THEN 730
      ELSE NULL
    END AS retention_days
  FROM eduzz.eduzz_sales_raw s
  LEFT JOIN eduzz.eduzz_customers_raw c ON c.eduzz_customer_id = s.cus_cod
  WHERE s.trans_paiddate IS NOT NULL
    AND s.cus_email IS NOT NULL AND s.cus_email <> ''
),
dedup AS (
  SELECT DISTINCT ON (active_list_id, email)
    active_list_id, ex_alunos_list_id, email, name, phone, trans_paiddate, retention_days
  FROM classification
  WHERE active_list_id IS NOT NULL
  ORDER BY active_list_id, email, trans_paiddate DESC
)
SELECT
  active_list_id,
  ex_alunos_list_id,
  email,
  name,
  phone,
  trans_paiddate,
  retention_days,
  TO_CHAR(trans_paiddate, 'YYYY-MM-DD') AS data_ultima_compra,
  CASE
    WHEN retention_days IS NULL THEN NULL
    ELSE TO_CHAR(trans_paiddate + (retention_days || ' days')::interval, 'YYYY-MM-DD')
  END AS vigencia_expira_em,
  (retention_days IS NULL OR trans_paiddate >= NOW() - (retention_days || ' days')::interval) AS is_active
FROM dedup;
