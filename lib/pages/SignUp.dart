import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_commerce_app/Model/Serveices.dart';
import 'package:e_commerce_app/Model/User.dart';
import 'package:e_commerce_app/pages/Login.dart';
import 'package:e_commerce_app/pages/MyHomePage.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class SignUp extends StatelessWidget {
  final controlName = TextEditingController();
  final controlEmail = TextEditingController();
  final controlPassword = TextEditingController();
  final controlRePassword = TextEditingController();
  final controlPhone = TextEditingController();
  bool emailAlreadyExit = false;
  User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: SizedBox(
                      width: 250.0,
                      child: TextLiquidFill(
                        text: 'Shopping 4U',
                        waveColor: Colors.red[500],
                        boxBackgroundColor: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                        boxHeight: 150.0,
                        boxWidth: 400.0,
                      ),
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: emailAlreadyExit
                        ? Text(
                            'Email Alraedy Exit',
                            style:
                                TextStyle(fontSize: 20, color: Colors.red[500]),
                          )
                        : Text(
                            'Sign Up',
                            style:
                                TextStyle(fontSize: 20, color: Colors.red[500]),
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
                        controller: controlName,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Name",
                          icon: Icon(
                            Icons.person,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
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
                          hintText: "Email",
                          icon: Icon(
                            Icons.email,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.red.withOpacity(0.3),
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: TextFormField(
                        controller: controlRePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "RePassword",
                          icon: Icon(
                            Icons.lock,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.red.withOpacity(0.3),
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: TextFormField(
                        controller: controlPhone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone",
                          icon: Icon(
                            Icons.mobile_screen_share,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20)),
                  child: MaterialButton(
                    onPressed: () {
                      if (controlName.text.isNotEmpty &&
                          controlEmail.text.isNotEmpty &&
                          controlPassword.text.isNotEmpty &&
                          controlRePassword.text.isNotEmpty &&
                          controlPhone.text.isNotEmpty) {
                        user = new User.constructor(
                            controlName.text,
                            controlEmail.text,
                            controlPassword.text,
                            controlPhone.text,
                            "text");
                        Serveices.insertUser(user).then((value) {
                          if (value == true) {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) =>
                                        MyHomePage(user1: user)))
                                .then((value) {
                              Navigator.of(context).pop();
                            });
                          } else {
                            Toast.show("the account already exit", context,
                                backgroundColor: Colors.black,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                          }
                        });
                      } else {
                        Toast.show("Please Fill in Data", context,
                            backgroundColor: Colors.black,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.BOTTOM);
                      }
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "OR Sign Up With",
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
                            style: TextStyle(color: Colors.white, fontSize: 20),
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
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                new InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: new Padding(
                    padding: new EdgeInsets.all(10.0),
                    child: new Text(
                      'already have an account',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
