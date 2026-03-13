-- ============================================
-- E-Commerce Database - Seed Data (Oracle)
-- ============================================

-- ============================================
-- Insert Categories (5 categories)
-- ============================================

INSERT INTO category (name, description) VALUES
('Electronics', 'Electronic devices and gadgets');

INSERT INTO category (name, description) VALUES
('Books', 'Physical and digital books');

INSERT INTO category (name, description) VALUES
('Clothing', 'Apparel and fashion items');

INSERT INTO category (name, description) VALUES
('Home & Kitchen', 'Home appliances and kitchen tools');

INSERT INTO category (name, description) VALUES
('Sports', 'Sports equipment and fitness gear');

-- ============================================
-- Insert Users (10 users)
-- ============================================

INSERT INTO "user" (username, email, full_name, password_hash) VALUES
('john_doe', 'john@example.com', 'John Doe', '$2b$12$abcdefghijklmnopqrstuvwxyz123456');

INSERT INTO "user" (username, email, full_name, password_hash) VALUES
('jane_smith', 'jane@example.com', 'Jane Smith', '$2b$12$abcdefghijklmnopqrstuvwxyz123457');

INSERT INTO "user" (username, email, full_name, password_hash) VALUES
('mike_jones', 'mike@example.com', 'Mike Jones', '$2b$12$abcdefghijklmnopqrstuvwxyz123458');

INSERT INTO "user" (username, email, full_name, password_hash) VALUES
('sarah_wilson', 'sarah@example.com', 'Sarah Wilson', '$2b$12$abcdefghijklmnopqrstuvwxyz123459');

INSERT INTO "user" (username, email, full_name, password_hash) VALUES
('david_brown', 'david@example.com', 'David Brown', '$2b$12$abcdefghijklmnopqrstuvwxyz123460');

INSERT INTO "user" (username, email, full_name, password_hash) VALUES
('emma_davis', 'emma@example.com', 'Emma Davis', '$2b$12$abcdefghijklmnopqrstuvwxyz123461');

INSERT INTO "user" (username, email, full_name, password_hash) VALUES
('chris_miller', 'chris@example.com', 'Chris Miller', '$2b$12$abcdefghijklmnopqrstuvwxyz123462');

INSERT INTO "user" (username, email, full_name, password_hash) VALUES
('lisa_taylor', 'lisa@example.com', 'Lisa Taylor', '$2b$12$abcdefghijklmnopqrstuvwxyz123463');

INSERT INTO "user" (username, email, full_name, password_hash) VALUES
('tom_anderson', 'tom@example.com', 'Tom Anderson', '$2b$12$abcdefghijklmnopqrstuvwxyz123464');

INSERT INTO "user" (username, email, full_name, password_hash) VALUES
('amy_thomas', 'amy@example.com', 'Amy Thomas', '$2b$12$abcdefghijklmnopqrstuvwxyz123465');

-- ============================================
-- Insert Products (20 products)
-- ============================================

INSERT INTO product (name, description, price, stock_quantity, category_id) VALUES
('Wireless Headphones', 'Bluetooth noise-cancelling headphones', 129.99, 50, 1);

INSERT INTO product (name, description, price, stock_quantity, category_id) VALUES
('Smart Watch', 'Fitness tracking smartwatch with heart rate monitor', 249.99, 30, 1);

INSERT INTO product (name, description, price, stock_quantity, category_id) VALUES
('Laptop Stand', 'Adjustable aluminum laptop stand', 49.99, 100, 1);

INSERT INTO product (name, description, price, stock_quantity, category_id) VALUES
('USB-C Hub', '7-in-1 USB-C hub with HDMI and ethernet', 39.99, 75, 1);

INSERT INTO product (name, description, price, stock_quantity, category_id) VALUES
('Database Design', 'Complete guide to database systems', 59.99, 40, 2);

INSERT INTO product (name, description, price, stock_quantity, category_id) VALUES
('Python Programming', 'Learn Python from scratch', 44.99, 60, 2);

INSERT INTO product (name, description, price, stock_quantity, category_id) VALUES
('Web Development', 'Full-stack web development guide', 54.99, 35, 2);

INSERT INTO product (name, description, price, stock_quantity, category_id) VALUES
('Data Structures', 'Algorithms and data structures explained', 49.99, 45, 2);

INSERT INTO product (name, description, price, stock_quantity, category_id) VALUES
('Cotton T-Shirt', 'Comfortable 100% cotton t-shirt', 19.99, 200, 3);

INSERT INTO product (name, description, price, stock_quantity, category_id) VALUES
('Denim Jeans', 'Classic blue denim jeans', 69.99, 80, 3);

