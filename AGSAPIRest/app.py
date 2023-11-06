import os

from flask import Flask
from sqlalchemy import create_engine
from dotenv import load_dotenv
from Functions import (login, add_user, add_brand, add_client, add_machine, add_type, delete_brand, delete_machine,
                       delete_type, get_brand, get_machine, get_type, update_brand, update_machine, update_type)

load_dotenv()

DB_USER = os.getenv('DB_USER')
DB_PASS = os.getenv('DB_PASS')
DB_HOST = os.getenv('DB_HOST')
DB_PORT = os.getenv('DB_PORT')
DB_NAME = os.getenv('DB_NAME')
DB_DRIVER = os.getenv('DB_DRIVER')

app = Flask(__name__)
engine = create_engine(f"mssql+pyodbc://{DB_USER}:{DB_PASS}@{DB_HOST}:{DB_PORT}/{DB_NAME}?driver={DB_DRIVER}")


@app.route('/login', methods=['POST'])
def execute_login():
    return login.login(engine)


@app.route('/add_user', methods=['POST'])
def execute_add_user():
    return add_user.add_user(engine)


@app.route('/add_brand', methods=['POST'])
def execute_add_brand():
    return add_brand.add_brand(engine)


@app.route('/add_client', methods=['POST'])
def execute_add_client():
    return add_client.add_client(engine)


@app.route('/add_machine', methods=['POST'])
def execute_add_machine():
    return add_machine.add_machine(engine)


@app.route('/add_type', methods=['POST'])
def execute_add_type():
    return add_type.add_type(engine)


@app.route('/delete_brand', methods=['POST'])
def execute_delete_brand():
    return delete_brand.delete_brand(engine)


@app.route('/delete_machine', methods=['POST'])
def execute_delete_machine():
    return delete_machine.delete_machine(engine)


@app.route('/delete_type', methods=['POST'])
def execute_delete_type():
    return delete_type.delete_type(engine)


@app.route('/get_brand', methods=['POST'])
def execute_get_brand():
    return get_brand.get_brand(engine)


@app.route('/get_machine', methods=['POST'])
def execute_get_machine():
    return get_machine.get_machine(engine)


@app.route('/get_type', methods=['POST'])
def execute_get_type():
    return get_type.get_type(engine)


@app.route('/update_brand', methods=['POST'])
def execute_update_brand():
    return update_brand.update_brand(engine)


@app.route('/update_machine', methods=['POST'])
def execute_update_machine():
    return update_machine.update_machine(engine)


@app.route('/update_type', methods=['POST'])
def execute_update_type():
    return update_type.update_type(engine)


if __name__ == '__main__':
    app.run(debug=True)
