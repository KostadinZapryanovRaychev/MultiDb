// ============================================
// MongoDB E-Commerce Database - Query Examples
// ============================================

db = db.getSiblingDB("ecommerce");

print("\n📊 Running MongoDB Query Examples\n");
print("==========================================\n");

// ============================================
// QUERY 1: All products purchased by a specific user
// ============================================
print('QUERY 1: All products purchased by user "john_doe"');
print("---");

const user1 = db.users.findOne({ username: "john_doe" });

db.orders
  .aggregate([
    { $match: { userId: user1._id } },
    { $unwind: "$items" },
    {
      $project: {
        _id: 0,
        username: "$userInfo.username",
        fullName: "$userInfo.fullName",
        productName: "$items.productName",
        category: "$items.category",
        quantity: "$items.quantity",
        priceAtPurchase: "$items.priceAtPurchase",
        orderDate: 1,
        status: 1,
      },
    },
    { $sort: { orderDate: -1 } },
  ])
  .forEach(printjson);

print("\n==========================================\n");

// ============================================
// QUERY 2: Top 5 most ordered products
// ============================================
print("QUERY 2: Top 5 Most Ordered Products");
print("---");

db.orders
  .aggregate([
    { $unwind: "$items" },
    {
      $group: {
        _id: "$items.productId",
        productName: { $first: "$items.productName" },
        category: { $first: "$items.category" },
        totalQuantitySold: { $sum: "$items.quantity" },
        numberOfOrders: { $sum: 1 },
        totalRevenue: {
          $sum: { $multiply: ["$items.quantity", "$items.priceAtPurchase"] },
        },
      },
    },
    { $sort: { totalQuantitySold: -1 } },
    { $limit: 5 },
    {
      $project: {
        _id: 0,
        productName: 1,
        category: 1,
        totalQuantitySold: 1,
        numberOfOrders: 1,
        totalRevenue: { $round: ["$totalRevenue", 2] },
      },
    },
  ])
  .forEach(printjson);

print("\n==========================================\n");

// ============================================
// QUERY 3: Average rating per product
// ============================================
print("QUERY 3: Average Rating Per Product (with reviews)");
print("---");

db.products
  .aggregate([
    { $match: { "reviews.0": { $exists: true } } }, // Only products with reviews
    { $unwind: "$reviews" },
    {
      $group: {
        _id: "$_id",
        productName: { $first: "$name" },
        category: { $first: "$category.name" },
        price: { $first: "$price" },
        reviewCount: { $sum: 1 },
        averageRating: { $avg: "$reviews.rating" },
        minRating: { $min: "$reviews.rating" },
        maxRating: { $max: "$reviews.rating" },
      },
    },
    { $sort: { averageRating: -1, reviewCount: -1 } },
    {
      $project: {
        _id: 0,
        productName: 1,
        category: 1,
        price: 1,
        reviewCount: 1,
        averageRating: { $round: ["$averageRating", 2] },
        minRating: 1,
        maxRating: 1,
      },
    },
  ])
  .forEach(printjson);

print("\n==========================================\n");

// ============================================
// QUERY 4: All users who purchased a specific product
// ============================================
print('QUERY 4: All users who purchased "Wireless Headphones"');
print("---");

const targetProduct = db.products.findOne({ name: "Wireless Headphones" });

db.orders
  .aggregate([
    { $match: { "items.productId": targetProduct._id } },
    { $unwind: "$items" },
    { $match: { "items.productId": targetProduct._id } },
    {
      $group: {
        _id: "$userId",
        username: { $first: "$userInfo.username" },
        fullName: { $first: "$userInfo.fullName" },
        email: { $first: "$userInfo.email" },
        orders: {
          $push: {
            orderId: "$_id",
            quantity: "$items.quantity",
            priceAtPurchase: "$items.priceAtPurchase",
            orderDate: "$orderDate",
            status: "$status",
          },
        },
      },
    },
    { $sort: { "orders.orderDate": -1 } },
    {
      $project: {
        _id: 0,
        productName: targetProduct.name,
        username: 1,
        fullName: 1,
        email: 1,
        orders: 1,
      },
    },
  ])
  .forEach(printjson);

print("\n==========================================\n");

// ============================================
// QUERY 5: Product Recommendation (Collaborative Filtering)
// ============================================
print(
  'QUERY 5: Product Recommendations (Users who bought "Wireless Headphones" also bought...)'
);
print("---");

const productForReco = db.products.findOne({ name: "Wireless Headphones" });