INSERT INTO product (name, description, price, stock_quantity, category_id) VALUES
('Running Shoes', 'Lightweight running shoes', 89.99, 60, 3);

INSERT INTO product (name, description, price, stock_quantity, category_id) VALUES
('Winter Jacket', 'Warm waterproof winter jacket', 149.99, 40, 3);

INSERT INTO product (name, description, price, stock_quantity, category_id) VALUES
('Coffee Maker', 'Programmable drip coffee maker', 79.99, 50, 4);

INSERT INTO product (name, description, price, stock_quantity, category_id) VALUES
('Blender', 'High-speed blender for smoothies', 99.99, 45, 4);

INSERT INTO product (name, description, price, stock_quantity, category_id) VALUES
('Air Fryer', 'Digital air fryer with 6 presets', 119.99, 35, 4);

INSERT INTO product (name, description, price, stock_quantity, category_id) VALUES
('Knife Set', 'Professional 15-piece knife set', 149.99, 25, 4);

INSERT INTO product (name, description, price, stock_quantity, category_id) VALUES
('Yoga Mat', 'Non-slip exercise yoga mat', 29.99, 100, 5);

INSERT INTO product (name, description, price, stock_quantity, category_id) VALUES
('Dumbbells Set', 'Adjustable dumbbells 5-50 lbs', 199.99, 30, 5);

INSERT INTO product (name, description, price, stock_quantity, category_id) VALUES
('Resistance Bands', 'Set of 5 resistance bands', 24.99, 150, 5);

INSERT INTO product (name, description, price, stock_quantity, category_id) VALUES
('Jump Rope', 'Speed jump rope for cardio', 14.99, 200, 5);

-- ============================================
-- Insert Orders (15 orders)
-- ============================================

INSERT INTO "order" (user_id, total_amount, status, shipping_address, order_date) VALUES
(1, 179.98, 'delivered', '123 Main St, New York, NY 10001', TIMESTAMP '2026-01-15 10:30:00');

INSERT INTO "order" (user_id, total_amount, status, shipping_address, order_date) VALUES
(1, 249.99, 'delivered', '123 Main St, New York, NY 10001', TIMESTAMP '2026-01-20 14:15:00');

INSERT INTO "order" (user_id, total_amount, status, shipping_address, order_date) VALUES
(2, 129.97, 'shipped', '456 Oak Ave, Los Angeles, CA 90001', TIMESTAMP '2026-02-01 09:45:00');

INSERT INTO "order" (user_id, total_amount, status, shipping_address, order_date) VALUES
(3, 299.97, 'delivered', '789 Pine Rd, Chicago, IL 60601', TIMESTAMP '2026-01-25 16:20:00');

INSERT INTO "order" (user_id, total_amount, status, shipping_address, order_date) VALUES
(4, 104.98, 'delivered', '321 Elm St, Houston, TX 77001', TIMESTAMP '2026-02-05 11:00:00');

INSERT INTO "order" (user_id, total_amount, status, shipping_address, order_date) VALUES
(5, 229.98, 'processing', '654 Maple Dr, Phoenix, AZ 85001', TIMESTAMP '2026-02-10 13:30:00');

INSERT INTO "order" (user_id, total_amount, status, shipping_address, order_date) VALUES
(6, 89.99, 'delivered', '987 Cedar Ln, Philadelphia, PA 19101', TIMESTAMP '2026-01-18 15:45:00');

INSERT INTO "order" (user_id, total_amount, status, shipping_address, order_date) VALUES
(7, 219.98, 'delivered', '147 Birch Way, San Antonio, TX 78201', TIMESTAMP '2026-01-22 12:10:00');

INSERT INTO "order" (user_id, total_amount, status, shipping_address, order_date) VALUES
(8, 169.98, 'shipped', '258 Spruce Ct, San Diego, CA 92101', TIMESTAMP '2026-02-08 10:20:00');

INSERT INTO "order" (user_id, total_amount, status, shipping_address, order_date) VALUES
(9, 104.98, 'delivered', '369 Willow St, Dallas, TX 75201', TIMESTAMP '2026-01-28 14:50:00');

INSERT INTO "order" (user_id, total_amount, status, shipping_address, order_date) VALUES
(2, 99.99, 'delivered', '456 Oak Ave, Los Angeles, CA 90001', TIMESTAMP '2026-02-12 11:30:00');

INSERT INTO "order" (user_id, total_amount, status, shipping_address, order_date) VALUES
(3, 119.99, 'processing', '789 Pine Rd, Chicago, IL 60601', TIMESTAMP '2026-02-15 09:15:00');

