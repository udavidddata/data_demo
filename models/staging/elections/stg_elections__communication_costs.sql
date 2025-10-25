with

source as (

    select * from {{ source('elections', 'communication_costs') }}

),

renamed as (

    select

        count,
        cycle,
        cast(total as float) as total,
        cand_id,
        cmte_id,
        candidate_id,
        committee_id,
        candidate_name,
        committee_name,
        support_oppose_indicator,
        split_part(candidate_name, ',', 1) as candidate_first_name

    from source

)

select * from renamed
