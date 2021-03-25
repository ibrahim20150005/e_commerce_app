import 'dart:convert';

import 'package:e_commerce_app/Model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  setUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", json.encode(user));
  }

  getUser(String key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (json.decode(prefs.getString(key)) == null) {
        return json.decode(prefs.getString(key));
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  setLogin(bool login) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("login", login);
  }

  Future<bool> getLogin() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (prefs.getBool("login")) {
        return prefs.getBool("login");
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