db.orders
  .aggregate([
    // Find orders containing the target product
    { $match: { "items.productId": productForReco._id } },
    // Get all user IDs who bought this product
    { $group: { _id: null, userIds: { $addToSet: "$userId" } } },
    // Find all orders from these users
    {
      $lookup: {
        from: "orders",
        localField: "userIds",
        foreignField: "userId",
        as: "otherOrders",
      },
    },
    { $unwind: "$otherOrders" },
    { $unwind: "$otherOrders.items" },
    // Exclude the original product
    { $match: { "otherOrders.items.productId": { $ne: productForReco._id } } },
    // Group by product to count purchases
    {
      $group: {
        _id: "$otherOrders.items.productId",
        productName: { $first: "$otherOrders.items.productName" },
        category: { $first: "$otherOrders.items.category" },
        boughtByCount: { $sum: 1 },
        avgPrice: { $avg: "$otherOrders.items.priceAtPurchase" },
      },
    },
    { $sort: { boughtByCount: -1 } },
    { $limit: 5 },
    {
      $lookup: {
        from: "products",
        localField: "_id",
        foreignField: "_id",
        as: "productDetails",
      },
    },
    { $unwind: "$productDetails" },
    {
      $project: {
        _id: 0,
        productName: 1,
        category: 1,
        currentPrice: "$productDetails.price",
        boughtByCount: 1,
        averageRating: {
          $cond: {
            if: { $gt: [{ $size: "$productDetails.reviews" }, 0] },
            then: {
              $round: [{ $avg: "$productDetails.reviews.rating" }, 2],
            },
            else: null,
          },
        },
        reviewCount: { $size: "$productDetails.reviews" },
      },
    },
  ])
  .forEach(printjson);

print("\n==========================================\n");

// ============================================
// BONUS QUERIES
// ============================================

// BONUS 1: User purchase statistics
print("BONUS QUERY 1: User Purchase Statistics");
print("---");

db.orders
  .aggregate([
    {
      $group: {
        _id: "$userId",
        username: { $first: "$userInfo.username" },
        fullName: { $first: "$userInfo.fullName" },
        totalOrders: { $sum: 1 },
        totalSpent: { $sum: "$totalAmount" },
        avgOrderValue: { $avg: "$totalAmount" },
        lastOrderDate: { $max: "$orderDate" },
      },
    },
    { $sort: { totalSpent: -1 } },
    {
      $project: {
        _id: 0,
        username: 1,
        fullName: 1,
        totalOrders: 1,
        totalSpent: { $round: ["$totalSpent", 2] },
        avgOrderValue: { $round: ["$avgOrderValue", 2] },
        lastOrderDate: 1,
      },
    },
  ])
  .forEach(printjson);

print("\n==========================================\n");

// BONUS 2: Products with no reviews
print("BONUS QUERY 2: Products With No Reviews");
print("---");

db.products
  .aggregate([
    {
      $match: {
        $or: [{ reviews: { $exists: false } }, { reviews: { $size: 0 } }],
      },
    },
    {
      $lookup: {
        from: "orders",
        let: { productId: "$_id" },
        pipeline: [
          { $unwind: "$items" },
          { $match: { $expr: { $eq: ["$items.productId", "$$productId"] } } },
          { $count: "orderCount" },
        ],
        as: "orderStats",
      },
    },
    {
      $project: {
        _id: 0,
        productName: "$name",
        category: "$category.name",
        price: 1,
        stockQuantity: 1,
        timesSold: {
          $ifNull: [{ $arrayElemAt: ["$orderStats.orderCount", 0] }, 0],
        },
      },
    },
    { $sort: { timesSold: -1 } },
  ])
  .forEach(printjson);

print("\n==========================================\n");

// BONUS 3: Category performance analysis
print("BONUS QUERY 3: Category Performance Analysis");
print("---");

db.orders
  .aggregate([
    { $unwind: "$items" },
    {
      $group: {
        _id: "$items.category",
        orderCount: { $sum: 1 },
        totalUnitsSold: { $sum: "$items.quantity" },
        totalRevenue: {
          $sum: { $multiply: ["$items.quantity", "$items.priceAtPurchase"] },
        },
      },
    },
    {
      $lookup: {
        from: "products",
        let: { categoryName: "$_id" },
        pipeline: [
          { $match: { $expr: { $eq: ["$category.name", "$$categoryName"] } } },
          { $unwind: { path: "$reviews", preserveNullAndEmptyArrays: true } },
          {
            $group: {
              _id: null,
              productCount: { $addToSet: "$_id" },
              avgRating: { $avg: "$reviews.rating" },
            },
          },
        ],
        as: "categoryStats",
      },
    },
    {
      $project: {
        _id: 0,
        category: "$_id",
        productCount: {
          $size: { $arrayElemAt: ["$categoryStats.productCount", 0] },
        },
        orderCount: 1,
        totalUnitsSold: 1,
        totalRevenue: { $round: ["$totalRevenue", 2] },
        avgCategoryRating: {
          $round: [
            { $ifNull: [{ $arrayElemAt: ["$categoryStats.avgRating", 0] }, 0] },
            2,
          ],
        },
      },
    },
    { $sort: { totalRevenue: -1 } },
  ])
  .forEach(printjson);

print("\n==========================================\n");

// BONUS 4: Recent high-value orders
print("BONUS QUERY 4: Recent High-Value Orders (>$150)");
print("---");

db.orders
  .aggregate([
    { $match: { totalAmount: { $gt: 150 } } },
    { $sort: { orderDate: -1 } },
    { $limit: 10 },
    {
      $project: {
        _id: 0,
        orderDate: 1,
        customerName: "$userInfo.fullName",
        username: "$userInfo.username",
        totalAmount: 1,
        status: 1,
        itemCount: { $size: "$items" },
        items: {
          $map: {
            input: "$items",
            as: "item",
            in: {
              product: "$$item.productName",
              qty: "$$item.quantity",
              price: "$$item.priceAtPurchase",
            },
          },
        },
      },
    },
  ])
  .forEach(printjson);

print("\n==========================================\n");
print("✅ All queries executed successfully!\n");
