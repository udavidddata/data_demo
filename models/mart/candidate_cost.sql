with candidates as (
    select
        candidate_id,
        candidate_name,
        candidate_first_name,
        office,
        party_full,
        total_receipts,
        total_disbursements,
        cash_on_hand_end_period,
        incumbent_challenge_full,
        candidate_election_year
    from {{ ref('stg_elections__candidates') }}
),

communication_costs as (
    select
        candidate_id,
        sum(total) as total_communication_costs,
        count(*) as number_of_communications,
        sum(case when support_oppose_indicator = 'S' then total else 0 end)
            as supporting_costs,
        sum(case when support_oppose_indicator = 'O' then total else 0 end)
            as opposing_costs
    from {{ ref('stg_elections__communication_costs') }}
    group by 1
)

select
    c.*,
    coalesce(cc.total_communication_costs, 0) as total_communication_costs,
    coalesce(cc.number_of_communications, 0) as number_of_communications,
    coalesce(cc.supporting_costs, 0) as supporting_costs,
    coalesce(cc.opposing_costs, 0) as opposing_costs
from candidates as c
left join communication_costs as cc
    on c.candidate_id = cc.candidate_id
