-- ============================================
-- E-Commerce Database - Query Examples
-- PostgreSQL Implementation
-- ============================================

-- ============================================
-- QUERY 1: All products purchased by a specific user
-- ============================================
-- Example: Get all products purchased by user 'john_doe' (user_id = 1)

SELECT DISTINCT
    u.user_id,
    u.username,
    u.full_name,
    p.product_id,
    p.name AS product_name,
    p.price AS current_price,
    c.name AS category,
    oi.quantity,
    oi.price_at_purchase,
    o.order_date,
    o.status AS order_status
FROM "user" u
JOIN "order" o ON u.user_id = o.user_id
JOIN order_item oi ON o.order_id = oi.order_id
JOIN product p ON oi.product_id = p.product_id
JOIN category c ON p.category_id = c.category_id
WHERE u.user_id = 1
ORDER BY o.order_date DESC;

-- ============================================
-- QUERY 2: Top 5 most ordered products
-- ============================================
-- Products ranked by total quantity sold

SELECT 
    p.product_id,
    p.name AS product_name,
    c.name AS category,
    COUNT(DISTINCT oi.order_id) AS number_of_orders,
    SUM(oi.quantity) AS total_quantity_sold,
    ROUND(SUM(oi.quantity * oi.price_at_purchase)::numeric, 2) AS total_revenue
FROM product p
JOIN order_item oi ON p.product_id = oi.product_id
JOIN category c ON p.category_id = c.category_id
GROUP BY p.product_id, p.name, c.name
ORDER BY total_quantity_sold DESC, number_of_orders DESC
LIMIT 5;

-- ============================================
-- QUERY 3: Average rating per product
-- ============================================
-- Show products with their average ratings and review counts

SELECT 
    p.product_id,
    p.name AS product_name,
    c.name AS category,
    p.price,
    COUNT(r.review_id) AS review_count,
    ROUND(AVG(r.rating)::numeric, 2) AS average_rating,
    MIN(r.rating) AS min_rating,
    MAX(r.rating) AS max_rating
FROM product p
LEFT JOIN review r ON p.product_id = r.product_id
LEFT JOIN category c ON p.category_id = c.category_id
GROUP BY p.product_id, p.name, c.name, p.price
HAVING COUNT(r.review_id) > 0
ORDER BY average_rating DESC, review_count DESC;

-- ============================================
-- QUERY 4: All users who purchased a specific product
-- ============================================
-- Example: Get all users who bought 'Wireless Headphones' (product_id = 1)

SELECT DISTINCT
    p.product_id,
    p.name AS product_name,
    u.user_id,
    u.username,
    u.full_name,
    u.email,
    o.order_id,
    oi.quantity,
    oi.price_at_purchase,
    o.order_date,
    o.status AS order_status
FROM product p
JOIN order_item oi ON p.product_id = oi.product_id
JOIN "order" o ON oi.order_id = o.order_id
JOIN "user" u ON o.user_id = u.user_id
WHERE p.product_id = 1
ORDER BY o.order_date DESC;

-- ============================================
-- QUERY 5: Product Recommendation Query
-- ============================================
-- Recommend products based on what other users who bought the same product also purchased
-- Example: Recommendations for users who bought product_id = 1 (Wireless Headphones)

WITH user_who_bought_product AS (
    -- Find users who bought the target product
    SELECT DISTINCT o.user_id
    FROM order_item oi
    JOIN "order" o ON oi.order_id = o.order_id
    WHERE oi.product_id = 1
),
other_products_bought AS (
    -- Find what else these users bought
    SELECT 
        oi2.product_id,
        COUNT(DISTINCT o2.user_id) AS bought_by_count,
        COUNT(DISTINCT oi2.order_id) AS order_count
    FROM user_who_bought_product uwbp
    JOIN "order" o2 ON uwbp.user_id = o2.user_id
    JOIN order_item oi2 ON o2.order_id = oi2.order_id
    WHERE oi2.product_id != 1  -- Exclude the original product
    GROUP BY oi2.product_id
)
SELECT 
    p.product_id,
    p.name AS product_name,
    c.name AS category,
    p.price,
    opb.bought_by_count AS customers_also_bought,
    opb.order_count AS times_ordered_together,
    ROUND(AVG(r.rating)::numeric, 2) AS average_rating,
    COUNT(r.review_id) AS review_count
