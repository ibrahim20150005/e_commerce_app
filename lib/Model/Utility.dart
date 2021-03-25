import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:convert';

class Utility {
  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
      width: 80.0,
      height: 90.0,
    );
  }

  static Image imageFromBase64StringF(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
      width: 100.0,
      height: 90.0,
    );
  }

  static Image imageFromBase64StringP(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.scaleDown,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
