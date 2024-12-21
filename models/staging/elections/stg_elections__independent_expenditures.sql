with 

source as (

    select * from {{ source('elections', 'independent_expenditures') }}

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
        support_oppose_indicator

    from source

)

select * from renamed
