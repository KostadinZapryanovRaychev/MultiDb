-- ============================================
-- E-Commerce Database - Query Examples
-- MySQL Implementation
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
FROM `user` u
INNER JOIN `order` o ON u.user_id = o.user_id
INNER JOIN order_item oi ON o.order_id = oi.order_id
INNER JOIN product p ON oi.product_id = p.product_id
INNER JOIN category c ON p.category_id = c.category_id
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
    ROUND(SUM(oi.quantity * oi.price_at_purchase), 2) AS total_revenue
FROM product p
INNER JOIN order_item oi ON p.product_id = oi.product_id
INNER JOIN category c ON p.category_id = c.category_id
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
    ROUND(AVG(r.rating), 2) AS average_rating,
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
INNER JOIN order_item oi ON p.product_id = oi.product_id
INNER JOIN `order` o ON oi.order_id = o.order_id
INNER JOIN `user` u ON o.user_id = u.user_id
WHERE p.product_id = 1
ORDER BY o.order_date DESC;

-- ============================================
-- QUERY 5: Product Recommendation Query
-- ============================================
-- Recommend products based on what other users who bought the same product also purchased
-- Example: Recommendations for users who bought product_id = 1 (Wireless Headphones)

SELECT 
    p.product_id,
    p.name AS product_name,
    c.name AS category,
    p.price,
    COUNT(DISTINCT o2.user_id) AS customers_also_bought,
    COUNT(DISTINCT oi2.order_id) AS times_ordered_together,
    ROUND(AVG(r.rating), 2) AS average_rating,
    COUNT(r.review_id) AS review_count
FROM order_item oi1
INNER JOIN `order` o1 ON oi1.order_id = o1.order_id
INNER JOIN `order` o2 ON o1.user_id = o2.user_id
INNER JOIN order_item oi2 ON o2.order_id = oi2.order_id
INNER JOIN product p ON oi2.product_id = p.product_id
INNER JOIN category c ON p.category_id = c.category_id
LEFT JOIN review r ON p.product_id = r.product_id
WHERE oi1.product_id = 1  -- Target product (Wireless Headphones)
  AND oi2.product_id != 1  -- Exclude the original product
GROUP BY p.product_id, p.name, c.name, p.price
ORDER BY customers_also_bought DESC, times_ordered_together DESC
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
    COALESCE(SUM(o.total_amount), 0) AS total_spent,
    COALESCE(ROUND(AVG(o.total_amount), 2), 0) AS avg_order_value,
    MAX(o.order_date) AS last_order_date
FROM `user` u
LEFT JOIN `order` o ON u.user_id = o.user_id
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
INNER JOIN category c ON p.category_id = c.category_id
LEFT JOIN review r ON p.product_id = r.product_id
LEFT JOIN order_item oi ON p.product_id = oi.product_id
WHERE r.review_id IS NULL
GROUP BY p.product_id, p.name, c.name, p.price, p.stock_quantity
ORDER BY times_sold DESC;

-- Query 8: Monthly sales report
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.user_id) AS unique_customers,
    SUM(o.total_amount) AS total_revenue,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM `order` o
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month DESC;

-- Query 9: Category performance analysis
SELECT 
    c.category_id,
    c.name AS category_name,
    COUNT(DISTINCT p.product_id) AS product_count,
    COUNT(DISTINCT oi.order_id) AS orders_count,
    COALESCE(SUM(oi.quantity), 0) AS total_units_sold,
    COALESCE(ROUND(SUM(oi.quantity * oi.price_at_purchase), 2), 0) AS total_revenue,
    ROUND(AVG(r.rating), 2) AS avg_category_rating
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
FROM `user` u
LEFT JOIN `order` o ON u.user_id = o.user_id
LEFT JOIN review r ON u.user_id = r.user_id
GROUP BY u.user_id, u.username, u.full_name
ORDER BY review_count DESC, order_count DESC;

-- ============================================
-- MySQL-SPECIFIC QUERIES
-- ============================================

-- Query 11: Full-text search on product names and descriptions (requires FULLTEXT index)
-- First, add fulltext index:
-- ALTER TABLE product ADD FULLTEXT INDEX ft_product_search (name, description);
-- Then search:
-- SELECT product_id, name, description, price
-- FROM product
-- WHERE MATCH(name, description) AGAINST('bluetooth wireless' IN NATURAL LANGUAGE MODE);

-- Query 12: Find products with price in a range using BETWEEN
SELECT 
    p.product_id,
    p.name AS product_name,
    c.name AS category,
    p.price,
    p.stock_quantity
FROM product p
INNER JOIN category c ON p.category_id = c.category_id
WHERE p.price BETWEEN 50.00 AND 150.00
ORDER BY p.price ASC;

-- Query 13: Using stored procedure to get user order summary
DELIMITER $$
CREATE PROCEDURE GetUserOrderSummary(IN userId INT)
BEGIN
    SELECT 
        u.username,
        u.full_name,
        u.email,
        COUNT(o.order_id) AS total_orders,
        SUM(o.total_amount) AS total_spent,
        AVG(o.total_amount) AS avg_order_value
    FROM `user` u
    LEFT JOIN `order` o ON u.user_id = o.user_id
    WHERE u.user_id = userId
    GROUP BY u.user_id, u.username, u.full_name, u.email;
END$$
DELIMITER ;

-- Call the stored procedure:
-- CALL GetUserOrderSummary(1);

-- Query 14: Using window functions (MySQL 8.0+) to rank products by revenue
SELECT 
    p.product_id,
    p.name AS product_name,
    c.name AS category,
    SUM(oi.quantity * oi.price_at_purchase) AS total_revenue,
    RANK() OVER (ORDER BY SUM(oi.quantity * oi.price_at_purchase) DESC) AS revenue_rank,
    DENSE_RANK() OVER (PARTITION BY c.category_id ORDER BY SUM(oi.quantity * oi.price_at_purchase) DESC) AS category_rank
FROM product p
INNER JOIN category c ON p.category_id = c.category_id
INNER JOIN order_item oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name, c.name, c.category_id
ORDER BY total_revenue DESC;

-- Query 15: Common Table Expression (CTE) for recursive category hierarchy (if categories had parent_id)
-- This example shows how to use CTE in MySQL 8.0+
WITH RECURSIVE OrderStats AS (
    SELECT 
        user_id,
        order_id,
        total_amount,
        order_date,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY order_date DESC) AS order_rank
    FROM `order`
)
SELECT 
    u.username,
    u.full_name,
    os.order_id,
    os.total_amount,
    os.order_date,
    os.order_rank
FROM OrderStats os
INNER JOIN `user` u ON os.user_id = u.user_id
WHERE os.order_rank <= 3
ORDER BY u.username, os.order_rank;
