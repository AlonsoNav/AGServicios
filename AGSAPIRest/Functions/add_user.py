import bcrypt
import json

from flask import request, jsonify
from sqlalchemy import text


def add_user(engine):
    data = request.get_json()
    username = data.get('username')
    name = data.get('name')
    number = data.get('number')
    password = data.get('password')
    password = password.encode('utf-8')
    password = bcrypt.hashpw(password, bcrypt.gensalt())

    try:
        conn = engine.connect()
        result = conn.execute(
            text("EXEC sp_add_user @username = :username, @name = :name, @number = :number, @password = :password"),
            {'username': username, 'name': name, 'number': number, 'password': password}).scalar()
        conn.commit()
        conn.close()

        data_json = json.loads(result)

        if data_json.get("result") == 1:
            return jsonify({'message': data_json.get("description")}), 200
        else:
            return jsonify({'message': data_json.get("description")}), 401

    except Exception as e:
        print(str(e))
        return jsonify({'message': 'Error: Fallo inesperado en la conexión'}), 401
