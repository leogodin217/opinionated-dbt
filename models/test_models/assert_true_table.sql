{{
  config(
    materialized = 'table',
    )
}}

{% set model_ref = ref('assert_true_seed') %}
{{ assert_true_macro(model_ref, '(revenue - cost) / cost = margin') }}