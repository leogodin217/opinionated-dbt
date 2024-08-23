{% macro get_resource_meta(resource_name) %}
    {% if not execute %} {{ return('') }} {% endif %}

    {# Get the resource from the graph #}
    {{log('Getting resource', info=true)}}
    {% set resource_node = get_resource(resource_name) %}
    {{log('Got resource', info=true)}}
    {# Get the meta configuration  #}
    {% set resource_config = resource_node[0].get('config') %}
    {% set resource_meta = resource_config.get('meta') %}
    {{ return(resource_meta) }}
{% endmacro %}