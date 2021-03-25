import 'dart:async';

import 'dart:convert';
import 'dart:io';
import 'package:e_commerce_app/Model/User.dart';
import 'package:e_commerce_app/pages/GridViewVer.dart';
import 'package:e_commerce_app/pages/ListViewHorizontal.dart';
import 'package:e_commerce_app/pages/SearchPage.dart';
import 'package:e_commerce_app/pages/carousel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:e_commerce_app/pages/CartPage.dart';
import 'package:e_commerce_app/pages/drawer.dart';
import 'package:flutter/material.dart';

import 'package:connectivity/connectivity.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.user1}) : super(key: key);

  final User user1;

  @override
  State<StatefulWidget> createState() {
    return _MyHomePage();
  }
}

class _MyHomePage extends State<MyHomePage> {
  var _connectionStatus = 'Unknown';
  String search;
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  _showMaterialDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              content: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Search here...'),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    search = value;
                  }
                },
              ),
              actions: <Widget>[
                MaterialButton(
                  child: Text('Search'),
                  color: Colors.red[800],
                  onPressed: () {
                    if (search != null) {
                      setState(() {
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) =>
                                    SearchPage(search: search)))
                            .then((value) {
                          search = "";
                        });
                      });
                    }
                  },
                )
              ],
            ));
  }

  @override
  void initState() {
    super.initState();
    connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _connectionStatus = result.toString();
      Toast.show("Wellcome ${widget.user1.name}", context,
          backgroundColor: Colors.black,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);

      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        setState(() {});
      }
    });
  }

  Future getData() async {
    try {
      http.Response response = await http.get("http://www.google.com/");
      if (response.statusCode == HttpStatus.OK) {
        var result = jsonDecode(jsonEncode(response.body));
        return result;
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          title: Text("Shopping 4U"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  _showMaterialDialog(context);
                }),
            IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CartPage(
                            user: widget.user1,
                          )));
                }),
          ],
        ),
        drawer: DrawerPage(user2: widget.user1),
        body: new FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: <Widget>[
                  Container(
                    height: 310.0,
                    child: Carouselpor(),
                  ),
                  Container(
                    padding: EdgeInsets.all(2.0),
                    height: 25,
                    color: Colors.red[600],
                    child: Text('Categories',
                        style:
                            new TextStyle(fontSize: 16.0, color: Colors.black)),
                  ),
                  Container(
                    height: 120.0,
                    color: Colors.white,
                    child: ListViewHor(),
                  ),
                  Container(
                    padding: EdgeInsets.all(2.0),
                    height: 25,
                    color: Colors.red[600],
                    child: Text('Recent products',
                        style:
                            new TextStyle(fontSize: 16.0, color: Colors.black)),
                  ),
                  Container(
                    height: 500.0,
                    color: Colors.white,
                    child: GridViewVer(user: widget.user1),
                  ),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: new SpinKitCubeGrid(
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: index.isEven ? Colors.red : Colors.green,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ));
  }
}
