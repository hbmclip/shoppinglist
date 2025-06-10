# createdatabase

```
BEGIN

    // 1. Define the database name
    SET database_name ← "shopping_list_db"

    // 2. Connect to the Database Management System (DBMS)
    CONNECT TO DBMS

    // 3. Create the database if it does not exist
    IF database_exists(database_name) = FALSE THEN
        CREATE DATABASE database_name
    END IF

    // 4. Select the database for use
    USE DATABASE database_name

    // 5. Define and create the 'shopping_lists' table
    CREATE TABLE shopping_lists (
        id INTEGER PRIMARY KEY AUTO_INCREMENT,
        name TEXT NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    )

    // 6. Define and create the 'items' table
    CREATE TABLE items (
        id INTEGER PRIMARY KEY AUTO_INCREMENT,
        shopping_list_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        quantity INTEGER DEFAULT 1,
        purchased BOOLEAN DEFAULT FALSE,
        FOREIGN KEY (shopping_list_id) REFERENCES shopping_lists(id)
    )

    // 7. Verify if tables were created successfully
    IF tables_exist("shopping_lists", "items") = TRUE THEN
        DISPLAY "Database created successfully!"
    ELSE
        DISPLAY "Error creating database."
    END IF

    // 8. Disconnect from the DBMS
    DISCONNECT FROM DBMS

END
``