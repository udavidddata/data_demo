select *
from {{ ref('stg_elections__candidates') }}