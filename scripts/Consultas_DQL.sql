-- =========================================================
-- SCRIPT DQL PARA CONSULTAS DE ANÁLISIS EN FOODTRACKDB
-- =========================================================

USE FoodTrackDB;
GO

-- Consulta 1: Obtener el nombre de todos los foodtrucks y su ciudad.
SELECT 
    name AS NombreFoodTruck, 
    cuisine_type AS TipoComida,
    city AS Ciudad
FROM 
    foodtrucks;
GO

-- Consulta 2: Mostrar el nombre de los productos vendidos por el foodtruck 'Taco Loco'.
SELECT 
    p.name AS NombreProducto,
    p.price AS Precio
FROM 
    products p
JOIN 
    foodtrucks f ON p.foodtruck_id = f.foodtruck_id
WHERE 
    f.name = 'Taco Loco';
GO

-- Consulta 3: Calcular el total facturado por cada foodtruck.
-- Esta consulta usa la información de la tabla orders.
SELECT 
    f.name AS NombreFoodTruck,
    SUM(o.total) AS TotalFacturado
FROM 
    orders o
JOIN 
    foodtrucks f ON o.foodtruck_id = f.foodtruck_id
GROUP BY 
    f.name
ORDER BY 
    TotalFacturado DESC;
GO

-- Consulta 4: Listar todos los pedidos, indicando el nombre del foodtruck, la fecha y el estado.
SELECT 
    o.order_id AS ID_Pedido,
    f.name AS NombreFoodTruck,
    o.order_date AS FechaHora,
    o.status AS Estado
FROM 
    orders o
JOIN 
    foodtrucks f ON o.foodtruck_id = f.foodtruck_id
ORDER BY 
    o.order_date;
GO

-- Consulta 5: Detalle de qué productos y cuántos se pidieron en cada orden.
SELECT
    oi.order_id AS ID_Pedido,
    p.name AS NombreProducto,
    oi.quantity AS Cantidad
FROM
    order_items oi
JOIN
    products p ON oi.product_id = p.product_id
ORDER BY
    oi.order_id;
GO