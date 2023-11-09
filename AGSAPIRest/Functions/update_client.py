import json

from flask import request, jsonify
from sqlalchemy import text

def update_client(engine):
    data = request.get_json()
    name = data.get("name")
    newName = data.get("newName")
    number = data.get("number")
    address = data.get("address")
    email = data.get("email")

    try:
        conn = engine.connect()
        result = conn.execute(
            text("EXEC sp_update_client @inName = :name, @inNewName = :newName, @inNewNumber = :number, "
                 "@inNewAddress = :address, @inNewEmail = :email"),
            {'name':name, 'newName': newName, 'number':number, 'address':address, 'email':email}).scalar()
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