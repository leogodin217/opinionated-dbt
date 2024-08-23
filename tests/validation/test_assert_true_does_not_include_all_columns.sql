{% set model_ref = ref('assert_true_table') %}
{% if execute %}
{# Get the columns in the model #}
{% set columns = adapter.get_columns_in_relation(model_ref) %}
{% set column_list = columns | map(attribute='column') | list %}

{# Columns not defined in grain or extra_columns in the meta config for test_assert_true_macro #}
{% set excluded_columns = ['revenue', 'cost', 'margin'] %}
{# None of the excluded columns should be in the table #}
{% set additional_columns = excluded_columns | select('in', column_list) | list %}

{# Query that only returns rows if there are missing columns #}
{% if additional_columns | length > 0 %}
    {% for column in additional_columns %}
        select '{{column}}' as additional_column 
        {% if not loop.last%} union all {% endif %}
    {% endfor %}
{% else %}
    select null as additional_column limit 0
{% endif %}

{% endif %}