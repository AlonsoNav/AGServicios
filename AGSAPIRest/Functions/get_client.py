import json

from flask import request, jsonify
from sqlalchemy import text

def get_client(engine):
    data = request.get_json()
    name = data.get('name')

    try:
        name = name.strip()
        if name:
            query = text("EXEC sp_get_client @name = :name"), {'name': name}
        else:
            query = text("EXEC sp_get_all_clients"), {}
        conn = engine.connect()
        result = conn.execute(query[0], query[1]).fetchall()
        conn.commit()
        conn.close()

        data_json = json.loads(result)

        if data_json.get("result") == 1:
            client_list = [{'name': row.name, 'number': row.contactnumber, 'address': row.address, 'email': row.email}
                           for row in result]
            return jsonify({'clients': client_list}), 200
        else:
            return jsonify({'message': 'Error: el cliente no existe'}), 401

    except Exception as e:
        print(str(e))
        return jsonify({'message': 'Error: Fallo inesperado en la conexión'}), 401