FROM other_products_bought opb
JOIN product p ON opb.product_id = p.product_id
JOIN category c ON p.category_id = c.category_id
LEFT JOIN review r ON p.product_id = r.product_id
GROUP BY p.product_id, p.name, c.name, p.price, opb.bought_by_count, opb.order_count
ORDER BY opb.bought_by_count DESC, opb.order_count DESC
LIMIT 5;

-- ============================================
-- BONUS QUERIES
-- ============================================

-- Query 6: User purchase history with total spending
SELECT 
    u.user_id,
    u.username,
    u.full_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent,
    ROUND(AVG(o.total_amount)::numeric, 2) AS avg_order_value,
    MAX(o.order_date) AS last_order_date
FROM "user" u
LEFT JOIN "order" o ON u.user_id = o.user_id
GROUP BY u.user_id, u.username, u.full_name
ORDER BY total_spent DESC;

-- Query 7: Products with no reviews (need attention)
SELECT 
    p.product_id,
    p.name AS product_name,
    c.name AS category,
    p.price,
    p.stock_quantity,
    COUNT(oi.order_item_id) AS times_sold
FROM product p
JOIN category c ON p.category_id = c.category_id
LEFT JOIN review r ON p.product_id = r.product_id
LEFT JOIN order_item oi ON p.product_id = oi.product_id
WHERE r.review_id IS NULL
GROUP BY p.product_id, p.name, c.name, p.price, p.stock_quantity
ORDER BY times_sold DESC;

-- Query 8: Monthly sales report
SELECT 
    TO_CHAR(o.order_date, 'YYYY-MM') AS month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.user_id) AS unique_customers,
    SUM(o.total_amount) AS total_revenue,
    ROUND(AVG(o.total_amount)::numeric, 2) AS avg_order_value
FROM "order" o
GROUP BY TO_CHAR(o.order_date, 'YYYY-MM')
ORDER BY month DESC;

-- Query 9: Category performance analysis
SELECT 
    c.category_id,
    c.name AS category_name,
    COUNT(DISTINCT p.product_id) AS product_count,
    COUNT(DISTINCT oi.order_id) AS orders_count,
    SUM(oi.quantity) AS total_units_sold,
    ROUND(SUM(oi.quantity * oi.price_at_purchase)::numeric, 2) AS total_revenue,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_category_rating
FROM category c
LEFT JOIN product p ON c.category_id = p.category_id
LEFT JOIN order_item oi ON p.product_id = oi.product_id
LEFT JOIN review r ON p.product_id = r.product_id
GROUP BY c.category_id, c.name
ORDER BY total_revenue DESC;

-- Query 10: Users with reviews but no purchases (or vice versa)
SELECT 
    u.user_id,
    u.username,
    u.full_name,
    COUNT(DISTINCT o.order_id) AS order_count,
    COUNT(DISTINCT r.review_id) AS review_count,
    CASE 
        WHEN COUNT(DISTINCT o.order_id) = 0 THEN 'Reviews but no purchases'
        WHEN COUNT(DISTINCT r.review_id) = 0 THEN 'Purchases but no reviews'
        ELSE 'Both purchases and reviews'
    END AS user_behavior
FROM "user" u
LEFT JOIN "order" o ON u.user_id = o.user_id
LEFT JOIN review r ON u.user_id = r.user_id
GROUP BY u.user_id, u.username, u.full_name
ORDER BY review_count DESC, order_count DESC;
