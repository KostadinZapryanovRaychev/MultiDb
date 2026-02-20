# MongoDB E-Commerce Database

## 📋 Project Description

This implementation uses **MongoDB**, a document-oriented NoSQL database that follows the **BASE** principles (Basically Available, Soft state, Eventually consistent).

### Key Characteristics of MongoDB:

- **Document Model**: Data is stored as flexible JSON-like documents (BSON)
- **Denormalization**: Related data is embedded within documents for fast reads
- **Schema Flexibility**: Documents can have varying structures
- **Horizontal Scalability**: Built for distributed systems and sharding
- **Aggregation Framework**: Powerful pipeline for data transformation
- **No JOINs**: Uses embedded documents and the $lookup operator instead

---

## 🗄️ Database Schema

### Document Structure Overview

Unlike PostgreSQL's normalized tables, MongoDB uses **embedded documents** and **denormalization**:

```
users (Collection)
  └─ {_id, username, email, fullName, passwordHash, createdAt}

categories (Collection)
  └─ {_id, name, description, createdAt}

products (Collection)
  ├─ {_id, name, description, price, stockQuantity}
  ├─ category: {id, name}  // Embedded category reference
  └─ reviews: [            // Embedded array of reviews
       {userId, username, rating, comment, reviewDate}
     ]

orders (Collection)
  ├─ {_id, userId, totalAmount, status, shippingAddress, orderDate}
  ├─ userInfo: {username, email, fullName}  // Denormalized user info
  └─ items: [                                // Embedded order items
       {productId, productName, quantity, priceAtPurchase, category}
     ]
```

### Collections

1. **users** - User accounts (similar to relational)
2. **categories** - Product categories (similar to relational)
3. **products** - Products with **embedded reviews** and **denormalized category**
4. **orders** - Orders with **embedded items** and **denormalized user info**

---

## 🔄 Key Differences from PostgreSQL

| Feature            | PostgreSQL                          | MongoDB                               |
| ------------------ | ----------------------------------- | ------------------------------------- |
| **Data Model**     | Normalized tables with foreign keys | Denormalized documents with embedding |
| **Schema**         | Rigid schema enforced               | Flexible schema with validation       |
| **Relationships**  | JOINs across tables                 | Embedded documents or $lookup         |
| **Reviews**        | Separate `review` table             | Embedded in `products`                |
| **Order Items**    | Separate `order_item` table         | Embedded in `orders`                  |
| **Query Language** | SQL                                 | JavaScript + Aggregation Pipeline     |
| **Consistency**    | ACID transactions                   | Eventual consistency (BASE)           |

---

## 🐳 Docker Setup

### Prerequisites

- Docker Desktop installed
- Docker Compose installed

### Starting the Database

