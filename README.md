# shoppinglist 
# 🛒 Shopping List System

A simple system to manage grocery shopping lists using SQLite.

## 📦 Features

- Create and manage multiple shopping lists
- Add, update, and delete items in each list
- Mark items as purchased
- View all lists with their items
- Lightweight and easy to use

---

## 🧩 System Requirements

### Functional Requirements

- Users can create a new shopping list
- Users can add items to a shopping list
- Users can remove items from a shopping list
- Users can mark items as purchased
- Users can view all shopping lists and their items
- Users can delete a shopping list

### Non-Functional Requirements

- Uses SQLite for data storage
- Supports basic CRUD operations
- Simple and lightweight
- Compatible with desktop or mobile (via CLI or minimal GUI)

---

## 🗃️ Database Design (SQLite)

### Tables

#### `shopping_lists`

| Column Name | Type     | Description                  |
|-------------|----------|------------------------------|
| id          | INTEGER  | Primary key, auto-increment  |
| name        | TEXT     | Name of the shopping list    |
| created_at  | DATETIME | Creation timestamp           |

#### `items`

| Column Name      | Type     | Description                             |
|------------------|----------|-----------------------------------------|
| id               | INTEGER  | Primary key, auto-increment             |
| shopping_list_id | INTEGER  | Foreign key to `shopping_lists(id)`     |
| name             | TEXT     | Name of the item                        |
| quantity         | INTEGER  | Quantity of the item                    |
| purchased        | BOOLEAN  | 0 = Not purchased, 1 = Purchased        |

### SQL Schema

```sql
-- Table: shopping_lists
CREATE TABLE shopping_lists (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Table: items
CREATE TABLE items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    shopping_list_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    quantity INTEGER DEFAULT 1,
    purchased BOOLEAN DEFAULT 0,
    FOREIGN KEY (shopping_list_id) REFERENCES shopping_lists(id) ON DELETE CASCADE
);
```

---

## 📖 System Documentation

### Entities

#### ShoppingList

- **Attributes**: `id`, `name`, `created_at`
- **Purpose**: Represents a named collection of shopping items

#### Item

- **Attributes**: `id`, `shopping_list_id`, `name`, `quantity`, `purchased`
- **Purpose**: Represents an individual item in a shopping list

### Use Cases

1. **Create Shopping List**
   - User provides a name
   - System stores it with a timestamp

2. **Add Item**
   - User selects a shopping list and provides item name and quantity
   - System adds item as not purchased

3. **Mark Item as Purchased**
   - User toggles item status

4. **Delete Item**
   - User removes item from the list

5. **Delete Shopping List**
   - All associated items are also deleted

6. **View Lists**
   - Lists and their items are displayed to the user

---
