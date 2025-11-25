-- =========================================================
-- SCRIPT DML PARA CARGA DE DATOS INICIALES EN FOODTRACKDB
-- Notas:
-- 1. Los comandos INSERT se ejecutan en orden de dependencia (Tablas maestras primero).
-- 2. SE HA SEPARADO CADA INSERCIÓN EN UNA SENTENCIA INDIVIDUAL 
--    PARA EVITAR EL ERROR DE SINTAXIS [102] EN SQL SERVER AL USAR IDENTITY_INSERT.
-- =========================================================

USE FoodTrackDB;
GO

------------------------------------------------------
-- 1. CARGA DE DATOS: foodtrucks (Tabla Maestra)
-- foodtruck_id,name,cuisine_type,city
------------------------------------------------------
SET IDENTITY_INSERT foodtrucks ON;
GO
INSERT INTO foodtrucks (foodtruck_id, name, cuisine_type, city) VALUES (1, 'Taco Loco', 'Mexicana', 'Ciudad de México');
INSERT INTO foodtrucks (foodtruck_id, name, cuisine_type, city) VALUES (2, 'Burger Bros', 'Americana', 'Buenos Aires');
GO
SET IDENTITY_INSERT foodtrucks OFF;
GO

------------------------------------------------------
-- 2. CARGA DE DATOS: products (Dependiente de foodtrucks)
-- product_id,foodtruck_id,name,price,stock
------------------------------------------------------
SET IDENTITY_INSERT products ON;
GO
INSERT INTO products (product_id, foodtruck_id, name, price, stock) VALUES (101, 1, 'Taco al pastor', 50.00, 100); -- FoodTruck 1
INSERT INTO products (product_id, foodtruck_id, name, price, stock) VALUES (102, 1, 'Quesadilla', 40.00, 80);     -- FoodTruck 1
INSERT INTO products (product_id, foodtruck_id, name, price, stock) VALUES (103, 2, 'Cheeseburger', 70.00, 120);  -- FoodTruck 2
INSERT INTO products (product_id, foodtruck_id, name, price, stock) VALUES (104, 2, 'Papas fritas', 30.00, 150);   -- FoodTruck 2
GO
SET IDENTITY_INSERT products OFF;
GO

------------------------------------------------------
-- 3. CARGA DE DATOS: orders (Dependiente de foodtrucks)
-- order_id,foodtruck_id,order_date,status,total
------------------------------------------------------
SET IDENTITY_INSERT orders ON;
GO
INSERT INTO orders (order_id, foodtruck_id, order_date, status, total) VALUES (1001, 1, '2023-09-01 10:00:00', 'entregado', 90.00); -- Pedido a Taco Loco
INSERT INTO orders (order_id, foodtruck_id, order_date, status, total) VALUES (1002, 2, '2023-09-01 11:30:00', 'pendiente', 100.00); -- Pedido a Burger Bros
GO
SET IDENTITY_INSERT orders OFF;
GO

------------------------------------------------------
-- 4. CARGA DE DATOS: locations (Dependiente de foodtrucks)
-- location_id,foodtruck_id,location_date,zone
------------------------------------------------------
SET IDENTITY_INSERT locations ON;
GO
INSERT INTO locations (location_id, foodtruck_id, location_date, zone) VALUES (1, 1, '2023-09-01', 'Centro'); 
INSERT INTO locations (location_id, foodtruck_id, location_date, zone) VALUES (2, 2, '2023-09-01', 'Parque');
GO
SET IDENTITY_INSERT locations OFF;
GO

------------------------------------------------------
-- 5. CARGA DE DATOS: order_items (Dependiente de orders y products)
-- order_item_id,order_id,product_id,quantity
------------------------------------------------------
SET IDENTITY_INSERT order_items ON;
GO
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (1, 1001, 101, 1); -- Pedido 1001 lleva 1 Taco al pastor
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (2, 1002, 103, 1); -- Pedido 1002 lleva 1 Cheeseburger
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (3, 1002, 104, 1); -- Pedido 1002 lleva 1 Papas fritas
GO
SET IDENTITY_INSERT order_items OFF;
GO