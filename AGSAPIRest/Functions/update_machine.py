import json

from flask import request, jsonify
from sqlalchemy import text

def update_machine(engine):
    data = request.get_json()
    serial = data.get('serial')
    new_serial = data.get('newSerial')
    model = data.get('model')

    try:
        conn = engine.connect()
        result = conn.execute(
            text("EXEC sp_update_machine @inSerial = :serial, @inNewModel = :model, @inNewSerial = :newSerial"),
            {'serial': serial, 'model': model, 'newSerial': new_serial}).scalar()
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
