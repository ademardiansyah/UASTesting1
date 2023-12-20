import json

from .settings import DEFAULT_PRICE

def test_product_detail_api(client):
    id = 3
    response = client.get(f"/api/products/{id}")
    assert response.status_code == 200
    data = json.loads(response.data)
    assert id == data.get('id')
    assert DEFAULT_PRICE * id


def test_product_api(client):
    response = client.get("/api/products")
    assert response.status_code == 200

# post new cart
def test_post_cart(client):
    # Define the cart data for testing
    cart_data = {
        "coupon_code": "TESTCODE",
        "shipping_fee": 10,
        "cart_items": [
            {"product_id": 1, "qty": 2},
            {"product_id": 2, "qty": 3}
        ]
    }

    # Send a POST request to create a new cart
    response = client.post("/api/cart", json=cart_data)

    # Check if the response status code is 200
    assert response.status_code == 200

    # Check if the response data is equal to the expected string
    assert response.data.decode('utf-8') == 'data created'