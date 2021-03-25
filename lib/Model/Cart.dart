class Cart {
  String cartId, productId, userId;

  Cart({this.cartId, this.productId, this.userId});

  Cart.constructor(String productId, String userId) {
    this.productId = productId;
    this.userId = userId;
  }

  factory Cart.fromJson(Map<String, dynamic> jsonData) {
    return Cart(
      cartId: jsonData['CartId'],
      productId: jsonData['productId'],
      userId: jsonData['userId'],
    );
  }

  Map<String, dynamic> toMap() => {
        'cartId': cartId,
        'productId': productId,
      };
}
