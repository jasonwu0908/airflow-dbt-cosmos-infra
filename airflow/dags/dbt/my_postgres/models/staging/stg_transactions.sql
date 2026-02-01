with source as (
    select * from {{ source('stock_operations', 'raw_transactions') }}
)

select
    tx_id,
    user_id,
    stock_symbol,
    action,
    price,
    quantity,
    -- 計算該筆交易的現金流：買入是錢流出(-)，賣出是錢流入(+)
    case 
        when action = 'buy' then -(price * quantity)
        when action = 'sell' then (price * quantity)
    end as cash_flow,
    tx_date
from source