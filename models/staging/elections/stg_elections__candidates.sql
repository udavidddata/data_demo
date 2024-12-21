with 

source as (

    select * from {{ source('elections', 'candidates') }}

),

renamed as (

    select

        office,
        party_full,
        candidate_id,
        committee_ids,
        candidate_name,
        cast(total_receipts as float) as total_receipts,
        candidate_pcc_id,
        candidate_pcc_name,
        cast(total_disbursements as float) as total_disbursements,
        candidate_election_year,
        cast(cash_on_hand_end_period as float) as cash_on_hand_end_period,
        incumbent_challenge_full

    from source

)

select * from renamed
