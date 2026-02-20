// ============================================
// MongoDB E-Commerce Database - Initialization
// ============================================

// Switch to ecommerce database
db = db.getSiblingDB("ecommerce");

// ============================================
// Create Collections with Validation
// ============================================

// Users Collection
db.createCollection("users", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["username", "email", "fullName", "passwordHash"],
      properties: {
        username: {
          bsonType: "string",
          description: "Username must be a string and is required",
        },
        email: {
          bsonType: "string",
          pattern: "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$",
          description: "Email must be a valid email address",
        },
        fullName: {
          bsonType: "string",
          description: "Full name must be a string",
        },
        passwordHash: {
          bsonType: "string",
          description: "Password hash must be a string",
        },
        createdAt: {
          bsonType: "date",
          description: "Creation timestamp",
        },
        updatedAt: {
          bsonType: "date",
          description: "Last update timestamp",
        },
      },
    },
  },
});

// Categories Collection
db.createCollection("categories", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["name"],
      properties: {
        name: {
          bsonType: "string",
          description: "Category name must be a string and is required",
        },
        description: {
          bsonType: "string",
          description: "Category description",
        },
        createdAt: {
          bsonType: "date",
          description: "Creation timestamp",
        },
      },
    },
  },
});

// Products Collection (with embedded category info for denormalization)
db.createCollection("products", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["name", "price", "category"],
      properties: {
        name: {
          bsonType: "string",
          description: "Product name must be a string",
        },
        description: {
          bsonType: "string",
          description: "Product description",
        },
        price: {
          bsonType: "number",
          minimum: 0,
          description: "Price must be a positive number",
        },
        stockQuantity: {
          bsonType: "int",
          minimum: 0,
          description: "Stock quantity must be a non-negative integer",
        },
        category: {
          bsonType: "object",
          required: ["id", "name"],
          properties: {
            id: {
              bsonType: "objectId",
              description: "Category ID reference",
            },
            name: {
              bsonType: "string",
              description: "Category name (denormalized)",
            },
          },
        },
        reviews: {
          bsonType: "array",
          description: "Embedded reviews array",
          items: {
            bsonType: "object",
            required: ["userId", "username", "rating"],
            properties: {
              userId: {
                bsonType: "objectId",
                description: "User ID who wrote the review",
              },
              username: {
                bsonType: "string",
                description: "Username (denormalized)",
              },
              rating: {
                bsonType: "int",
                minimum: 1,
                maximum: 5,
                description: "Rating must be between 1 and 5",
              },
              comment: {
                bsonType: "string",
                description: "Review comment",
              },
              reviewDate: {
                bsonType: "date",
                description: "Review timestamp",
              },
            },
          },
        },
        createdAt: {
          bsonType: "date",
          description: "Creation timestamp",
        },
        updatedAt: {
          bsonType: "date",
          description: "Last update timestamp",
        },
      },
    },
  },
});

// Orders Collection (with embedded items and user info)
db.createCollection("orders", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["userId", "items", "totalAmount", "status"],
      properties: {
        userId: {
          bsonType: "objectId",
          description: "User ID who placed the order",
        },
        userInfo: {
          bsonType: "object",
          properties: {
            username: { bsonType: "string" },
            email: { bsonType: "string" },
            fullName: { bsonType: "string" },
          },
        },
        items: {
          bsonType: "array",
          minItems: 1,
          items: {
            bsonType: "object",
            required: [
              "productId",
              "productName",
              "quantity",
              "priceAtPurchase",
            ],
            properties: {
              productId: { bsonType: "objectId" },
              productName: { bsonType: "string" },
              quantity: { bsonType: "int", minimum: 1 },
              priceAtPurchase: { bsonType: "number", minimum: 0 },
              category: { bsonType: "string" },
            },
          },
        },
        totalAmount: {
          bsonType: "number",
          minimum: 0,
          description: "Total order amount",
        },
        status: {
          enum: ["pending", "processing", "shipped", "delivered", "cancelled"],
          description: "Order status",
        },
        shippingAddress: {
          bsonType: "string",
          description: "Shipping address",
        },
        orderDate: {
          bsonType: "date",
          description: "Order timestamp",
        },
      },
    },
  },
});

// ============================================
// Create Indexes for Performance
// ============================================

// Users indexes
db.users.createIndex({ username: 1 }, { unique: true });
db.users.createIndex({ email: 1 }, { unique: true });

// Products indexes
db.products.createIndex({ name: 1 });
db.products.createIndex({ "category.id": 1 });
db.products.createIndex({ price: 1 });
db.products.createIndex({ "reviews.userId": 1 });

// Orders indexes
db.orders.createIndex({ userId: 1 });
db.orders.createIndex({ orderDate: -1 });
db.orders.createIndex({ status: 1 });
db.orders.createIndex({ "items.productId": 1 });

// Categories indexes
db.categories.createIndex({ name: 1 }, { unique: true });

print("✅ MongoDB collections and indexes created successfully!");
