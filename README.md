# FoodTrack DB

## Descripción del proyecto

**FoodTrack** es una plataforma para gestionar operaciones de foodtrucks en distintos puntos de la ciudad.  
Este repositorio contiene la **base de datos SQL Server** y los scripts para:

- Crear tablas (`foodtrucks`, `products`, `orders`, `order_items`, `locations`)  
- Insertar datos iniciales desde CSV  
- Automatizar la carga de datos mediante Python  

El objetivo es simular un entorno de desarrollo profesional con un motor robusto y versionado desde el inicio.

---

## Modelo de datos (Descripción de tablas)

### **foodtrucks**
| Columna       | Tipo           | Descripción                       |
|---------------|---------------|----------------------------------|
| foodtruck_id  | INT PK        | Identificador único del foodtruck |
| name          | NVARCHAR(100) | Nombre del foodtruck             |
| cuisine_type  | NVARCHAR(50)  | Tipo de cocina                   |
| city          | NVARCHAR(100) | Ciudad en la que opera           |

### **products**
| Columna       | Tipo           | Descripción                       |
|---------------|---------------|----------------------------------|
| product_id    | INT PK        | Identificador único del producto |
| foodtruck_id  | INT FK        | Referencia a foodtrucks          |
| name          | NVARCHAR(100) | Nombre del producto              |
| price         | DECIMAL(10,2) | Precio del producto              |
| stock         | INT           | Stock disponible                 |

### **orders**
| Columna       | Tipo           | Descripción                       |
|---------------|---------------|----------------------------------|
| order_id      | INT PK        | Identificador único del pedido    |
| foodtruck_id  | INT FK        | Referencia a foodtrucks          |
| order_date    | DATETIME      | Fecha del pedido                  |
| status        | NVARCHAR(50)  | Estado del pedido                 |
| total         | DECIMAL(10,2) | Total del pedido                  |

### **order_items**
| Columna       | Tipo           | Descripción                       |
|---------------|---------------|----------------------------------|
| order_item_id | INT PK        | Identificador único del ítem      |
| order_id      | INT FK        | Referencia a orders               |
| product_id    | INT FK        | Referencia a products             |
| quantity      | INT           | Cantidad del producto             |

### **locations**
| Columna       | Tipo           | Descripción                       |
|---------------|---------------|----------------------------------|
| location_id   | INT PK        | Identificador único de ubicación  |
| foodtruck_id  | INT FK        | Referencia a foodtrucks          |
| location_date | DATETIME      | Fecha de operación                |
| zone          | NVARCHAR(100) | Zona donde se encuentra          |

---

## Diagrama ER

![Diagrama ER de FoodTrack](FoodTrackDB_ER.png)

> Exportá este diagrama desde DBeaver o cualquier herramienta de modelado y guardalo en la raíz del repositorio como `ER_FoodTrack.png`.

---

## Instrucciones para ejecutar los scripts

1. Abrir SQL Server Management Studio (SSMS) o DBeaver y conectarse a `FoodTrackDB`.  
2. Ejecutar los scripts de creación de tablas en la carpeta `/scripts/`.  
3. Cargar los datos iniciales desde los CSV usando:
   - **BULK INSERT** o  
   - **Asistente de importación de SQL Server**
4. Ejecutar `AUT_failed_orders.py` para cargar datos automáticamente con Python y registrar errores en la tabla `failed_orders`.  
5. Verificar la carga:

```sql
SELECT * FROM foodtrucks;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM locations;
SELECT * FROM failed_orders;