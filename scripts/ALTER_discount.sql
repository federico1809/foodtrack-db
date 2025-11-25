-- =========================================================
-- SCRIPT DDL PARA EVOLUCIÓN DEL ESQUEMA
-- MODIFICACIÓN: Agregar la columna 'discount_percentage' a la tabla 'orders'
-- =========================================================

USE FoodTrackDB;
GO

-- Agrega la columna 'discount_percentage' para registrar un descuento aplicable al pedido.
-- Usamos DECIMAL(5, 2) para valores como 15.00 (15%)
ALTER TABLE orders
ADD discount_percentage DECIMAL(5, 2) NULL DEFAULT 0.00;
GO

-- Muestra la estructura actualizada de la tabla 'orders' (solo para verificación)
SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    IS_NULLABLE,
    COLUMN_DEFAULT
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'orders' 
    AND COLUMN_NAME IN ('comments', 'discount_percentage');
GO