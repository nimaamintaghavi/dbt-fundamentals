WITH sold_price_sorted AS(
    
    SELECT 
        sold_month, 
        sold_week, 
        seller_firstname, 
        seller_lastname, 
        seller_username, 
        Sum(price_sold) AS SumOfprice_sold
    FROM {{ ref('stg_SellerCommission') }}
    GROUP BY sold_week, sold_month, seller_firstname, seller_lastname, seller_username
    ORDER BY sold_week, Sum(price_sold) DESC
),

Ranked AS (
    SELECT *, rank() OVER (PARTITION BY sold_month ORDER BY SumOfprice_sold DESC) AS sale_rank
    FROM sold_price_sorted
)


SELECT * FROM Ranked WHERE sale_rank <= 3
ORDER BY sold_week, sale_rank DESC