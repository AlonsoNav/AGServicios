import bcrypt

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
        conn.execute(
            text("EXEC sp_add_user @username = :username, @name = :name, @number = :number, @password = :password"),
            {'username': username, 'name': name, 'number': number, 'password': password})
        conn.commit()
        conn.close()
        return jsonify({'message': 'Usuario agregado correctamente'}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 401