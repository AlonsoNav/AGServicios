import pytest
import requests

# La URL de tu API
api_url = "http://127.0.0.1:5000/login"


@pytest.fixture
def api_data():
    return {"username": "admin1", "password": "12345678"}


def test(api_data):
    response = requests.post(api_url, json=api_data)
    assert response.status_code == 200


