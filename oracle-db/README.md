# Oracle Database E-Commerce

## 📋 Project Description

This implementation uses **Oracle Database 23ai**, a powerful enterprise-grade relational database management system (RDBMS) that follows **ACID** principles and includes AI capabilities built-in.

### Key Characteristics of Oracle:
- **Enterprise-Grade**: Designed for mission-critical applications
- **ACID Compliance**: Full transactional integrity and consistency
- **Advanced Features**: Sequences, triggers, partitioning, compression
- **Security**: Row-level security, encryption, auditing
- **Scalability**: Horizontal scaling with Oracle RAC
- **AI Capabilities**: Built-in ML and AI features (23ai)
- **Performance**: Optimized query execution engine

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
5. **order_item** - Junction table linking orders and products
6. **review** - Product reviews with foreign keys to user and product

### Oracle-Specific Features Used

- **Sequences**: Auto-incrementing IDs using `user_id_seq`, `product_id_seq`, etc.
- **Triggers**: Auto-population of primary keys from sequences
- **CLOB Data Type**: For large text fields (description, comment, shipping_address)
- **TIMESTAMP**: Precise date/time tracking
- **CHECK Constraints**: Data validation at database level
- **Views**: Pre-defined query abstractions (product_ratings)

---

## 🐳 Docker Setup

### Prerequisites
- Docker installed on your macOS system
- At least 4 CPU cores and 8GB of RAM
- Sufficient disk space (Oracle image is large, ~10GB)

### Environment Variables

The `.env` file contains:
```
ADMIN_PASSWORD=OracleAdmin2025
WALLET_PASSWORD=OracleWallet2025
WORKLOAD_TYPE=ATP
```

### Starting the Database

From the `oracle-db` directory:

```bash
docker compose up -d --build
```

This will:
1. Build the Oracle image from the Dockerfile
2. Create a container named `ecommerce-oracle-db`
3. Initialize the database (takes 5-10 minutes)
4. Load schema and seed data

### Monitoring Installation Progress

```bash
docker logs -f ecommerce-oracle-db
```

Wait for the message: `DATABASE IS READY TO USE!`

### Stopping the Database

```bash
docker compose down
```

### Stopping and Removing Data

```bash
docker compose down -v
```

---

## 🔌 Connecting to Oracle Database

### Using SQLPlus (CLI)

```bash
docker exec -it ecommerce-oracle-db sqlplus admin/OracleAdmin2025@FREEPDB1
```

### Connection Details
- **Host**: localhost
- **Port**: 1521
- **Service Name**: FREEPDB1
- **Username**: admin
- **Password**: OracleAdmin2025

### Using Oracle SQL Developer

Download Oracle SQL Developer and create a connection:
- **Connection Name**: Local Oracle
- **Username**: admin
- **Password**: OracleAdmin2025
- **Hostname**: localhost
- **Port**: 1521
- **Service Name**: FREEPDB1

### Using VS Code with Oracle Extension

1. Install "Oracle Developer Tools for VS Code" extension
2. Create a new connection with details above
3. Start executing queries

### Oracle REST Data Services

