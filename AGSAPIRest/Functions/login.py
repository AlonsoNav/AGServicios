import bcrypt

from flask import request, jsonify
from sqlalchemy import text


def login(engine):
    username = request.json["username"]
    password = request.json["password"]
    password = password.encode('utf-8')

    try:
        conn = engine.connect()
        result = conn.execute(text("EXEC sp_get_user @username = :username"), {'username': username}).fetchone()
        conn.commit()
        conn.close()

        if result:
            is_admin = result.isAdmin
            hash_password = result.password
            if bcrypt.checkpw(password, hash_password):
                return jsonify({'is_admin': is_admin}), 200
            else:
                return jsonify({'message': 'La contraseña no coincide.'}), 401
        else:
            return jsonify({'message': 'El usuario no existe.'}), 401

    except Exception as e:
        return jsonify({'message': str(e)}), 401
