{% macro get_resource(resource_name) %}
    {% if not execute %} {{ return('') }} {% endif %}
    
    {# Get the resource definition from the graph #}
    {% set resource_defs = graph.nodes.values() | list %} 
    {% set source_defs = graph.sources.values() | list %} 
    {% set all_defs = resource_defs + source_defs %}

    {# Get the specific resource definition. #}
    {% set resource_node = resource_defs | selectattr('name', 'equalto', resource_name) | list %} 

    {% if not resource_node %} 
        {{ exceptions.raise_compiler_error('MACRO-get_resource: Resource ' + resource_name + 'not found.')}}
    {% endif %}

    {{ return(resource_node) }}
{% endmacro %}