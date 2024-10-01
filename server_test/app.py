from flask import Flask, request, jsonify
from flask_cors import CORS
from datetime import datetime

app = Flask(__name__)
CORS(app)  # CORS 정책 해결을 위해 사용

travel_data = [
    {
        "name": "8월 힐링 제주도",
        "date": "2024.08.15 - 2024.08.18",
        "image_url": "assets/histories/back_0.png"
    },
]

@app.route('/', methods=['GET'])
def dol_data():
    return jsonify({"dolMessage": f"{datetime.today().strftime('%Y.%m.%d %H:%M:%S')}"}), 200

@app.route('/mytrip/add', methods=['POST'])
def save_travel_data():
    data = request.get_json()
    
    # 받은 데이터를 리스트에 저장
    travel_data.append({
        'name': data['name'],
        'date' : data['date'],
        'image_url': data['image_url'],
    })

    # 응답 반환
    return jsonify({"message": "Travel data saved successfully!"}), 200

@app.route('/mytrip', methods=['GET'])
def brief_data():
    return jsonify(travel_data), 200

if __name__ == '__main__':
    app.run(debug=True)
