import json

from flask import request, jsonify
from sqlalchemy import text

def delete_machine(engine):
    data = request.get_json()
    serial = data.get('serial')

    try:
        conn = engine.connect()
        result = conn.execute(
            text("EXEC sp_delete_machine @serial = :serial"), {'serial': serial}).scalar()
        conn.commit()
        conn.close()

        data_json = json.loads(result)

        if data_json.get("result") == 1:
            return jsonify({'message': data_json.get("description")}), 200
        else:
            return jsonify({'message': data_json.get("description")}), 401

    except Exception as e:
        return jsonify({'message': str(e)}), 401
