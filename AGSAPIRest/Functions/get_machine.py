from flask import request, jsonify
from sqlalchemy import text

def get_machine(engine):
    data = request.get_json()
    serial = data.get('serial')

    try:
        conn = engine.connect()
        result = conn.execute(
            text("EXEC sp_get_machine @serial = :serial"), {'serial': serial}).fetchone()
        conn.commit()
        conn.close()

        if result:
            return jsonify({'message': "Modelo: {} - Serial: {} - Marca: {} - Tipo de maquinaria: {}".format(
                result.serial, result.model, result.brand, result.type)}), 200
        else:
            return jsonify({'message': 'El usuario no existe.'}), 401

    except Exception as e:
        return jsonify({'message': str(e)}), 401
