class User {
  String userId, name, phone, email, password, user_roleId, user_photoId;

  User(
      {this.userId,
      this.name,
      this.phone,
      this.email,
      this.password,
      this.user_roleId,
      this.user_photoId});

  User.constructor(String name, String email, String password, String phone,
      String user_photoId) {
    this.name = name;
    this.email = email;
    this.password = password;
    this.phone = phone;
    this.user_photoId = user_photoId;
  }

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
      userId: jsonData['userId'],
      name: jsonData['name'],
      phone: jsonData['phone'],
      email: jsonData['email'],
      password: jsonData['password'],
      user_roleId: jsonData['user_roleId'],
      user_photoId: jsonData['user_photoId'],
    );
  }

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
        'user_roleId': user_roleId,
        'user_photoId': user_photoId
      };
}
