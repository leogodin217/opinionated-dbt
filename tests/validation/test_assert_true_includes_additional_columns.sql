{% set model_ref = ref('assert_true_table') %}

{# Get the columns in the model #}
{% set columns = adapter.get_columns_in_relation(model_ref) %}
{% set column_list = columns | map(attribute='column') | list %}

{# extra_columns is defined in the meta config for test_assert_true_macro #}
{% set extra_columns = ['subscription_plan', 'company', 'should_be_true'] %}
{# Get the missing columns #}
{% set missing_columns = extra_columns | reject('in', column_list)|list %}

{# Query that only returns rows if there are missing columns #}
{% if missing_columns | length > 0 %}
    {% for column in missing_columns %}
        select '{{column}}' as missing_column 
        {% if not loop.last%} union all {% endif %}
    {% endfor %}
{% else %}
    select null as missing_column limit 0
{% endif %}
