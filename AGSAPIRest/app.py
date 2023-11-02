import os

from flask import Flask
from sqlalchemy import create_engine
from dotenv import load_dotenv
from Functions import login, add_user

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

if __name__ == '__main__':
    app.run(debug=True)
