-- Creación de tablas FoodTrackDB
CREATE TABLE foodtrucks (
    foodtruck_id INT PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    cuisine_type NVARCHAR(50),
    city NVARCHAR(100)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    foodtruck_id INT NOT NULL,
    name NVARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    FOREIGN KEY (foodtruck_id) REFERENCES foodtrucks(foodtruck_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    foodtruck_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    status NVARCHAR(50),
    total DECIMAL(10,2),
    FOREIGN KEY (foodtruck_id) REFERENCES foodtrucks(foodtruck_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE locations (
    location_id INT PRIMARY KEY,
    foodtruck_id INT NOT NULL,
    location_date DATETIME NOT NULL,
    zone NVARCHAR(100),
    FOREIGN KEY (foodtruck_id) REFERENCES foodtrucks(foodtruck_id)
);
