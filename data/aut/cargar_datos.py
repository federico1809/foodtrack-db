import pyodbc
import csv

# Configuración de conexión
conn = pyodbc.connect(
    'DRIVER={SQL Server};'
    'SERVER=DESKTOP-TMO0BEL;'
    'DATABASE=FoodTrackDB;'
    'Trusted_Connection=yes;'
)
cursor = conn.cursor()

# Tabla auxiliar para errores
cursor.execute("""
IF OBJECT_ID('failed_orders','U') IS NULL
CREATE TABLE failed_orders (
    order_id INT,
    error_message NVARCHAR(255)
)
""")
conn.commit()

# Ejemplo: cargar orders desde CSV
with open('orders.csv', 'r', encoding='utf-8') as f:
    reader = csv.DictReader(f)
    for row in reader:
        try:
            cursor.execute("""
                INSERT INTO orders (order_id, foodtruck_id, order_date, status, total)
                VALUES (?, ?, ?, ?, ?)
            """, row['order_id'], row['foodtruck_id'], row['order_date'], row['status'], row['total'])
        except Exception as e:
            cursor.execute("INSERT INTO failed_orders (order_id, error_message) VALUES (?, ?)",
                           row['order_id'], str(e))
conn.commit()
conn.close()
