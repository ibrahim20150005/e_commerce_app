import 'dart:async';

import 'package:e_commerce_app/pages/Login.dart';
import 'package:flutter/material.dart';

class MySplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MySplashScreen();
  }
}

class _MySplashScreen extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Login())));
  }

  @override
  Widget build(BuildContext context) {
    return MyLogo();
  }
}

class MyLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('Images/splash.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
