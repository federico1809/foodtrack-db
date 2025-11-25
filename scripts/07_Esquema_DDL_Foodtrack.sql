-- =========================================================
-- SCRIPT DDL PARA CREACIÓN DE ESQUEMA FOODTRACKDB EN SQL SERVER
-- =========================================================

-- 1. Creación y uso de la base de datos
-- DROP DATABASE IF EXISTS FoodTrackDB;
CREATE DATABASE FoodTrackDB;
GO
USE FoodTrackDB;
GO

-- 2. Creación de la tabla FOODTRUCKS
-- Contiene la información principal de los camiones.
CREATE TABLE foodtrucks (
    foodtruck_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL UNIQUE, 
    cuisine_type NVARCHAR(50),
    city NVARCHAR(50)
    -- Podríamos agregar campos como 'rating' o 'fecha_alta' aquí
);
GO

-- 3. Creación de la tabla PRODUCTS
-- El menú de productos que ofrece cada foodtruck.
CREATE TABLE products (
    product_id INT PRIMARY KEY IDENTITY(1,1),
    foodtruck_id INT NOT NULL,
    name NVARCHAR(100) NOT NULL,
    price MONEY NOT NULL CHECK (price >= 0), -- MONEY para valores monetarios
    stock INT NOT NULL CHECK (stock >= 0), -- Aseguramos que el stock no sea negativo
    
    -- Clave Foránea a FoodTrucks
    CONSTRAINT FK_Products_FoodTruck FOREIGN KEY (foodtruck_id)
        REFERENCES foodtrucks (foodtruck_id)
);
GO

-- 4. Creación de la tabla LOCATIONS
-- Un registro histórico de dónde se ubicó cada foodtruck en un momento dado.
CREATE TABLE locations (
    location_id INT PRIMARY KEY IDENTITY(1,1),
    foodtruck_id INT NOT NULL,
    location_date DATETIME NOT NULL, -- CAMBIO REALIZADO AQUÍ: Usando DATETIME para mayor compatibilidad
    zone NVARCHAR(100),
    
    -- Clave Foránea a FoodTrucks
    CONSTRAINT FK_Locations_FoodTruck FOREIGN KEY (foodtruck_id)
        REFERENCES foodtrucks (foodtruck_id)
);
GO

-- 5. Creación de la tabla ORDERS
-- Información general sobre los pedidos.
CREATE TABLE orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    foodtruck_id INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT GETDATE(),
    status NVARCHAR(50) NOT NULL, -- Ej: Pendiente, Entregado, Cancelado
    total MONEY NOT NULL CHECK (total >= 0),
    
    -- Clave Foránea a FoodTrucks
    CONSTRAINT FK_Orders_FoodTruck FOREIGN KEY (foodtruck_id)
        REFERENCES foodtrucks (foodtruck_id)
);
GO

-- 6. Creación de la tabla ORDER_ITEMS
-- Tabla de ruptura que detalla los productos incluidos en cada pedido.
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY IDENTITY(1,1), -- PK simple (como sugiere el CSV)
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    
    -- Claves Foráneas
    CONSTRAINT FK_OrderItems_Order FOREIGN KEY (order_id)
        REFERENCES orders (order_id),
        
    CONSTRAINT FK_OrderItems_Product FOREIGN KEY (product_id)
        REFERENCES products (product_id)
);
GO

-- 7. Índice para optimizar búsquedas en la tabla de items de pedido
CREATE INDEX IX_OrderItems_OrderProduct 
ON order_items (order_id, product_id);
GO