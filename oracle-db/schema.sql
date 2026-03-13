-- ============================================
-- E-Commerce Database Schema - Oracle
-- ============================================

-- Drop tables if they exist
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE review';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE order_item';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE "order"';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE product';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE category';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE "user"';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

-- ============================================
-- Create Tables
-- ============================================

-- Users table
CREATE TABLE "user" (
    user_id NUMBER PRIMARY KEY,
    username VARCHAR2(50) UNIQUE NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    full_name VARCHAR2(100) NOT NULL,
    password_hash VARCHAR2(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE SEQUENCE user_id_seq START WITH 1 INCREMENT BY 1;

CREATE TRIGGER user_id_trigger
BEFORE INSERT ON "user"
FOR EACH ROW
BEGIN
  SELECT user_id_seq.NEXTVAL INTO :NEW.user_id FROM dual;
END;
/

-- Categories table
CREATE TABLE category (
    category_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) UNIQUE NOT NULL,
    description CLOB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE SEQUENCE category_id_seq START WITH 1 INCREMENT BY 1;

CREATE TRIGGER category_id_trigger
BEFORE INSERT ON category
FOR EACH ROW
BEGIN
  SELECT category_id_seq.NEXTVAL INTO :NEW.category_id FROM dual;
END;
/

-- Products table
CREATE TABLE product (
    product_id NUMBER PRIMARY KEY,
    name VARCHAR2(200) NOT NULL,
    description CLOB,
    price NUMBER(10, 2) NOT NULL CHECK (price >= 0),
    stock_quantity NUMBER(10) NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    category_id NUMBER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES category(category_id) ON DELETE CASCADE
);

CREATE SEQUENCE product_id_seq START WITH 1 INCREMENT BY 1;

CREATE TRIGGER product_id_trigger
BEFORE INSERT ON product
FOR EACH ROW
BEGIN
  SELECT product_id_seq.NEXTVAL INTO :NEW.product_id FROM dual;
END;
/

-- Orders table
CREATE TABLE "order" (
    order_id NUMBER PRIMARY KEY,
    user_id NUMBER NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount NUMBER(10, 2) NOT NULL CHECK (total_amount >= 0),
    status VARCHAR2(20) DEFAULT 'pending' CHECK (status IN ('pending', 'processing', 'shipped', 'delivered', 'cancelled')),
    shipping_address CLOB NOT NULL,
    FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE CASCADE
);

CREATE SEQUENCE order_id_seq START WITH 1 INCREMENT BY 1;

CREATE TRIGGER order_id_trigger
BEFORE INSERT ON "order"
FOR EACH ROW
BEGIN
  SELECT order_id_seq.NEXTVAL INTO :NEW.order_id FROM dual;
END;
/

-- Order Items table
CREATE TABLE order_item (
    order_item_id NUMBER PRIMARY KEY,
    order_id NUMBER NOT NULL,
    product_id NUMBER NOT NULL,
    quantity NUMBER(10) NOT NULL CHECK (quantity > 0),
    price_at_purchase NUMBER(10, 2) NOT NULL CHECK (price_at_purchase >= 0),
    FOREIGN KEY (order_id) REFERENCES "order"(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE
);

CREATE SEQUENCE order_item_id_seq START WITH 1 INCREMENT BY 1;

CREATE TRIGGER order_item_id_trigger
BEFORE INSERT ON order_item
FOR EACH ROW
BEGIN
  SELECT order_item_id_seq.NEXTVAL INTO :NEW.order_item_id FROM dual;
END;
/

-- Reviews table
CREATE TABLE review (
    review_id NUMBER PRIMARY KEY,
    product_id NUMBER NOT NULL,
    user_id NUMBER NOT NULL,
    rating NUMBER(1) NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment CLOB,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE CASCADE,
    UNIQUE (product_id, user_id)
);

CREATE SEQUENCE review_id_seq START WITH 1 INCREMENT BY 1;

CREATE TRIGGER review_id_trigger
BEFORE INSERT ON review
FOR EACH ROW
BEGIN
  SELECT review_id_seq.NEXTVAL INTO :NEW.review_id FROM dual;
END;
/

-- ============================================
-- Create Indexes
-- ============================================

CREATE INDEX idx_product_category ON product(category_id);
CREATE INDEX idx_order_user ON "order"(user_id);
CREATE INDEX idx_order_item_order ON order_item(order_id);
CREATE INDEX idx_order_item_product ON order_item(product_id);
CREATE INDEX idx_review_product ON review(product_id);
CREATE INDEX idx_review_user ON review(user_id);
CREATE INDEX idx_order_date ON "order"(order_date);
CREATE INDEX idx_product_price ON product(price);

-- ============================================
-- Create Views
-- ============================================

CREATE OR REPLACE VIEW product_ratings AS
SELECT 
    p.product_id,
    p.name,
    COUNT(r.review_id) AS review_count,
    ROUND(AVG(r.rating), 2) AS average_rating
FROM product p
LEFT JOIN review r ON p.product_id = r.product_id
GROUP BY p.product_id, p.name;

COMMIT;
/
