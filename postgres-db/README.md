# PostgreSQL E-Commerce Database

## 📋 Project Description

This implementation uses **PostgreSQL**, a powerful open-source relational database management system (RDBMS) that follows the **ACID** principles (Atomicity, Consistency, Isolation, Durability).

### Key Characteristics of PostgreSQL:
- **Relational Model**: Data is organized in normalized tables with strict schemas
- **ACID Compliance**: Ensures data integrity and consistency
- **SQL Support**: Full support for complex queries, joins, and transactions
- **Constraints**: Foreign keys, unique constraints, and check constraints enforce data quality
- **Indexes**: B-tree indexes for fast query performance

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

## 🐳 Docker Setup

### Prerequisites
- Docker Desktop installed
- Docker Compose installed

### Starting the Database

```bash
cd postgres-db
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

## 🔌 Connecting to PostgreSQL

### Using psql CLI

```bash
docker exec -it ecommerce-postgres psql -U admin -d ecommerce
```

### Connection Details
- **Host**: localhost
- **Port**: 5432
- **Database**: ecommerce
- **Username**: admin
- **Password**: admin123

### Using pgAdmin or DBeaver
You can also connect using GUI tools like pgAdmin or DBeaver with the connection details above.

---

## 📊 Sample Queries

Once connected, you can run the queries from `queries.sql`:

### Example 1: View all products purchased by a user
```sql
SELECT DISTINCT u.username, p.name AS product_name, o.order_date
FROM "user" u
JOIN "order" o ON u.user_id = o.user_id
JOIN order_item oi ON o.order_id = oi.order_id
JOIN product p ON oi.product_id = p.product_id
WHERE u.user_id = 1
ORDER BY o.order_date DESC;
```

### Example 2: Top 5 most ordered products
```sql
SELECT p.name, SUM(oi.quantity) AS total_sold
FROM product p
JOIN order_item oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name
ORDER BY total_sold DESC
LIMIT 5;
```

### Running All Queries

```bash
docker exec -i ecommerce-postgres psql -U admin -d ecommerce < queries.sql
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

This PostgreSQL implementation demonstrates:

1. **Normalization** (3NF) - Eliminates data redundancy
2. **Referential Integrity** - Foreign key constraints maintain consistency
3. **Complex Joins** - Multi-table queries using INNER/LEFT joins
4. **Aggregations** - GROUP BY, COUNT, SUM, AVG operations
5. **CTEs** (Common Table Expressions) - For recommendation queries
6. **Indexes** - Performance optimization for common queries
7. **Views** - Reusable query abstractions

---

## 🔍 Useful Commands

### Check table structure
```sql
\d "user"
\d product
```

### List all tables
```sql
\dt
```

### View all users
```sql
SELECT * FROM "user";
```

### Check database size
```sql
SELECT pg_size_pretty(pg_database_size('ecommerce'));
```

### Exit psql
```
\q
```

---

## ⚖️ ACID vs BASE

**PostgreSQL follows ACID principles:**

- ✅ **Atomicity**: Transactions are all-or-nothing
- ✅ **Consistency**: Data follows all defined rules and constraints
- ✅ **Isolation**: Concurrent transactions don't interfere
- ✅ **Durability**: Committed data survives system failures

This contrasts with NoSQL databases (like MongoDB, Cassandra) which often follow BASE principles for higher scalability.

---

## 📝 Notes

- The schema is automatically created when the container starts
- Data is persisted in a Docker volume named `postgres_data`
- The `docker-entrypoint-initdb.d` mechanism runs schema.sql and seed.sql on first startup
- User and order are quoted as `"user"` and `"order"` because they are PostgreSQL reserved keywords

---

## 🚀 Next Steps

1. Explore the other database implementations (MongoDB, Redis, Neo4j, Cassandra)
2. Compare how the same data is modeled differently
3. Run performance benchmarks
4. Understand trade-offs between different database paradigms
