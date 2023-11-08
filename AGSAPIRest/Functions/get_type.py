from flask import request, jsonify
from sqlalchemy import text

def get_type(engine):
    data = request.get_json()
    name = data.get('name')

    try:
        name = name.strip()
        if name:
            query = text("EXEC sp_get_type @name = :name"), {'name': name}
        else:
            query = text("EXEC sp_get_all_types"), {}
        conn = engine.connect()
        result = conn.execute(query[0], query[1]).fetchall()
        conn.commit()
        conn.close()

        if result:
            type_list = [{'name': row.name, 'description': row.description} for row in result]
            return jsonify({'types': type_list}), 200
        else:
            return jsonify({'message': 'Error: El tipo de maquinaria no existe'}), 401

    except Exception as e:
        print(str(e))
        return jsonify({'message': 'Error: Fallo inesperado en la conexión'}), 401
