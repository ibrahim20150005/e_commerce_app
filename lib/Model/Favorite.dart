class Favorite {
  String favoriteId, productId, userId;

  Favorite({this.favoriteId, this.productId, this.userId});

  Favorite.constructor(String productId, String userId) {
    this.productId = productId;
    this.userId = userId;
  }

  factory Favorite.fromJson(Map<String, dynamic> jsonData) {
    return Favorite(
      favoriteId: jsonData['favoriteId'],
      productId: jsonData['productId'],
      userId: jsonData['userId'],
    );
  }

  Map<String, dynamic> toMap() => {
        'favoriteId': favoriteId,
        'productId': productId,
      };
}
