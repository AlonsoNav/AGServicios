from flask import request, jsonify
from sqlalchemy import text

def get_brand(engine):
    data = request.get_json()
    name = data.get('name')

    try:
        conn = engine.connect()
        result = conn.execute(
            text("EXEC sp_get_brand @name = :name"), {'name': name}).fetchone()
        conn.commit()
        conn.close()

        if result:
            return jsonify({'message': "Nombre: {} - Descripción: {}".format(result.name, result.description)}), 200
        else:
            return jsonify({'message': 'El usuario no existe.'}), 401

    except Exception as e:
        print(str(e))
        return jsonify({'message': 'Ha ocurrido un error inesperado en la conexión'}), 401
