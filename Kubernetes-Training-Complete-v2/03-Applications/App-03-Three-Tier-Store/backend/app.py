from flask import Flask, jsonify
import os, time
import psycopg2

app = Flask(__name__)

def connect():
    return psycopg2.connect(
        host=os.getenv('DB_HOST', 'postgres'),
        dbname=os.getenv('DB_NAME', 'store'),
        user=os.getenv('DB_USER', 'storeuser'),
        password=os.getenv('DB_PASSWORD', 'storepass'),
        connect_timeout=3,
    )

def init_db():
    for _ in range(20):
        try:
            with connect() as conn:
                with conn.cursor() as cur:
                    cur.execute('CREATE TABLE IF NOT EXISTS products (id SERIAL PRIMARY KEY, name TEXT NOT NULL, price NUMERIC NOT NULL)')
                    cur.execute('SELECT COUNT(*) FROM products')
                    if cur.fetchone()[0] == 0:
                        cur.execute("INSERT INTO products(name,price) VALUES ('Kubernetes T-Shirt',25.00),('DevOps Mug',12.50),('Cloud Notebook',8.00)")
            return
        except Exception:
            time.sleep(3)

init_db()

@app.get('/health')
def health():
    try:
        with connect() as conn:
            with conn.cursor() as cur:
                cur.execute('SELECT 1')
        return jsonify(status='ok'), 200
    except Exception as e:
        return jsonify(status='error', detail=str(e)), 503

@app.get('/api/products')
def products():
    with connect() as conn:
        with conn.cursor() as cur:
            cur.execute('SELECT id,name,price FROM products ORDER BY id')
            rows = cur.fetchall()
    return jsonify([{'id':r[0],'name':r[1],'price':float(r[2])} for r in rows])
