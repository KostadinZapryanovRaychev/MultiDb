# MySQL E-Commerce Database

## 📋 Project Description

This implementation uses **MySQL 8.0**, one of the world's most popular open-source relational database management systems (RDBMS) that follows the **ACID** principles.

### Key Characteristics of MySQL:
- **Relational Model**: Data is organized in normalized tables with strict schemas
- **ACID Compliance**: Ensures data integrity and consistency
- **InnoDB Engine**: Default storage engine with transaction support
- **Performance**: Optimized for read-heavy workloads
- **ENUM Types**: Native support for enumerated values
- **Window Functions**: Advanced analytics (MySQL 8.0+)
- **UTF-8 Support**: Full Unicode character support

---

## 🗄️ Database Schema

### Entity Relationship Overview

```
User (1) ──────< (N) Order (1) ──────< (N) OrderItem (N) >────── (1) Product (N) >────── (1) Category
  │                                                                        │
  │                                                                        │
  └──────────────────────< (N) Review (N) >──────────────────────────────┘
```

### Tables

1. **user** - Stores customer information
2. **category** - Product categories
3. **product** - Product catalog with foreign key to category
4. **order** - Customer orders with foreign key to user
5. **order_item** - Junction table linking orders and products (many-to-many)
6. **review** - Product reviews with foreign keys to user and product

---

## 🔑 MySQL-Specific Features

### Key Differences from PostgreSQL

| Feature | PostgreSQL | MySQL |
|---------|-----------|--------|
| **Auto Increment** | SERIAL | AUTO_INCREMENT |
| **String Concatenation** | \|\| or CONCAT | CONCAT or CONCAT_WS |
| **Date Functions** | TO_CHAR() | DATE_FORMAT() |
| **Boolean Type** | BOOLEAN | TINYINT(1) |
| **ENUM Support** | Custom types | Native ENUM |
| **Stored Procedures** | PL/pgSQL | SQL/PSM |
| **Full-Text Search** | Built-in advanced | FULLTEXT index |
| **Case Sensitivity** | Sensitive | Depends on collation |

### MySQL Advantages

- ✅ **ENUM types** - Built-in for status fields
- ✅ **ON UPDATE CURRENT_TIMESTAMP** - Automatic timestamp updates
- ✅ **FULLTEXT indexes** - Fast text search
- ✅ **Simpler replication** - Master-slave setup
- ✅ **Wide adoption** - Extensive community support

---

## 🐳 Docker Setup

### Prerequisites
- Docker Desktop installed
- Docker Compose installed

### Starting the Database

```bash
cd mysql-db
docker compose up -d
```

### Stopping the Database

```bash
docker compose down
```

### Stopping and Removing Data

```bash
docker compose down -v
```

---

## 🔌 Connecting to MySQL

### Using mysql CLI

```bash
docker exec -it ecommerce-mysql mysql -u admin -padmin123 ecommerce
```

**Note:** No space between `-p` and password in MySQL CLI!

### Connection Details
- **Host**: localhost
- **Port**: 3306
- **Database**: ecommerce
- **Username**: admin
- **Password**: admin123

### Using MySQL Workbench or DBeaver
Connect using the connection details above. MySQL Workbench is the official GUI tool.

---

## 📊 Sample Queries

Once connected, you can run the queries from `queries.sql`:

### Example 1: View all products purchased by a user
```sql
SELECT DISTINCT u.username, p.name AS product_name, o.order_date
FROM `user` u
INNER JOIN `order` o ON u.user_id = o.user_id
INNER JOIN order_item oi ON o.order_id = oi.order_id
INNER JOIN product p ON oi.product_id = p.product_id
WHERE u.user_id = 1
ORDER BY o.order_date DESC;
```

### Example 2: Top 5 most ordered products
```sql
SELECT p.name, SUM(oi.quantity) AS total_sold
FROM product p
INNER JOIN order_item oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name
ORDER BY total_sold DESC
LIMIT 5;
```

