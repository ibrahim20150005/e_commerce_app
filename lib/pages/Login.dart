import 'dart:ui';
import 'package:e_commerce_app/Model/Serveices.dart';
import 'package:e_commerce_app/Model/SharedPreferences.dart';
import 'package:e_commerce_app/Model/User.dart';
import 'package:e_commerce_app/pages/MyHomePage.dart';
import 'package:e_commerce_app/pages/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:toast/toast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final controlEmail = TextEditingController();
  final controlPassword = TextEditingController();
  List<User> user;
  StorageService sharP;
  bool nameValidate = false;
  bool isLogin = false;

  bool passwordValidate = false;
  @override
  void initState() {
    //  getLogIn();
    /* sharP.getLogin().then((value) {
      if (value != null) {
        User user = User.fromJson(sharP.getUser("user"));
        if (user.userId.isNotEmpty) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MyHomePage(user1: user)));
        }
      }
    });*/

    super.initState();
  }

  getLogIn() async {
    isLogin = await sharP.getLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Center(
                  child: TextLiquidFill(
                    text: 'Shopping 4U',
                    waveColor: Colors.red[500],
                    boxBackgroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20, color: Colors.red[500]),
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.red.withOpacity(0.3),
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextFormField(
                          controller: controlEmail,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email or Phone",
                            icon: Icon(
                              Icons.person,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      child: nameValidate
                          ? Text(
                              "Please Enter Your Email or Phone ",
                              style: TextStyle(color: Colors.red),
                            )
                          : null),
                  Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.red.withOpacity(0.3),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: TextFormField(
                              controller: controlPassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          child: nameValidate
                              ? Text(
                                  "Please Enter Your Password ",
                                  style: TextStyle(color: Colors.red),
                                )
                              : null),
                      new InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: new Text(
                          'Forget Your Password ?',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: MaterialButton(
                      onPressed: () {
                        checkUser(context);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "OR",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 130.0,
                          decoration: BoxDecoration(
                              color: Colors.blue[900].withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20)),
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              'Facebook',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 130.0,
                          decoration: BoxDecoration(
                              color: Colors.redAccent[700].withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20)),
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              'Google',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: new Padding(
                      padding: new EdgeInsets.all(10.0),
                      child: new Text(
                        'New User? Create Account',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  checkUser(BuildContext context) {
    Serveices.getUser(controlEmail.text, controlPassword.text).then((value) {
      if (value.userId != null) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MyHomePage(user1: value)));
      } else {
        Toast.show("you no have account!", context,
            backgroundColor: Colors.black,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);
      }
    });
  }
}
