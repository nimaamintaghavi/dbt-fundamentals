WITH star AS(
SELECT seller_username,sale_rank FROM {{ ref('stg_top3_sellers_monthly') }}
), 

users AS(
    SELECT * FROM {{ ref('users') }}
)

SELECT users.*, star.sale_rank
FROM star 
INNER JOIN users ON star.seller_username = users.username