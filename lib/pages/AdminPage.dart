import 'package:e_commerce_app/Model/User.dart';
import 'package:e_commerce_app/pages/AddCategory.dart';
import 'package:e_commerce_app/pages/AddProduct.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  AdminPage({Key key, this.user3}) : super(key: key);
  final User user3;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin Page",
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Container(
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20)),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddCategory(user4: user3)));
                  },
                  child: Text(
                    'Add Category',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20)),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddPoduct(user5: user3)));
                    },
                    child: Text(
                      'Add Product',
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