Access the Oracle REST API at:
[https://localhost:8443/ords](https://localhost:8443/ords)

---

## 📊 Sample Queries

Once connected, you can run queries from `queries.sql`:

### Example 1: View all products purchased by a user
```sql
SELECT DISTINCT u.username, p.name AS product_name, o.order_date
FROM "user" u
INNER JOIN "order" o ON u.user_id = o.user_id
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
FETCH FIRST 5 ROWS ONLY;
```

### Example 3: Using Oracle Sequences
```sql
-- Sequences are used automatically via triggers
-- Insert automatically gets the next ID:
INSERT INTO "user" (username, email, full_name, password_hash) 
VALUES ('newuser', 'new@example.com', 'New User', 'hash');
-- The user_id will be auto-populated from user_id_seq
```

### Running All Queries

```bash
docker exec -it ecommerce-oracle-db sqlplus admin/OracleAdmin2025@FREEPDB1 @queries.sql
```

---

## 📈 Data Statistics

- **Users**: 10
- **Categories**: 5
- **Products**: 20
- **Orders**: 15
- **Order Items**: 26
- **Reviews**: 22

---

## 🎯 Learning Outcomes

This Oracle implementation demonstrates:

1. **Sequences** - Auto-increment ID generation
2. **Triggers** - Automatic field population
3. **CLOB Data Type** - Large text storage
4. **Constraints** - Check, unique, foreign key validation
5. **Views** - Materialized and regular views
6. **Indexing** - B-tree indexes for performance
7. **FETCH FIRST/NEXT** - Oracle's limit syntax
8. **Transactions** - COMMIT and ROLLBACK
9. **Enterprise Features** - Security, auditing capabilities

---

## 🔍 Useful Commands

### Connect to database
```sql
sqlplus admin/OracleAdmin2025@FREEPDB1
```

### View all tables
```sql
SELECT table_name FROM user_tables;
```

### Describe table structure
```sql
DESC "user";
DESC product;
```

### View sequences
```sql
SELECT sequence_name, increment_by FROM user_sequences;
```

### View triggers
```sql
SELECT trigger_name, table_name FROM user_triggers;
```

### Count records
```sql
SELECT COUNT(*) FROM "user";
SELECT COUNT(*) FROM product;
```

### View all indexes
```sql
SELECT index_name, table_name FROM user_indexes;
```

### Check current user
```sql
SHOW USER;
```

### Exit SQLPlus
```
EXIT;
```

---

## ⚖️ ACID Compliance

**Oracle fully implements ACID principles:**

- ✅ **Atomicity**: All-or-nothing transactions with ROLLBACK support
- ✅ **Consistency**: Constraints enforced at database level
- ✅ **Isolation**: Multiple isolation levels available
- ✅ **Durability**: Committed data persists through crashes

**Transaction Example:**
```sql
START TRANSACTION;

UPDATE product SET stock_quantity = stock_quantity - 1 WHERE product_id = 1;
INSERT INTO order_item (order_id, product_id, quantity, price_at_purchase) 
VALUES (1, 1, 1, 129.99);

COMMIT;  -- or ROLLBACK;
```

---

## 📝 Oracle vs PostgreSQL vs MySQL

| Feature | Oracle | PostgreSQL | MySQL |
|---------|--------|-----------|--------|
| **Sequences** | Native | Native | AUTO_INCREMENT |
| **Triggers** | Advanced | Good | Basic |
| **Data Types** | CLOB, BLOB | Text, bytea | TEXT |
| **FETCH Limit** | FETCH FIRST N | LIMIT N | LIMIT N |
| **Enterprise** | ✅ | ✅ | ⚠️ |
| **Cost** | ⚠️ Expensive | ✅ Free | ✅ Free |
| **Scalability** | ✅ Excellent | ✅ Good | ✅ Good |

---

## 🎓 Oracle 23ai Advanced Features

### JSON Support
```sql
-- Store and query JSON data
SELECT JSON_VALUE(product, '$.name') FROM product;
```

### AI Vector Search (23ai)
```sql
-- Built-in vector capabilities for AI/ML
CREATE TABLE product_embeddings (
    product_id NUMBER,
    embedding VECTOR
);
```

### Autonomous Database Features
```sql
-- Oracle manages backups, patching automatically
-- Available in cloud deployments
```

---

## 🔐 Security Best Practices

### Create Application User
```sql
CREATE USER app_user IDENTIFIED BY "SecurePassword123";
GRANT SELECT, INSERT, UPDATE, DELETE ON "user" TO app_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON product TO app_user;
-- Grant other tables as needed
```

### Enable Auditing
```sql
AUDIT INSERT, UPDATE, DELETE ON product;
AUDIT INSERT ON "order";
```

### Row-Level Security
```sql
CREATE POLICY user_orders_policy
  ON "order"
  USING (user_id = SYS_CONTEXT('USERENV', 'USER_ID'));
```

---

## 🚀 Performance Optimization

### Create Indexes for Common Queries
```sql
CREATE INDEX idx_user_email ON "user"(email);
CREATE INDEX idx_product_category ON product(category_id);
CREATE INDEX idx_order_date ON "order"(order_date);
```

### Analyze Table Statistics
```sql
ANALYZE TABLE product COMPUTE STATISTICS;
ANALYZE TABLE "order" COMPUTE STATISTICS;
```

### Explain Plan
```sql
EXPLAIN PLAN FOR
SELECT p.name, COUNT(oi.order_item_id)
FROM product p
LEFT JOIN order_item oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name;

SELECT plan_table_output FROM table(dbms_xplan.display());
```

---

## 📚 Additional Resources

- **Oracle Documentation**: https://docs.oracle.com/
- **Oracle SQL Reference**: https://docs.oracle.com/en/database/oracle/oracle-database/23/sqlrf/
- **Oracle SQL Developer**: https://www.oracle.com/tools/downloads/sqldev-downloads.html
- **Oracle Learning**: https://www.oracle.com/education/

---

## 🚀 Next Steps

1. **Explore Sequences**: Understand how auto-increment works in Oracle
2. **Create Triggers**: Learn event-driven programming in Oracle
3. **Test Transactions**: Practice COMMIT and ROLLBACK
4. **Use SQL Developer**: Set up the enterprise IDE
5. **Compare Performance**: Benchmark against PostgreSQL/MySQL
6. **Explore AI Features**: Try vector search in 23ai

---

## 💡 Key Takeaways

### Oracle Strengths:
- 🏢 **Enterprise**: Built for mission-critical systems
- 🔒 **Security**: Advanced row-level security
- 🚀 **Performance**: Highly optimized execution
- 🧠 **AI/ML**: Built-in vector and ML capabilities
- 📈 **Scalability**: RAC for distributed systems

### Trade-offs:
- 💰 **Cost**: Expensive licensing (though free version available)
- 📚 **Complexity**: Steep learning curve
- 🔧 **Setup**: More configuration needed
- 📦 **Resource Heavy**: Requires more CPU/RAM

---

## 🎯 Project Comparison Summary

| Database | Model | Strengths | Best For |
|----------|-------|-----------|----------|
| **PostgreSQL** | Relational | Advanced SQL, JSON | Complex analytics |
| **MySQL** | Relational | Speed, simplicity | Web applications |
| **Oracle** | Relational | Enterprise, security | Mission-critical |
| **MongoDB** | Document | Flexibility, scalability | Rapid development |
| **Redis** | Key-Value | Ultra-fast, caching | Real-time data |
| **Neo4j** | Graph | Relationships | Social networks |

Your Oracle implementation is now complete! 🎉
