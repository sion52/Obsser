from flask import Flask, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # CORS 정책 해결을 위해 사용

@app.route('/', methods=['GET'])
def test_connection():
    return jsonify({"message": "Connection successful!"}), 200

@app.route('/dol', methods=['GET'])
def dol_data():
    return jsonify({"dolMessage": "This is DolScreen data!"}), 200

if __name__ == '__main__':
    app.run(debug=True)