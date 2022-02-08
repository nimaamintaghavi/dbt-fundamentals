WITH SellerCommission AS (

    SELECT 
        users.username          AS seller_username,
        users.firstname         AS seller_firstname,
        users.lastname          AS seller_lastname,
        sales.pricepaid         AS price_sold,
        DATE(sales.saletime)    AS sales_date,
        date.month              AS sold_month,
        date.week               AS sold_week

    FROM {{ ref('sales') }}       AS sales
    
    INNER JOIN {{ ref('users') }} AS users 
        ON sales.sellerid = users.userid
    
    INNER JOIN {{ ref('date') }}  AS date
        ON DATE(sales.saletime) = date.caldate
)

SELECT * FROM SellerCommission
