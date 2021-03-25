class Category {
  String categoryId, category_name, category_photoId;

  Category({
    this.categoryId,
    this.category_name,
    this.category_photoId,
  });

  Category.constructor(String category_name, String category_photoId) {
    this.category_name = category_name;
    this.category_photoId = category_photoId;
  }

  factory Category.fromJson(Map<String, dynamic> jsonData) {
    return Category(
      categoryId: jsonData['categoryId'],
      category_name: jsonData['category_name'],
      category_photoId: jsonData['image'],
    );
  }

  Map<String, dynamic> toMap() => {
        'categoryId': categoryId,
        'category_name': category_name,
        'category_photoId': category_photoId,
      };
}
