with transactions as (
    select * from {{ ref('stg_transactions') }}
),

users as (
    select * from {{ source('stock_operations', 'raw_users') }}
),

user_pnl as (
    select
        user_id,
        sum(cash_flow) as net_profit
    from transactions
    group by 1
)

select
    u.user_id,
    u.user_name,
    p.net_profit,
    case 
        when p.net_profit > 0 then '獲利'
        when p.net_profit < 0 then '虧損'
        else '持平/未結清'
    end as status
from users u
left join user_pnl p on u.user_id = p.user_id