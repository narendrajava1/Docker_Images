Great! Here's a full working `docker-compose.yml` that:

- Spins up **MongoDB** with authentication  
- Automatically creates:
  - A **root admin**
  - An **app-specific user** for a custom database
  - A **custom database**
- Optionally preloads a collection using an **init script**

---

### ✅ `docker-compose.yml`

```yaml
version: '3.8'

services:
  mongodb:
    image: mongo:6.0
    container_name: mongodb
    ports:
      - "27017:27017"
    environment:
      MONGO_INITDB_ROOT_USERNAME: root
      MONGO_INITDB_ROOT_PASSWORD: rootpassword
      MONGO_INITDB_DATABASE: myappdb
    volumes:
      - mongo-data:/data/db
      - ./init-mongo.js:/docker-entrypoint-initdb.d/init-mongo.js:ro
    restart: unless-stopped

volumes:
  mongo-data:
```

---

### 📄 `init-mongo.js` (Place in same folder)

```javascript
db = db.getSiblingDB("myappdb");

db.createUser({
  user: "myappuser",
  pwd: "myapppassword",
  roles: [{ role: "readWrite", db: "myappdb" }]
});

db.sampleData.insertMany([
  { name: "Alice", role: "admin" },
  { name: "Bob", role: "user" }
]);
```

This script:
- Creates a user `myappuser` with `readWrite` access to `myappdb`
- Adds a `sampleData` collection with 2 documents

---

### 🔐 Connection Strings

- **Admin (root)**:
  ```bash
  mongodb://root:rootpassword@localhost:27017/admin
  ```

- **App user**:
  ```bash
  mongodb://myappuser:myapppassword@localhost:27017/myappdb
  ```

---

### 🧪 Test It

1. Start the stack:
   ```bash
   docker-compose up -d
   ```

2. Connect using:
   ```bash
   mongosh mongodb://myappuser:myapppassword@localhost:27017/myappdb
   ```

3. Check inserted data:
   ```bash
   db.sampleData.find()
   ```

---

Would you like me to generate a matching MongoDB Compass or Mongoose (Node.js) config for this?


Great! Here's a full **mini e-commerce schema** in MongoDB for learning purposes, with:

1. `users` collection  
2. `orders` collection (referencing `users`)  
3. Embedded **order history** (alternative model)

---

## 🧍 1. `users` Collection

```json
[
  {
    "_id": ObjectId("644e1c1b8f1c000012345678"),
    "name": "Alice Smith",
    "email": "alice@example.com",
    "registered_at": ISODate("2023-11-10T10:00:00Z"),
    "address": {
      "city": "New York",
      "country": "USA"
    },
    "is_active": true
  },
  {
    "_id": ObjectId("644e1c1b8f1c000087654321"),
    "name": "Bob Johnson",
    "email": "bob@example.com",
    "registered_at": ISODate("2024-01-05T12:30:00Z"),
    "address": {
      "city": "London",
      "country": "UK"
    },
    "is_active": false
  }
]
```

---

## 📦 2. `orders` Collection

Each order references a `user_id` and contains an array of products.

```json
[
  {
    "_id": ObjectId("665e1c1b8f1c000011112222"),
    "user_id": ObjectId("644e1c1b8f1c000012345678"),
    "order_date": ISODate("2024-04-20T14:10:00Z"),
    "status": "shipped",
    "total": 180.49,
    "items": [
      {
        "product_id": 1,
        "name": "Wireless Mouse",
        "qty": 2,
        "price": 25.99
      },
      {
        "product_id": 4,
        "name": "Water Bottle",
        "qty": 3,
        "price": 9.99
      }
    ]
  }
]
```

---

## 📘 3. Alternative: Embed Order History in `users`

Some apps embed the orders inside user documents if order volume is low or querying is simple.

```json
{
  "_id": ObjectId("644e1c1b8f1c000012345678"),
  "name": "Alice Smith",
  "email": "alice@example.com",
  "orders": [
    {
      "order_id": ObjectId("665e1c1b8f1c000011112222"),
      "order_date": ISODate("2024-04-20T14:10:00Z"),
      "total": 180.49,
      "items": [
        {
          "product_id": 1,
          "name": "Wireless Mouse",
          "qty": 2,
          "price": 25.99
        }
      ]
    }
  ]
}
```

---

## 🔍 Practice Queries

```js
// Find all active users from USA
db.users.find({ is_active: true, "address.country": "USA" });

// Get all orders for user Alice
db.orders.find({ user_id: ObjectId("644e1c1b8f1c000012345678") });

// Find orders with any item costing more than $50
db.orders.find({ "items.price": { $gt: 50 } });

// Sum total of all orders
db.orders.aggregate([
  { $group: { _id: null, totalRevenue: { $sum: "$total" } } }
]);

// Find users who ordered 'Wireless Mouse'
db.orders.find({ "items.name": "Wireless Mouse" });
```

---

Would you like this bundled into a `.js` init script to auto-load into MongoDB on startup?