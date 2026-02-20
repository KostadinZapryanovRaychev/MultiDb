// ============================================
// MongoDB E-Commerce Database - Seed Data
// ============================================

db = db.getSiblingDB("ecommerce");

print("🌱 Starting data seeding...");

// ============================================
// Insert Categories (5 categories)
// ============================================

const categories = [
  {
    _id: ObjectId(),
    name: "Electronics",
    description: "Electronic devices and gadgets",
    createdAt: new Date(),
  },
  {
    _id: ObjectId(),
    name: "Books",
    description: "Physical and digital books",
    createdAt: new Date(),
  },
  {
    _id: ObjectId(),
    name: "Clothing",
    description: "Apparel and fashion items",
    createdAt: new Date(),
  },
  {
    _id: ObjectId(),
    name: "Home & Kitchen",
    description: "Home appliances and kitchen tools",
    createdAt: new Date(),
  },
  {
    _id: ObjectId(),
    name: "Sports",
    description: "Sports equipment and fitness gear",
    createdAt: new Date(),
  },
];

db.categories.insertMany(categories);
print(`✅ Inserted ${categories.length} categories`);

// ============================================
// Insert Users (10 users)
// ============================================

const users = [
  {
    _id: ObjectId(),
    username: "john_doe",
    email: "john@example.com",
    fullName: "John Doe",
    passwordHash: "$2b$12$abcdefghijklmnopqrstuvwxyz123456",
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: ObjectId(),
    username: "jane_smith",
    email: "jane@example.com",
    fullName: "Jane Smith",
    passwordHash: "$2b$12$abcdefghijklmnopqrstuvwxyz123457",
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: ObjectId(),
    username: "mike_jones",
    email: "mike@example.com",
    fullName: "Mike Jones",
    passwordHash: "$2b$12$abcdefghijklmnopqrstuvwxyz123458",
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: ObjectId(),
    username: "sarah_wilson",
    email: "sarah@example.com",
    fullName: "Sarah Wilson",
    passwordHash: "$2b$12$abcdefghijklmnopqrstuvwxyz123459",
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: ObjectId(),
    username: "david_brown",
    email: "david@example.com",
    fullName: "David Brown",
    passwordHash: "$2b$12$abcdefghijklmnopqrstuvwxyz123460",
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: ObjectId(),
    username: "emma_davis",
    email: "emma@example.com",
    fullName: "Emma Davis",
    passwordHash: "$2b$12$abcdefghijklmnopqrstuvwxyz123461",
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: ObjectId(),
    username: "chris_miller",
    email: "chris@example.com",
    fullName: "Chris Miller",
    passwordHash: "$2b$12$abcdefghijklmnopqrstuvwxyz123462",
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: ObjectId(),
    username: "lisa_taylor",
    email: "lisa@example.com",
    fullName: "Lisa Taylor",
    passwordHash: "$2b$12$abcdefghijklmnopqrstuvwxyz123463",
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: ObjectId(),
    username: "tom_anderson",
    email: "tom@example.com",
    fullName: "Tom Anderson",
    passwordHash: "$2b$12$abcdefghijklmnopqrstuvwxyz123464",
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: ObjectId(),
    username: "amy_thomas",
    email: "amy@example.com",
    fullName: "Amy Thomas",
    passwordHash: "$2b$12$abcdefghijklmnopqrstuvwxyz123465",
    createdAt: new Date(),
    updatedAt: new Date(),
  },
];

db.users.insertMany(users);
print(`✅ Inserted ${users.length} users`);

// ============================================
// Insert Products (20 products with embedded reviews)
// ============================================

