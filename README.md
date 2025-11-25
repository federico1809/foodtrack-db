# FoodTrack-DB

Esquema relacional y scripts SQL para gestionar operaciones de foodtrucks.

---

## Objetivo

El propósito del proyecto es simular un **entorno profesional de desarrollo** de base de datos, aplicando buenas prácticas de modelado relacional y versionado con GitHub.

---

## Herramientas

- **Microsoft SQL Server** (motor de base de datos).  
- **DBeaver** (cliente).  
- **GitHub** (control de versiones y repositorio).

---

## Contenido del repositorio

- Scripts de creación del esquema relacional inicial.  
- Modelos de entidades (ERD).  
- Versionado de cambios en la base de datos.

---

## Entidades y Assets

- **Foodtrucks**  
- **Productos**  
- **Pedidos (Orders)**  
- **Ubicaciones (Locations)**  
- **Detalle de ítems pedidos (Order_Items)**

---

## Modelo Relacional de FoodTrack

| Tabla        | PK             | FK                                                        | Campos importantes |
|-------------|----------------|-----------------------------------------------------------|------------------|
| foodtrucks  | foodtruck_id   | —                                                         | name, cuisine_type, city |
| products    | product_id     | foodtruck_id → foodtrucks(foodtruck_id)                  | name, price, stock |
| orders      | order_id       | foodtruck_id → foodtrucks(foodtruck_id)                  | order_date, status, total, comentarios, descuentos |
| order_items | order_item_id  | order_id → orders(order_id), product_id → products(product_id) | quantity |
| locations   | location_id    | foodtruck_id → foodtrucks(foodtruck_id)                  | location_date, zone |

---

## Notas importantes

- `status` en `orders` puede ser **VARCHAR(20)** o un **CHECK constraint** simulando ENUM (ej. entregado, pendiente).  
- `price` y `total` como **DECIMAL(10,2)**.  
- `stock` y `quantity` como **INT**.  
- Relaciones **uno a muchos**:  
  - Un foodtruck puede tener muchos productos, pedidos y ubicaciones.  
  - Un pedido puede tener muchos items (`order_items`).  
- Se agregaron **columnas VARCHAR** en `orders` para **comentarios y descuentos**.  

---

## Uso

1. Clonar el repositorio:

```bash
git clone https://github.com/TU_USUARIO/foodtrack-db.git


