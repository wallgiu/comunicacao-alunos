-- ============================================================
-- RPCs SECURITY DEFINER usadas pelos workflows n8n
-- ============================================================

-- RPC 1: retorna JSONB com todos os buyers ATIVOS (dentro da vigência)
-- Usada pelo workflow academy-sendpulse-initial-load
CREATE OR REPLACE FUNCTION public.get_sendpulse_all_active_json()
RETURNS jsonb
SECURITY DEFINER
SET search_path = public, eduzz
LANGUAGE sql
AS $$
  SELECT COALESCE(jsonb_agg(row_to_json(t)), '[]'::jsonb)
  FROM (
    SELECT active_list_id, ex_alunos_list_id, email, name, phone, data_ultima_compra, vigencia_expira_em
    FROM public.v_sendpulse_buyer_list_mapping
    WHERE is_active = true
  ) t;
$$;

GRANT EXECUTE ON FUNCTION public.get_sendpulse_all_active_json() TO anon, authenticated, service_role;

-- RPC 2: retorna JSONB com buyers EXPIRADOS (fora da vigência)
-- Usada para popular as listas ex-alunos
CREATE OR REPLACE FUNCTION public.get_sendpulse_all_expired_json()
RETURNS jsonb
SECURITY DEFINER
SET search_path = public, eduzz
LANGUAGE sql
AS $$
  SELECT COALESCE(jsonb_agg(row_to_json(t)), '[]'::jsonb)
  FROM (
    SELECT ex_alunos_list_id, active_list_id, email, name, phone, data_ultima_compra, vigencia_expira_em
    FROM public.v_sendpulse_buyer_list_mapping
    WHERE is_active = false AND ex_alunos_list_id IS NOT NULL
  ) t;
$$;

GRANT EXECUTE ON FUNCTION public.get_sendpulse_all_expired_json() TO anon, authenticated, service_role;

-- RPC 3: dado um product_name, retorna (active_list_id, ex_alunos_list_id, retention_days)
-- Usada pelo workflow eduzz-sale-sendpulse-welcome em tempo real
CREATE OR REPLACE FUNCTION public.get_sendpulse_lists_for_product(p_product_name text)
RETURNS TABLE(active_list_id bigint, ex_alunos_list_id bigint, retention_days int)
SECURITY DEFINER
SET search_path = public
LANGUAGE sql
AS $$
  SELECT
    CASE
      WHEN p_product_name ILIKE '%bootcamp%ai data engineer%' OR p_product_name ILIKE '%bootcamp | ai data engineer%' THEN 647043
      WHEN p_product_name ILIKE '%combo ai data engineer%' THEN 647044
      WHEN p_product_name ILIKE '%ai data engineer na prática%' OR p_product_name ILIKE '%ai data engineer na pratica%' THEN 647045
      WHEN p_product_name ILIKE '%formação ai data engineer%' OR p_product_name ILIKE '%formacao ai data engineer%' THEN 641808
      WHEN p_product_name ILIKE '%semana ai data engineer%' OR p_product_name ILIKE '%semana aide%' THEN 641807
      WHEN p_product_name ILIKE '%semana databricks 2.0 ex%' THEN 647053
      WHEN p_product_name ILIKE '%semana databricks 2.0 it%' THEN 647054
      WHEN p_product_name ILIKE '%semana databricks%' THEN 647055
      WHEN p_product_name ILIKE '%semana data vault%' THEN 647056
      WHEN p_product_name ILIKE '%sunset%plumbers%' THEN 647057
      WHEN p_product_name ILIKE '%sunset%' THEN 647058
      WHEN (p_product_name ILIKE '%plumbers%' OR p_product_name ILIKE '%the plumbers%') AND p_product_name NOT ILIKE '%sunset%' AND p_product_name NOT ILIKE '%imersão%' AND p_product_name NOT ILIKE '%imersao%' THEN 641804
      WHEN p_product_name ILIKE '%apache spark%databricks%' OR p_product_name ILIKE '%formação%spark%' OR p_product_name ILIKE '%spark programming%' OR p_product_name ILIKE '%databricks%' OR p_product_name ILIKE '%data engineering com apache spark%' OR p_product_name ILIKE '%especialização%spark%' THEN 641540
      WHEN p_product_name ILIKE '%academy 2.0%' OR p_product_name ILIKE '%comunidade academy%' THEN 647046
      WHEN p_product_name ILIKE '%dataship%' THEN 647047
      WHEN p_product_name ILIKE '%prompt engineering%' OR p_product_name ILIKE '%genai%' THEN 647059
      WHEN p_product_name ILIKE '%agentic ia%' OR p_product_name ILIKE '%workshop agentic%' THEN 647060
      WHEN p_product_name ILIKE '%fundamentos de engenharia%' THEN 647061
      WHEN p_product_name ILIKE '%e-book: como se destacar%' OR p_product_name ILIKE '%ebook: como se destacar%' THEN 647062
      WHEN p_product_name ILIKE '%e-book: o nascimento%' OR p_product_name ILIKE '%ebook: o nascimento%' THEN 647063
      WHEN p_product_name ILIKE '%workshop%' OR p_product_name ILIKE '%ws0%' OR p_product_name ILIKE '%ws1%' THEN 647064
      ELSE NULL
    END AS active_list_id,
    CASE
      WHEN p_product_name ILIKE '%bootcamp%ai data engineer%' OR p_product_name ILIKE '%bootcamp | ai data engineer%' THEN 647048
      WHEN p_product_name ILIKE '%combo ai data engineer%' THEN 647049
      WHEN p_product_name ILIKE '%ai data engineer na prática%' OR p_product_name ILIKE '%ai data engineer na pratica%' THEN 647050
      WHEN p_product_name ILIKE '%formação ai data engineer%' OR p_product_name ILIKE '%formacao ai data engineer%' THEN 644164
      WHEN p_product_name ILIKE '%semana ai data engineer%' OR p_product_name ILIKE '%semana aide%' THEN 644165
      WHEN (p_product_name ILIKE '%plumbers%' OR p_product_name ILIKE '%the plumbers%') AND p_product_name NOT ILIKE '%sunset%' AND p_product_name NOT ILIKE '%imersão%' THEN 644166
      WHEN p_product_name ILIKE '%apache spark%databricks%' OR p_product_name ILIKE '%formação%spark%' OR p_product_name ILIKE '%databricks%' OR p_product_name ILIKE '%spark programming%' OR p_product_name ILIKE '%data engineering com apache spark%' THEN 644167
      WHEN p_product_name ILIKE '%academy 2.0%' OR p_product_name ILIKE '%comunidade academy%' THEN 647051
      WHEN p_product_name ILIKE '%dataship%' THEN 647052
      ELSE NULL
    END AS ex_alunos_list_id,
    CASE
      WHEN p_product_name ILIKE '%plumbers%' OR p_product_name ILIKE '%academy%' OR p_product_name ILIKE '%formação ai data engineer%' OR p_product_name ILIKE '%bootcamp%ai data engineer%' OR p_product_name ILIKE '%combo ai data engineer%' OR p_product_name ILIKE '%ai data engineer na prática%' OR p_product_name ILIKE '%semana ai data engineer%' OR p_product_name ILIKE '%sunset%' OR p_product_name ILIKE '%dataship%' THEN 365
      WHEN p_product_name ILIKE '%apache spark%' OR p_product_name ILIKE '%databricks%' OR p_product_name ILIKE '%spark%' THEN 730
      ELSE NULL
    END AS retention_days;
$$;

GRANT EXECUTE ON FUNCTION public.get_sendpulse_lists_for_product(text) TO anon, authenticated, service_role;
