class Product {
  String productId,
      product_name,
      descreption,
      size,
      color,
      product_brand,
      product_condition,
      price,
      categoryId,
      product_photoId;

  Product(
      {this.productId,
      this.product_name,
      this.descreption,
      this.size,
      this.color,
      this.product_brand,
      this.product_condition,
      this.price,
      this.categoryId,
      this.product_photoId});

  Product.constructor(
      String product_name,
      String descreption,
      String size,
      String color,
      String product_brand,
      String product_condition,
      String price,
      String categoryId,
      String product_photoId) {
    this.product_name = product_name;
    this.descreption = descreption;
    this.size = size;
    this.color = color;
    this.product_brand = product_brand;
    this.product_condition = product_condition;
    this.price = price;
    this.categoryId = categoryId;
    this.product_photoId = product_photoId;
  }

  factory Product.fromJson(Map<String, dynamic> jsonData) {
    return Product(
      productId: jsonData['productId'],
      product_name: jsonData['product_name'],
      descreption: jsonData['descreption'],
      size: jsonData['size'],
      color: jsonData['color'],
      product_brand: jsonData['product_brand'],
      product_condition: jsonData['product_condition'],
      price: jsonData['price'],
      categoryId: jsonData['categoryId'],
      product_photoId: jsonData['image'],
    );
  }

  Map<String, dynamic> toMap() => {
        'productId': productId,
        'product_name': product_name,
        'descreption': descreption,
        'size': size,
        'color': color,
        'product_brand': product_brand,
        'product_condition': product_condition,
        'price': price,
        'categoryId': categoryId,
        'product_photoId': product_photoId
      };
}