const products = [
  // Electronics
  {
    _id: ObjectId(),
    name: "Wireless Headphones",
    description: "Bluetooth noise-cancelling headphones",
    price: 129.99,
    stockQuantity: 50,
    category: { id: categories[0]._id, name: "Electronics" },
    reviews: [
      {
        userId: users[0]._id,
        username: "john_doe",
        rating: 5,
        comment: "Amazing sound quality! Best headphones I have ever owned.",
        reviewDate: new Date(),
      },
      {
        userId: users[7]._id,
        username: "lisa_taylor",
        rating: 4,
        comment: "Great headphones but a bit pricey.",
        reviewDate: new Date(),
      },
      {
        userId: users[3]._id,
        username: "sarah_wilson",
        rating: 5,
        comment: "Noise cancellation works perfectly.",
        reviewDate: new Date(),
      },
    ],
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: ObjectId(),
    name: "Smart Watch",
    description: "Fitness tracking smartwatch with heart rate monitor",
    price: 249.99,
    stockQuantity: 30,
    category: { id: categories[0]._id, name: "Electronics" },
    reviews: [
      {
        userId: users[0]._id,
        username: "john_doe",
        rating: 4,
        comment: "Good fitness tracking, battery life could be better.",
        reviewDate: new Date(),
      },
      {
        userId: users[3]._id,
        username: "sarah_wilson",
        rating: 5,
        comment: "Love the heart rate monitor and sleep tracking!",
        reviewDate: new Date(),
      },
    ],
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: ObjectId(),
    name: "Laptop Stand",
    description: "Adjustable aluminum laptop stand",
    price: 49.99,
    stockQuantity: 100,
    category: { id: categories[0]._id, name: "Electronics" },
    reviews: [
      {
        userId: users[0]._id,
        username: "john_doe",
        rating: 5,
        comment: "Sturdy and adjustable, perfect for my setup.",
        reviewDate: new Date(),
      },
    ],
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: ObjectId(),
    name: "USB-C Hub",
    description: "7-in-1 USB-C hub with HDMI and ethernet",
    price: 39.99,
    stockQuantity: 75,
    category: { id: categories[0]._id, name: "Electronics" },
    reviews: [],
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  // Books
  {
    _id: ObjectId(),
    name: "Database Design",
    description: "Complete guide to database systems",
    price: 59.99,
    stockQuantity: 40,
    category: { id: categories[1]._id, name: "Books" },
    reviews: [
      {
        userId: users[3]._id,
        username: "sarah_wilson",
        rating: 5,
        comment: "Comprehensive guide, very helpful for my studies.",
        reviewDate: new Date(),
      },
    ],
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: ObjectId(),
    name: "Python Programming",
    description: "Learn Python from scratch",
    price: 44.99,
    stockQuantity: 60,
    category: { id: categories[1]._id, name: "Books" },
    reviews: [
      {
        userId: users[3]._id,
        username: "sarah_wilson",
        rating: 4,
        comment: "Good introduction to Python.",
        reviewDate: new Date(),
      },
      {
        userId: users[4]._id,
        username: "david_brown",
        rating: 5,
        comment: "Clear explanations and great examples.",
        reviewDate: new Date(),
      },
    ],
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: ObjectId(),
    name: "Web Development",
    description: "Full-stack web development guide",
    price: 54.99,
    stockQuantity: 35,
    category: { id: categories[1]._id, name: "Books" },
    reviews: [
      {
        userId: users[8]._id,
        username: "tom_anderson",
        rating: 5,
        comment: "Best web dev book I have read!",
        reviewDate: new Date(),
      },
    ],
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: ObjectId(),
    name: "Data Structures",
    description: "Algorithms and data structures explained",
    price: 49.99,
    stockQuantity: 45,
    category: { id: categories[1]._id, name: "Books" },
    reviews: [
      {
        userId: users[8]._id,
        username: "tom_anderson",
        rating: 4,
        comment: "Clear explanations of complex topics.",
        reviewDate: new Date(),
      },
    ],
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  // Clothing
  {
    _id: ObjectId(),
    name: "Cotton T-Shirt",
    description: "Comfortable 100% cotton t-shirt",
    price: 19.99,
    stockQuantity: 200,
    category: { id: categories[2]._id, name: "Clothing" },
    reviews: [],
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: ObjectId(),
    name: "Denim Jeans",
    description: "Classic blue denim jeans",
    price: 69.99,
    stockQuantity: 80,
    category: { id: categories[2]._id, name: "Clothing" },
    reviews: [],
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: ObjectId(),
    name: "Running Shoes",
    description: "Lightweight running shoes",
    price: 89.99,
    stockQuantity: 60,
    category: { id: categories[2]._id, name: "Clothing" },
    reviews: [
      {
        userId: users[1]._id,
        username: "jane_smith",
        rating: 5,
        comment: "Very comfortable for long runs.",
        reviewDate: new Date(),
      },
      {
        userId: users[5]._id,
        username: "emma_davis",
        rating: 4,
        comment: "Good quality but sizing runs a bit small.",
        reviewDate: new Date(),
      },
    ],
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: ObjectId(),
    name: "Winter Jacket",
    description: "Warm waterproof winter jacket",
    price: 149.99,
    stockQuantity: 40,
    category: { id: categories[2]._id, name: "Clothing" },
    reviews: [
      {
        userId: users[6]._id,
        username: "chris_miller",
        rating: 5,
        comment: "Kept me warm all winter, excellent quality.",
        reviewDate: new Date(),
      },
    ],
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  // Home & Kitchen
  {
    _id: ObjectId(),
    name: "Coffee Maker",
    description: "Programmable drip coffee maker",
    price: 79.99,
    stockQuantity: 50,
    category: { id: categories[3]._id, name: "Home & Kitchen" },
    reviews: [
      {
        userId: users[2]._id,
        username: "mike_jones",
        rating: 5,
        comment: "Makes excellent coffee every morning!",
        reviewDate: new Date(),
      },
    ],
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: ObjectId(),
    name: "Blender",
    description: "High-speed blender for smoothies",
    price: 99.99,
    stockQuantity: 45,
    category: { id: categories[3]._id, name: "Home & Kitchen" },
    reviews: [
      {
        userId: users[2]._id,
        username: "mike_jones",
        rating: 4,
        comment: "Powerful motor, blends smoothly.",
        reviewDate: new Date(),
      },
      {
        userId: users[1]._id,
        username: "jane_smith",
        rating: 5,
        comment: "Perfect for my morning smoothies!",
        reviewDate: new Date(),
      },
    ],
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: ObjectId(),
    name: "Air Fryer",
    description: "Digital air fryer with 6 presets",
    price: 119.99,
    stockQuantity: 35,
    category: { id: categories[3]._id, name: "Home & Kitchen" },
    reviews: [
      {
        userId: users[2]._id,
        username: "mike_jones",
        rating: 5,
        comment: "Cooks food evenly and quickly, love it!",
        reviewDate: new Date(),
      },
      {
        userId: users[3]._id,
        username: "sarah_wilson",
        rating: 4,
        comment: "Great appliance, easy to clean.",
        reviewDate: new Date(),
      },
    ],
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: ObjectId(),
    name: "Knife Set",
    description: "Professional 15-piece knife set",
    price: 149.99,
    stockQuantity: 25,
    category: { id: categories[3]._id, name: "Home & Kitchen" },
    reviews: [],
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  // Sports
  {
    _id: ObjectId(),
    name: "Yoga Mat",
    description: "Non-slip exercise yoga mat",
    price: 29.99,
    stockQuantity: 100,
    category: { id: categories[4]._id, name: "Sports" },
    reviews: [
      {
        userId: users[0]._id,
        username: "john_doe",
        rating: 4,
        comment: "Good grip, comfortable for yoga sessions.",
        reviewDate: new Date(),
      },
      {
        userId: users[4]._id,
        username: "david_brown",
        rating: 5,
        comment: "Perfect thickness and non-slip surface.",
        reviewDate: new Date(),
      },
    ],
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: ObjectId(),
    name: "Dumbbells Set",
    description: "Adjustable dumbbells 5-50 lbs",
    price: 199.99,
    stockQuantity: 30,
    category: { id: categories[4]._id, name: "Sports" },
    reviews: [
      {
        userId: users[4]._id,
        username: "david_brown",
        rating: 5,
        comment: "Excellent build quality, easy to adjust weights.",
        reviewDate: new Date(),
      },
    ],
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: ObjectId(),
    name: "Resistance Bands",
    description: "Set of 5 resistance bands",
    price: 24.99,
    stockQuantity: 150,
    category: { id: categories[4]._id, name: "Sports" },
    reviews: [],
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: ObjectId(),
    name: "Jump Rope",
    description: "Speed jump rope for cardio",
    price: 14.99,
    stockQuantity: 200,
    category: { id: categories[4]._id, name: "Sports" },
    reviews: [],
    createdAt: new Date(),
    updatedAt: new Date(),
  },
];

db.products.insertMany(products);
print(`✅ Inserted ${products.length} products`);

// ============================================
// Insert Orders (15 orders with embedded items)
// ============================================

const orders = [
  {
    userId: users[0]._id,
    userInfo: {
      username: users[0].username,
      email: users[0].email,
      fullName: users[0].fullName,
    },
    items: [
      {
        productId: products[0]._id,
        productName: "Wireless Headphones",
        quantity: 1,
        priceAtPurchase: 129.99,
        category: "Electronics",
      },
      {
        productId: products[2]._id,
        productName: "Laptop Stand",
        quantity: 1,
        priceAtPurchase: 49.99,
        category: "Electronics",
      },
    ],
    totalAmount: 179.98,
    status: "delivered",
    shippingAddress: "123 Main St, New York, NY 10001",
    orderDate: new Date("2026-01-15"),
  },
  {
    userId: users[0]._id,
    userInfo: {
      username: users[0].username,
      email: users[0].email,
      fullName: users[0].fullName,
    },
    items: [
      {
        productId: products[1]._id,
        productName: "Smart Watch",
        quantity: 1,
        priceAtPurchase: 249.99,
        category: "Electronics",
      },
    ],
    totalAmount: 249.99,
    status: "delivered",
    shippingAddress: "123 Main St, New York, NY 10001",
    orderDate: new Date("2026-01-20"),
  },
  {
    userId: users[1]._id,
    userInfo: {
      username: users[1].username,
      email: users[1].email,
      fullName: users[1].fullName,
    },
    items: [
      {
        productId: products[8]._id,
        productName: "Cotton T-Shirt",
        quantity: 2,
        priceAtPurchase: 19.99,
        category: "Clothing",
      },
      {
        productId: products[10]._id,
        productName: "Running Shoes",
        quantity: 1,
        priceAtPurchase: 89.99,
        category: "Clothing",
      },
    ],
    totalAmount: 129.97,
    status: "shipped",
    shippingAddress: "456 Oak Ave, Los Angeles, CA 90001",
    orderDate: new Date("2026-02-01"),
  },
  {
    userId: users[2]._id,
    userInfo: {
      username: users[2].username,
      email: users[2].email,
      fullName: users[2].fullName,
    },
    items: [
      {
        productId: products[12]._id,
        productName: "Coffee Maker",
        quantity: 1,
        priceAtPurchase: 79.99,
        category: "Home & Kitchen",
      },
      {
        productId: products[13]._id,
        productName: "Blender",
        quantity: 1,
        priceAtPurchase: 99.99,
        category: "Home & Kitchen",
      },
      {
        productId: products[14]._id,
        productName: "Air Fryer",
        quantity: 1,
        priceAtPurchase: 119.99,
        category: "Home & Kitchen",
      },
    ],
    totalAmount: 299.97,
    status: "delivered",
    shippingAddress: "789 Pine Rd, Chicago, IL 60601",
    orderDate: new Date("2026-01-25"),
  },
  {
    userId: users[3]._id,
    userInfo: {
      username: users[3].username,
      email: users[3].email,
      fullName: users[3].fullName,
    },
    items: [
      {
        productId: products[4]._id,
        productName: "Database Design",
        quantity: 1,
        priceAtPurchase: 59.99,
        category: "Books",
      },
      {
        productId: products[5]._id,
        productName: "Python Programming",
        quantity: 1,
        priceAtPurchase: 44.99,
        category: "Books",
      },
    ],
    totalAmount: 104.98,
    status: "delivered",
    shippingAddress: "321 Elm St, Houston, TX 77001",
    orderDate: new Date("2026-02-05"),
  },
  {
    userId: users[4]._id,
    userInfo: {
      username: users[4].username,
      email: users[4].email,
      fullName: users[4].fullName,
    },
    items: [
      {
        productId: products[17]._id,
        productName: "Dumbbells Set",
        quantity: 1,
        priceAtPurchase: 199.99,
        category: "Sports",
      },
      {
        productId: products[16]._id,
        productName: "Yoga Mat",
        quantity: 1,
        priceAtPurchase: 29.99,
        category: "Sports",
      },
    ],
    totalAmount: 229.98,
    status: "processing",
    shippingAddress: "654 Maple Dr, Phoenix, AZ 85001",
    orderDate: new Date("2026-02-10"),
  },
  {
    userId: users[5]._id,
    userInfo: {
      username: users[5].username,
      email: users[5].email,
      fullName: users[5].fullName,
    },
    items: [
      {
        productId: products[10]._id,
        productName: "Running Shoes",
        quantity: 1,
        priceAtPurchase: 89.99,
        category: "Clothing",
      },
    ],
    totalAmount: 89.99,
    status: "delivered",
    shippingAddress: "987 Cedar Ln, Philadelphia, PA 19101",
    orderDate: new Date("2026-01-18"),
  },
  {
    userId: users[6]._id,
    userInfo: {
      username: users[6].username,
      email: users[6].email,
      fullName: users[6].fullName,
    },
    items: [
      {
        productId: products[11]._id,
        productName: "Winter Jacket",
        quantity: 1,
        priceAtPurchase: 149.99,
        category: "Clothing",
      },
      {
        productId: products[9]._id,
        productName: "Denim Jeans",
        quantity: 1,
        priceAtPurchase: 69.99,
        category: "Clothing",
      },
    ],
    totalAmount: 219.98,
    status: "delivered",
    shippingAddress: "147 Birch Way, San Antonio, TX 78201",
    orderDate: new Date("2026-01-22"),
  },
  {
    userId: users[7]._id,
    userInfo: {
      username: users[7].username,
      email: users[7].email,
      fullName: users[7].fullName,
    },
    items: [
      {
        productId: products[0]._id,
        productName: "Wireless Headphones",
        quantity: 1,
        priceAtPurchase: 129.99,
        category: "Electronics",
      },
      {
        productId: products[3]._id,
        productName: "USB-C Hub",
        quantity: 1,
        priceAtPurchase: 39.99,
        category: "Electronics",
      },
    ],
    totalAmount: 169.98,
    status: "shipped",
    shippingAddress: "258 Spruce Ct, San Diego, CA 92101",
    orderDate: new Date("2026-02-08"),
  },
  {
    userId: users[8]._id,
    userInfo: {
      username: users[8].username,
      email: users[8].email,
      fullName: users[8].fullName,
    },
    items: [
      {
        productId: products[6]._id,
        productName: "Web Development",
        quantity: 1,
        priceAtPurchase: 54.99,
        category: "Books",
      },
      {
        productId: products[7]._id,
        productName: "Data Structures",
        quantity: 1,
        priceAtPurchase: 49.99,
        category: "Books",
      },
    ],
    totalAmount: 104.98,
    status: "delivered",
    shippingAddress: "369 Willow St, Dallas, TX 75201",
    orderDate: new Date("2026-01-28"),
  },
  {
    userId: users[1]._id,
    userInfo: {
      username: users[1].username,
      email: users[1].email,
      fullName: users[1].fullName,
    },
    items: [
      {
        productId: products[13]._id,
        productName: "Blender",
        quantity: 1,
        priceAtPurchase: 99.99,
        category: "Home & Kitchen",
      },
    ],
    totalAmount: 99.99,
    status: "delivered",
    shippingAddress: "456 Oak Ave, Los Angeles, CA 90001",
    orderDate: new Date("2026-02-12"),
  },
  {
    userId: users[2]._id,
    userInfo: {
      username: users[2].username,
      email: users[2].email,
      fullName: users[2].fullName,
    },
    items: [
      {
        productId: products[14]._id,
        productName: "Air Fryer",
        quantity: 1,
        priceAtPurchase: 119.99,
        category: "Home & Kitchen",
      },
    ],
    totalAmount: 119.99,
    status: "processing",
    shippingAddress: "789 Pine Rd, Chicago, IL 60601",
    orderDate: new Date("2026-02-15"),
  },
  {
    userId: users[0]._id,
    userInfo: {
      username: users[0].username,
      email: users[0].email,
      fullName: users[0].fullName,
    },
    items: [
      {
        productId: products[16]._id,
        productName: "Yoga Mat",
        quantity: 1,
        priceAtPurchase: 29.99,
        category: "Sports",
      },
      {
        productId: products[18]._id,
        productName: "Resistance Bands",
        quantity: 1,
        priceAtPurchase: 24.99,
        category: "Sports",
      },
    ],
    totalAmount: 54.98,
    status: "delivered",
    shippingAddress: "123 Main St, New York, NY 10001",
    orderDate: new Date("2026-02-03"),
  },
  {
    userId: users[3]._id,
    userInfo: {
      username: users[3].username,
      email: users[3].email,
      fullName: users[3].fullName,
    },
    items: [
      {
        productId: products[0]._id,
        productName: "Wireless Headphones",
        quantity: 1,
        priceAtPurchase: 129.99,
        category: "Electronics",
      },
      {
        productId: products[1]._id,
        productName: "Smart Watch",
        quantity: 1,
        priceAtPurchase: 249.99,
        category: "Electronics",
      },
    ],
    totalAmount: 379.98,
    status: "delivered",
    shippingAddress: "321 Elm St, Houston, TX 77001",
    orderDate: new Date("2026-02-07"),
  },
  {
    userId: users[4]._id,
    userInfo: {
      username: users[4].username,
      email: users[4].email,
      fullName: users[4].fullName,
    },
    items: [
      {
        productId: products[5]._id,
        productName: "Python Programming",
        quantity: 1,
        priceAtPurchase: 44.99,
        category: "Books",
      },
    ],
    totalAmount: 44.99,
    status: "shipped",
    shippingAddress: "654 Maple Dr, Phoenix, AZ 85001",
    orderDate: new Date("2026-02-18"),
  },
];

db.orders.insertMany(orders);
print(`✅ Inserted ${orders.length} orders`);

print("🎉 Data seeding completed successfully!");
print("---");
print("Summary:");
print(`  - ${db.categories.countDocuments()} categories`);
print(`  - ${db.users.countDocuments()} users`);
print(`  - ${db.products.countDocuments()} products`);
print(`  - ${db.orders.countDocuments()} orders`);