### Example 3: Using ENUM status field
```sql
SELECT order_id, total_amount, status
FROM `order`
WHERE status IN ('processing', 'shipped')
ORDER BY order_date DESC;
```

### Running All Queries

```bash
docker exec -i ecommerce-mysql mysql -u admin -padmin123 ecommerce < queries.sql
```

---

## 📈 Data Statistics

- **Users**: 10
- **Categories**: 5
- **Products**: 20
- **Orders**: 15
- **Order Items**: Multiple items per order
- **Reviews**: 20+ reviews across products

---

## 🎯 Learning Outcomes

This MySQL implementation demonstrates:

1. **Normalization** (3NF) - Eliminates data redundancy
2. **InnoDB Engine** - ACID compliance with foreign keys
3. **ENUM Types** - Efficient status field storage
4. **AUTO_INCREMENT** - MySQL's primary key generation
5. **DATE_FORMAT()** - MySQL date formatting functions
6. **Window Functions** - RANK(), DENSE_RANK(), ROW_NUMBER() (MySQL 8.0+)
7. **Stored Procedures** - Reusable SQL logic
8. **FULLTEXT Search** - Fast text searching capabilities
9. **Views** - Pre-defined query abstractions
10. **UTF-8 Unicode** - Full international character support

---

## 🔍 Useful Commands

### Show all tables
```sql
SHOW TABLES;
```

### Describe table structure
```sql
DESCRIBE `user`;
DESCRIBE product;
```

### Show table creation statement
```sql
SHOW CREATE TABLE product;
```

### View indexes on a table
```sql
SHOW INDEX FROM product;
```

### Check database size
```sql
SELECT 
    table_schema AS 'Database',
    ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS 'Size (MB)'
FROM information_schema.tables
WHERE table_schema = 'ecommerce'
GROUP BY table_schema;
```

### View all users
```sql
SELECT * FROM `user`;
```

### Check MySQL version
```sql
SELECT VERSION();
```

### Show current database
```sql
SELECT DATABASE();
```

### Exit mysql CLI
```
exit
```

---

## ⚖️ ACID Compliance

**MySQL with InnoDB follows ACID principles:**

- ✅ **Atomicity**: Transactions are all-or-nothing
- ✅ **Consistency**: Data follows all defined rules and constraints
- ✅ **Isolation**: Concurrent transactions don't interfere
- ✅ **Durability**: Committed data survives system failures

**Transaction Example:**
```sql
START TRANSACTION;

UPDATE product SET stock_quantity = stock_quantity - 1 WHERE product_id = 1;
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) 
VALUES (1, 1, 1, 129.99);

COMMIT; -- or ROLLBACK;
```

---

## 📝 MySQL vs PostgreSQL

### When to Use MySQL

**Use MySQL when:**
- ✅ Read-heavy workload (blogs, content sites)
- ✅ Simple, straightforward queries
- ✅ Web applications (WordPress, Drupal)
- ✅ Need wide hosting support
- ✅ Replication is primary concern
- ✅ Team familiar with MySQL

**Use PostgreSQL when:**
- ✅ Complex queries and analytics
- ✅ Need advanced data types (JSON, arrays)
- ✅ Write-heavy workload
- ✅ Need PostGIS for geospatial data
- ✅ Stricter SQL standards compliance
- ✅ Advanced indexing requirements

---

## 🎓 MySQL 8.0+ Advanced Features

### Window Functions (Used in queries.sql)
```sql
SELECT 
    product_id,
    name,
    price,
    RANK() OVER (ORDER BY price DESC) AS price_rank,
    DENSE_RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS category_price_rank
FROM product;
```

### Common Table Expressions (CTEs)
```sql
WITH TopCustomers AS (
    SELECT user_id, SUM(total_amount) AS total_spent
    FROM `order`
    GROUP BY user_id
    ORDER BY total_spent DESC
    LIMIT 10
)
SELECT u.username, tc.total_spent
FROM TopCustomers tc
JOIN `user` u ON tc.user_id = u.user_id;
```

