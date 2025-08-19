import json
from app.app import app

def test_index_route():
    client = app.test_client()
    resp = client.get("/")
    assert resp.status_code == 200
    data = json.loads(resp.data.decode("utf-8"))
    assert "message" in data