INSERT INTO "order" (user_id, total_amount, status, shipping_address, order_date) VALUES
(1, 54.98, 'delivered', '123 Main St, New York, NY 10001', TIMESTAMP '2026-02-03 16:00:00');

INSERT INTO "order" (user_id, total_amount, status, shipping_address, order_date) VALUES
(4, 379.98, 'delivered', '321 Elm St, Houston, TX 77001', TIMESTAMP '2026-02-07 10:45:00');

INSERT INTO "order" (user_id, total_amount, status, shipping_address, order_date) VALUES
(5, 44.99, 'shipped', '654 Maple Dr, Phoenix, AZ 85001', TIMESTAMP '2026-02-18 13:20:00');

-- ============================================
-- Insert Order Items
-- ============================================

INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (1, 1, 1, 129.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (1, 3, 1, 49.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (2, 2, 1, 249.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (3, 9, 2, 19.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (3, 11, 1, 89.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (4, 13, 1, 79.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (4, 14, 1, 99.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (4, 15, 1, 119.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (5, 5, 1, 59.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (5, 6, 1, 44.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (6, 18, 1, 199.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (6, 17, 1, 29.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (7, 11, 1, 89.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (8, 12, 1, 149.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (8, 10, 1, 69.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (9, 1, 1, 129.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (9, 4, 1, 39.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (10, 7, 1, 54.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (10, 8, 1, 49.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (11, 14, 1, 99.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (12, 15, 1, 119.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (13, 17, 1, 29.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (13, 19, 1, 24.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (14, 1, 1, 129.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (14, 2, 1, 249.99);
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) VALUES (15, 6, 1, 44.99);

-- ============================================
-- Insert Reviews
-- ============================================

INSERT INTO review (product_id, user_id, rating, comment) VALUES (1, 1, 5, 'Amazing sound quality! Best headphones I have ever owned.');
INSERT INTO review (product_id, user_id, rating, comment) VALUES (1, 8, 4, 'Great headphones but a bit pricey.');
INSERT INTO review (product_id, user_id, rating, comment) VALUES (1, 4, 5, 'Noise cancellation works perfectly.');
INSERT INTO review (product_id, user_id, rating, comment) VALUES (2, 1, 4, 'Good fitness tracking, battery life could be better.');
INSERT INTO review (product_id, user_id, rating, comment) VALUES (2, 4, 5, 'Love the heart rate monitor and sleep tracking!');
INSERT INTO review (product_id, user_id, rating, comment) VALUES (3, 1, 5, 'Sturdy and adjustable, perfect for my setup.');
INSERT INTO review (product_id, user_id, rating, comment) VALUES (11, 2, 5, 'Very comfortable for long runs.');
INSERT INTO review (product_id, user_id, rating, comment) VALUES (11, 6, 4, 'Good quality but sizing runs a bit small.');
INSERT INTO review (product_id, user_id, rating, comment) VALUES (13, 3, 5, 'Makes excellent coffee every morning!');
INSERT INTO review (product_id, user_id, rating, comment) VALUES (14, 3, 4, 'Powerful motor, blends smoothly.');
INSERT INTO review (product_id, user_id, rating, comment) VALUES (14, 2, 5, 'Perfect for my morning smoothies!');
INSERT INTO review (product_id, user_id, rating, comment) VALUES (15, 3, 5, 'Cooks food evenly and quickly, love it!');
INSERT INTO review (product_id, user_id, rating, comment) VALUES (15, 4, 4, 'Great appliance, easy to clean.');
INSERT INTO review (product_id, user_id, rating, comment) VALUES (5, 4, 5, 'Comprehensive guide, very helpful for my studies.');
INSERT INTO review (product_id, user_id, rating, comment) VALUES (6, 4, 4, 'Good introduction to Python.');
INSERT INTO review (product_id, user_id, rating, comment) VALUES (6, 5, 5, 'Clear explanations and great examples.');
INSERT INTO review (product_id, user_id, rating, comment) VALUES (12, 7, 5, 'Kept me warm all winter, excellent quality.');
INSERT INTO review (product_id, user_id, rating, comment) VALUES (17, 1, 4, 'Good grip, comfortable for yoga sessions.');
INSERT INTO review (product_id, user_id, rating, comment) VALUES (17, 5, 5, 'Perfect thickness and non-slip surface.');
INSERT INTO review (product_id, user_id, rating, comment) VALUES (18, 5, 5, 'Excellent build quality, easy to adjust weights.');
INSERT INTO review (product_id, user_id, rating, comment) VALUES (7, 9, 5, 'Best web dev book I have read!');
INSERT INTO review (product_id, user_id, rating, comment) VALUES (8, 9, 4, 'Clear explanations of complex topics.');

COMMIT;
/