### JSON Support (MySQL 8.0+)
```sql
-- Store JSON data
ALTER TABLE product ADD COLUMN attributes JSON;

UPDATE product 
SET attributes = '{"color": "black", "wireless": true}'
WHERE product_id = 1;

-- Query JSON data
SELECT name, attributes->>'$.color' AS color
FROM product
WHERE attributes->>'$.wireless' = 'true';
```

---

## 🔐 Security Best Practices

### User Management
```sql
-- Create read-only user
CREATE USER 'readonly'@'localhost' IDENTIFIED BY 'secure_password';
GRANT SELECT ON ecommerce.* TO 'readonly'@'localhost';

-- Create app user with limited privileges
CREATE USER 'app_user'@'%' IDENTIFIED BY 'app_password';
GRANT SELECT, INSERT, UPDATE, DELETE ON ecommerce.* TO 'app_user'@'%';

FLUSH PRIVILEGES;
```

### Prepared Statements (SQL Injection Prevention)
```sql
PREPARE stmt FROM 'SELECT * FROM product WHERE product_id = ?';
SET @id = 1;
EXECUTE stmt USING @id;
DEALLOCATE PREPARE stmt;
```

---

## 🚀 Performance Optimization

### Indexing Strategy
```sql
-- Already created in schema.sql:
-- - Primary keys (clustered indexes)
-- - Foreign keys (for JOINs)
-- - Commonly searched columns

-- Add composite index for common query pattern
CREATE INDEX idx_order_user_date ON `order`(user_id, order_date);

-- Analyze table statistics
ANALYZE TABLE product;
```

### Query Optimization
```sql
-- Use EXPLAIN to analyze query performance
EXPLAIN SELECT * FROM product WHERE price > 100;

-- Use EXPLAIN ANALYZE (MySQL 8.0.18+)
EXPLAIN ANALYZE 
SELECT p.name, COUNT(oi.order_item_id)
FROM product p
LEFT JOIN order_item oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name;
```

---

## 📚 Additional Resources

- **Official Documentation**: https://dev.mysql.com/doc/
- **MySQL Workbench**: https://www.mysql.com/products/workbench/
- **Tutorials**: https://www.mysqltutorial.org/
- **Performance Tuning**: https://dev.mysql.com/doc/refman/8.0/en/optimization.html

---

## 🚀 Next Steps

1. **Compare with PostgreSQL**: Notice differences in syntax and features
2. **Test transactions**: Try ROLLBACK and COMMIT operations
3. **Experiment with stored procedures**: Create reusable SQL logic
4. **Try window functions**: Analyze data with advanced analytics
5. **Benchmark performance**: Compare query speeds with PostgreSQL
6. **Explore replication**: Set up master-slave configuration

---

## 💡 Key Takeaways

### MySQL Strengths:
- 🚀 **Fast reads** - Optimized for SELECT queries
- 🔧 **Easy to use** - Simpler learning curve
- 🌍 **Wide adoption** - Large community and hosting support
- 📦 **Lightweight** - Lower resource requirements

### Trade-offs:
- ⚠️ **Less features** than PostgreSQL (historically)
- ⚠️ **Storage engines** can be confusing (InnoDB vs MyISAM)
- ⚠️ **SQL compliance** is less strict than PostgreSQL

---

## 🎯 Project Comparison Summary

| Database | Model | Strengths | Use Case |
|----------|-------|-----------|----------|
| **PostgreSQL** | Relational | Advanced features, strict compliance | Complex analytics |
| **MySQL** | Relational | Speed, simplicity, wide support | Web applications |
| **MongoDB** | Document | Flexibility, scalability | Rapidly changing schemas |
| **Redis** | Key-Value | Ultra-fast, in-memory | Caching, sessions |
| **Neo4j** | Graph | Relationships, traversals | Social networks |
| **Cassandra** | Wide-Column | Massive scale, availability | Time-series data |

Your MySQL implementation is now complete! 🎉
