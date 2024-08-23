with data as (
    select 
        *,
        count(*) over (partition by null) as total_rows
    from ({{assert_true_macro(ref('assert_true_seed'), '(revenue - cost) / cost = margin')}})
)
select
    *    
from data
where total_rows <> 2
or should_be_true 