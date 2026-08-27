from flask import Flask, jsonify, render_template
import os, socket

app = Flask(__name__)

@app.get('/')
def index():
    return render_template('index.html')

@app.get('/health')
def health():
    return jsonify(status='ok'), 200

@app.get('/api/info')
def info():
    return jsonify(
        hostname=socket.gethostname(),
        environment=os.getenv('APP_ENV','unknown'),
        version=os.getenv('APP_VERSION','v1')
    )

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
