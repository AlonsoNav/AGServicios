import json

from flask import request, jsonify
from sqlalchemy import text

def update_brand(engine):
    data = request.get_json()
    name = data.get('name')
    new_name = data.get('newName')
    description = data.get('description')

    try:
        conn = engine.connect()
        result = conn.execute(
            text("EXEC sp_update_brand @name = :name, @newName = :newName, @description = :description"),
            {'name': name, 'newName': new_name, 'description': description}).scalar()
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
