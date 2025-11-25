-- =========================================================
-- SCRIPT DDL PARA EVOLUCIÓN DEL ESQUEMA
-- MODIFICACIÓN: Agregar la columna 'comments' a la tabla 'orders'
-- =========================================================

USE FoodTrackDB;
GO

-- Agrega la columna 'comments' para notas adicionales en los pedidos.
-- Usamos NVARCHAR(500) para permitir textos largos y caracteres especiales.
ALTER TABLE orders
ADD comments NVARCHAR(500) NULL;
GO

-- Muestra la estructura actualizada de la tabla 'orders' (solo para verificación)
SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    IS_NULLABLE 
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'orders' 
    AND COLUMN_NAME = 'comments';
GO