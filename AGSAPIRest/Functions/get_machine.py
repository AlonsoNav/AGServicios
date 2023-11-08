from flask import request, jsonify
from sqlalchemy import text

def get_machine(engine):
    data = request.get_json()
    serial = data.get('serial')

    try:
        serial = serial.strip()
        if serial:
            query = text("EXEC sp_get_machine @serial = :serial"), {'serial': serial}
        else:
            query = text("EXEC sp_get_all_machines"), {}
        conn = engine.connect()
        result = conn.execute(query[0], query[1]).fetchall()
        conn.commit()
        conn.close()

        if result:
            machine_list = [{'serial': row.serial, 'model': row.model, 'brand': row.brand, 'type': row.type}
                            for row in result]
            return jsonify({'machines': machine_list}), 200
        else:
            return jsonify({'message': 'Error: La máquina no existe'}), 401

    except Exception as e:
        print(str(e))
        return jsonify({'message': 'Error: Fallo inesperado en la conexión'}), 401
