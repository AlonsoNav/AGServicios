import json

from flask import request, jsonify
from sqlalchemy import text

def add_machine(engine):
    data = request.get_json()
    brand = data.get("brand")
    type = data.get("type")
    serial = data.get("serial")
    model = data.get("model")

    try:
        conn = engine.connect()
        result = conn.execute(
            text("EXEC sp_add_machine @brand = :brand, @type = :type, @serial = :serial, @model = :model"),
            {'brand': brand, 'type': type, 'serial': serial, 'model': model}).scalar()
        conn.commit()
        conn.close()

        data_json = json.loads(result)

        if data_json.get("result") == 1:
            return jsonify({'message': data_json.get("description")}), 200
        else:
            return jsonify({'message': data_json.get("description")}), 401

    except Exception as e:
        return jsonify({'message': str(e)}), 401
