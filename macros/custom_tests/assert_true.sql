{% test assert_true(model, expression) %}
   {{ assert_true_macro(model, expression) }} 
{% endtest %}


{% macro assert_true_macro(model, expression) %}
    {% if not execute %} {{ return('') }} {% endif %} 

    {# Get required columns #}
    {% set meta = get_resource_meta(model.identifier) %}
    {% set grain = meta.get('opinionated').get('grain')%}
    {% set extra_columns = meta.get('opinionated').get('extra_columns') %}
    {% set all_columns = grain + extra_columns %}
    {{ log('All columns: ' + all_columns | string, info=true)}}

    select 
        {% for column in all_columns %}
            {{ column }}{% if not loop.last %},{% endif %}
        {% endfor %}
    from {{ model }}
    where not ({{ expression}} )
{% endmacro %}