```bash
cd mongodb-db
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

## 🔌 Connecting to MongoDB

### Using mongosh CLI

```bash
docker exec -it ecommerce-mongodb mongosh -u admin -p admin123 --authenticationDatabase admin
```

Then switch to the ecommerce database:

```javascript
use ecommerce
```

### Connection Details

- **Host**: localhost
- **Port**: 27017
- **Database**: ecommerce
- **Username**: admin
- **Password**: admin123
- **Auth Database**: admin

### Using MongoDB Compass or Studio 3T

Connection string:

```
mongodb://admin:admin123@localhost:27017/?authSource=admin
```

---

## 📊 Sample Queries

MongoDB uses the **Aggregation Pipeline** for complex queries:

### Example 1: View all products purchased by a user

```javascript
db.orders.aggregate([
  { $match: { "userInfo.username": "john_doe" } },
  { $unwind: "$items" },
  {
    $project: {
      productName: "$items.productName",
      quantity: "$items.quantity",
      orderDate: 1,
    },
  },
]);
```

### Example 2: Top 5 most ordered products

```javascript
db.orders.aggregate([
  { $unwind: "$items" },
  {
    $group: {
      _id: "$items.productId",
      productName: { $first: "$items.productName" },
      totalSold: { $sum: "$items.quantity" },
    },
  },
  { $sort: { totalSold: -1 } },
  { $limit: 5 },
]);
```

### Example 3: Average rating using embedded reviews

```javascript
db.products.aggregate([
  { $match: { "reviews.0": { $exists: true } } },
  { $unwind: "$reviews" },
  {
    $group: {
      _id: "$_id",
      productName: { $first: "$name" },
      avgRating: { $avg: "$reviews.rating" },
      reviewCount: { $sum: 1 },
    },
  },
  { $sort: { avgRating: -1 } },
]);
```

### Running All Queries

```bash
docker exec -i ecommerce-mongodb mongosh -u admin -p admin123 --authenticationDatabase admin < queries-mongo.js
```

---

## 📈 Data Statistics

- **Users**: 10
- **Categories**: 5
- **Products**: 20 (with embedded reviews)
- **Orders**: 15 (with embedded items)
- **Reviews**: 20+ (embedded in products)

---

## 🎯 Learning Outcomes

This MongoDB implementation demonstrates:

1. **Denormalization** - Embedding related data for fast reads
2. **Schema Validation** - JSON Schema for data quality
3. **Aggregation Pipeline** - Complex data transformations
4. **Document Model** - Flexible, nested data structures
5. **Embedded Arrays** - Reviews and order items
6. **$lookup** - MongoDB's version of JOINs
7. **Indexes** - Performance optimization on embedded fields

---

## 🔍 Useful Commands

### View all collections

```javascript
show collections
```

### Count documents

```javascript
db.users.countDocuments();
db.products.countDocuments();
```

### View a product with embedded reviews

```javascript
db.products.findOne({ name: "Wireless Headphones" });
```

### View an order with embedded items

```javascript
db.orders.findOne({}, { items: 1, userInfo: 1, totalAmount: 1 });
```

### Check indexes

```javascript
db.products.getIndexes();
```

### Database statistics

```javascript
db.stats();
```

### Exit mongosh

```
exit
```

---

## ⚖️ ACID vs BASE

**MongoDB follows BASE principles:**

- ✅ **Basically Available**: System available most of the time
- ✅ **Soft state**: State may change over time (eventual consistency)
- ✅ **Eventually consistent**: Data becomes consistent over time

This contrasts with PostgreSQL's strict ACID guarantees, offering:

- 🚀 Better horizontal scalability
- 🚀 Faster read operations (no JOINs needed)
- 🚀 Flexible schema evolution
- ⚠️ Trade-off: Potential data duplication and update complexity

---

## 📝 Design Decisions

### Why Embed Reviews in Products?

- ✅ Fast single-query retrieval
- ✅ Reviews are always accessed with product
- ✅ No need for separate collection
- ⚠️ Update complexity if user data changes

### Why Embed Items in Orders?

- ✅ Complete order snapshot in one document
- ✅ Historical pricing preserved
- ✅ No JOINs needed for order details
- ⚠️ Data duplication (product names, prices)

### Why Denormalize Category in Products?

- ✅ Avoid $lookup for category name
- ✅ Faster product listings
- ⚠️ Need to update if category name changes

---

## 🎓 MongoDB-Specific Features Used

- **JSON Schema Validation** - Type checking and constraints
- **Aggregation Pipeline** - $match, $unwind, $group, $lookup, $project
- **Embedded Documents** - Nested objects and arrays
- **Compound Indexes** - Multi-field indexes
- **$addToSet** - Collect unique values
- **$cond** - Conditional expressions
- **$size** - Array length

---

## 🚀 Next Steps

1. Compare query performance with PostgreSQL
2. Explore how denormalization affects update operations
3. Test schema flexibility by adding new fields
4. Implement more complex aggregation pipelines
5. Move to Neo4j (graph) or Redis (key-value) implementations

---

## 💡 When to Use MongoDB vs PostgreSQL

**Use MongoDB when:**

- Schema changes frequently
- Need horizontal scalability
- Read-heavy workload
- Complex nested data structures
- Rapid prototyping

**Use PostgreSQL when:**

- Strong consistency required
- Complex transactions needed
- Strict data integrity essential
- Many-to-many relationships
- Mature reporting tools needed
