# foodtrack-db
Esquema relacional y scripts SQL para gestionar operaciones de foodtrucks.

## Objetivo:
El propósito del proyecto es simular un entorno de desarrollo

## Herramientas:
- Microsoft SQL Server (motor de base de datos).
- DBeaver (cliente).
- GitHub.

## Contenido:
- Scripts de creación del esquema relacional inicial.
- Modelos de entidades (ERD).
- Versionado de cambios en la base de datos.

## Entidades y Assets:
- Foodtrucks  
- Productos  
- Pedidos  
- Ubicaciones  
- Detalle de ítems pedidos

_____

## Modelo Relacional de FoodTrack:

| Tabla       | PK            | FK                                                             | Campos importantes        |
| ----------- | ------------- | -------------------------------------------------------------- | ------------------------- |
| foodtrucks  | foodtruck_id  | —                                                              | name, cuisine_type, city  |
| products    | product_id    | foodtruck_id → foodtrucks(foodtruck_id)                        | name, price, stock        |
| orders      | order_id      | foodtruck_id → foodtrucks(foodtruck_id)                        | order_date, status, total |
| order_items | order_item_id | order_id → orders(order_id), product_id → products(product_id) | quantity                  |
| locations   | location_id   | foodtruck_id → foodtrucks(foodtruck_id)                        | location_date, zone       |

### Notas importantes:
-status en orders puede ser un VARCHAR(20) o un ENUM si SQL Server soporta check constraints (entregado, pendiente, etc.).
-price y total como DECIMAL(10,2).
-stock y quantity como INT.
-Relaciones uno a muchos:
-Un foodtruck puede tener muchos products, orders y locations.
-Un order puede tener muchos order_items.

_____
