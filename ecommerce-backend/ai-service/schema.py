DB_SCHEMA = """
The database is for an E-commerce Analytics Platform. 
It contains the following PostgreSQL tables and relationships.

Table: users
Columns: id (bigint), username (varchar), email (varchar), password (varchar), role (varchar: CUSTOMER, ADMIN, SELLER), gender (varchar), status (varchar: ACTIVE, BANNED), created_at (timestamp), updated_at (timestamp)

Table: customer_profiles
Columns: id (bigint), user_id (bigint, FK to users.id), age (int), city (varchar), membership_type (varchar), satisfaction_level (int)

Table: categories
Columns: id (bigint), name (varchar), parent_id (bigint, FK to categories.id)

Table: stores
Columns: id (bigint), owner_id (bigint, FK to users.id), name (varchar), status (varchar)

Table: products
Columns: id (bigint), store_id (bigint, FK to stores.id), name (varchar), sku (varchar), description (text), unit_price (numeric), stock_quantity (int), category_id (bigint, FK to categories.id), image_url (varchar), created_at (timestamp)

Table: orders
Columns: id (bigint), user_id (bigint, FK to users.id), logistic_id (bigint), shipping_address_id (bigint), store_id (bigint, FK to stores.id), status (varchar: PENDING, PROCESSING, SHIPPED, DELIVERED, CANCELLED, RETURN_REQUESTED, RETURNED), grand_total (numeric), created_at (timestamp)

Table: shipments
Columns: id (bigint), order_id (bigint, FK to orders.id), warehouse (varchar), mode (varchar), status (varchar), customer_care_calls (int), product_importance (varchar), estimated_arrival (timestamp)

Table: reviews
Columns: id (bigint), user_id (bigint, FK to users.id), product_id (bigint, FK to products.id), star_rating (int), comment (text), sentiment (varchar), created_at (timestamp)

Table: order_items
Columns: id (bigint), order_id (bigint, FK to orders.id), product_id (bigint, FK to products.id), quantity (int), unit_price (numeric)

Security Rules:
1. If user_role == 'ADMIN', no data restrictions. Do not add any ownership filter unless the user explicitly asks for a specific user/store.
2. If user_role == 'SELLER', only query data for stores owned by that seller. Prefer filtering with stores.owner_id = <user_id>.
3. If user_role == 'CUSTOMER', only query data related to that customer. Filter with orders.user_id = <user_id>, reviews.user_id = <user_id>, customer_profiles.user_id = <user_id>, etc.
4. For catalog questions such as "list products", "most expensive products", "show categories", avoid unnecessary joins.
5. Output SQL using real column names exactly as written above. Do not invent columns such as price, ownerId, or user_role.
"""
