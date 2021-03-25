import 'dart:convert';

import 'package:e_commerce_app/Model/Cart.dart';
import 'package:e_commerce_app/Model/Category.dart';
import 'package:e_commerce_app/Model/Favorite.dart';
import 'package:e_commerce_app/Model/Product.dart';
import 'package:e_commerce_app/Model/User.dart';
import 'package:http/http.dart' as http;

class Serveices {
  static const ROOT = "http://192.168.1.2/Ecommerce/MyDatabase.php";
  static const SELECT_USER = "Get_User";
  static const INSERT_USER = "Insert_User";
  static const INSERT_CATEGORY = "Add_Category";
  static const INSERT_PRODUCT = "Add_Product";
  static const SELECT_CATEGORIES = "Get_Categories";
  static const SELECT_PRODUCTS = "Get_Products";
  static const SELECT_CATEGORY = "Get_Gategory";
  static const SELECT_SIMILAR_PRODUCTS = "Get_SimilarProducts";
  static const SEARCH = "Search";
  static const CHECK_FAVORAITE = "Check_Favoraite";
  static const FAVORAITE_PRODUCT = "Favoraite_Product";
  static const FAVORAITE_DELETE = "Favoraite_Delete";
  static const CHECK_CART = "Check_Cart";
  static const CART_PRODUCT = "Cart_Product";
  static const CART_DELETE = "Cart_Delete";
//select user
  static Future<User> getUser(String emailOrPhone, String password) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = SELECT_USER;
      map['email'] = emailOrPhone;
      map['phone'] = emailOrPhone;
      map['password'] = password;
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        if (response.body != "Error") {
          User user = parseResponseUser(response.body);
          return user;
        } else {
          return User();
        }
      } else {
        return User();
      }
    } catch (e) {
      return User();
    }
  }

//insert user
  static Future<bool> insertUser(User user) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = INSERT_USER;
      map['name'] = user.name;
      map['email'] = user.email;
      map['phone'] = user.phone;
      map['password'] = user.password;
      User _user = await getUser(user.phone, user.password);
      if (_user.userId != null) {
        return false;
      } else {
        http.post(ROOT, body: map);
        return true;
      }
    } catch (e) {
      return false;
    }
  }

//insert category
  static Future<bool> insertCategory(Category category) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = INSERT_CATEGORY;
      map['category_name'] = category.category_name;
      map['image'] = category.category_photoId;
      Category _category = await getCategory(category.category_name);
      if (_category.categoryId != null) {
        return false;
      } else {
        http.post(ROOT, body: map);
        return true;
      }
    } catch (e) {
      return false;
    }
  }

//insert product
  static Future<bool> insertProduct(Product product) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = INSERT_PRODUCT;
      map['product_name'] = product.product_name;
      map['descreption'] = product.descreption;
      map['size'] = product.size;
      map['color'] = product.color;
      map['product_brand'] = product.product_brand;
      map['product_condition'] = product.product_condition;
      map['price'] = product.price;
      map['categoryId'] = product.categoryId;
      map['image'] = product.product_photoId;
      final response = await http.post(ROOT, body: map);
      print(response.statusCode);
      if (200 == response.statusCode) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//select categories
  static Future<List<Category>> getCategories() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = SELECT_CATEGORIES;
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        if (response.body != "Error") {
          List<Category> category = parseResponseCategories(response.body);
          return category;
        } else {
          return List.empty();
        }
      } else {
        return List.empty();
      }
    } catch (e) {
      return List.empty();
    }
  }

//search
  static Future<List<Product>> getSearch(String search) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = SEARCH;
      map['search'] = search;
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        if (response.body != "Error") {
          List<Product> product = parseResponseProducts(response.body);
          return product;
        } else {
          return List.empty();
        }
      } else {
        return List.empty();
      }
    } catch (e) {
      return List.empty();
    }
  }

//get gategory
  static Future<Category> getCategory(String categoryName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = SELECT_CATEGORY;
      map['category_name'] = categoryName;

      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        if (response.body != "Error") {
          Category category = parseResponseCategory(response.body);
          return category;
        } else {
          return Category();
        }
      } else {
        return Category();
      }
    } catch (e) {
      return Category();
    }
  }

  //select Products
  static Future<List<Product>> getProducts() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = SELECT_PRODUCTS;
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        if (response.body != "Error") {
          List<Product> product = parseResponseProducts(response.body);
          return product;
        } else {
          return List.empty();
        }
      } else {
        return List.empty();
      }
    } catch (e) {
      return List.empty();
    }
  }

  //select Products
  static Future<List<Product>> getSimilarProducts(String id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = SELECT_SIMILAR_PRODUCTS;
      map['categoryId'] = id;
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        if (response.body != "Error") {
          List<Product> product = parseResponseProducts(response.body);
          return product;
        } else {
          return List.empty();
        }
      } else {
        return List.empty();
      }
    } catch (e) {
      return List.empty();
    }
  }

//Product is favoraite
  static Future<String> productFavoraite(Favorite favorite) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = FAVORAITE_PRODUCT;
      map['productId'] = favorite.productId;
      map['userId'] = favorite.userId;
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

// check  is the product  favoraite
  static Future<bool> checkFavoraite(
    String userId,
    String productId,
  ) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = CHECK_FAVORAITE;
      map['productId'] = productId;
      map['userId'] = userId;

      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        if (response.body != "Error") {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

// Delete product  favoraite
  static Future<bool> deleteFavoraite(
    String userId,
    String productId,
  ) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = FAVORAITE_DELETE;
      map['productId'] = productId;
      map['userId'] = userId;

      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        if (response.body != "Error") {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  //Product is Cart
  static Future<String> productCart(Cart cart) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = CART_PRODUCT;
      map['productId'] = cart.productId;
      map['userId'] = cart.userId;
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

// check  is the product  Cart
  static Future<bool> checkCart(
    String userId,
    String productId,
  ) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = CHECK_CART;
      map['productId'] = productId;
      map['userId'] = userId;

      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        if (response.body != "Error") {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

// Delete product  cart
  static Future<bool> deleteCart(
    String userId,
    String productId,
  ) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = CART_DELETE;
      map['productId'] = productId;
      map['userId'] = userId;

      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        if (response.body != "Error") {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static User parseResponseUser(String responseBody) {
    Map<String, dynamic> parsed = jsonDecode(responseBody);
    return User.fromJson(parsed);
  }

  static Category parseResponseCategory(String responseBody) {
    Map<String, dynamic> parsed = jsonDecode(responseBody);
    return Category.fromJson(parsed);
  }

  static List<Category> parseResponseCategories(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Category>((json) => Category.fromJson(json)).toList();
  }

  static List<Product> parseResponseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }
}
