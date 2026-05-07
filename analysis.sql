-- New vs Returning Customers

WITH customer_orders AS (
  SELECT 
    user_id,
    created_at,
    MIN(created_at) OVER (PARTITION BY user_id) AS first_order
  FROM `bigquery-public-data.thelook_ecommerce.orders`
)

SELECT 
  CASE 
    WHEN created_at = first_order THEN 'New'
    ELSE 'Returning'
  END AS customer_type,
  COUNT(*) AS total_orders
FROM customer_orders
GROUP BY customer_type;


-- Top Products Analysis

SELECT 
  p.name AS product_name,
  COUNT(*) AS total_orders
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.products` p
ON oi.product_id = p.id
GROUP BY product_name
ORDER BY total_orders DESC
LIMIT 10;
