import 'package:e_commerce_app/Model/Cart.dart';
import 'package:e_commerce_app/Model/Favorite.dart';
import 'package:e_commerce_app/Model/Product.dart';
import 'package:e_commerce_app/Model/Serveices.dart';
import 'package:e_commerce_app/Model/User.dart';
import 'package:e_commerce_app/Model/Utility.dart';
import 'package:e_commerce_app/pages/SimilarProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  final User user;
  ProductDetails({this.product, this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping 4U"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            SinglProduct(
              product: product,
            ),
            DropDown(),
            ButtonCustom(product, user),
            Description(product: product),
            new Padding(
              padding: const EdgeInsets.all(15.0),
              child: new Text('Similar Products',
                  style: new TextStyle(fontSize: 20.0, color: Colors.red[500])),
            ),
            Container(
              height: 320.0,
              child: SimilarProduct(
                categoryId: product.categoryId,
                productId: product.productId,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SinglProduct extends StatelessWidget {
  final Product product;

  SinglProduct({this.product});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 300,
        child: Hero(
            tag: product.product_name,
            child: Material(
              child: InkWell(
                onTap: () {},
                child: GridTile(
                    footer: Container(
                      color: Colors.white70,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                product.product_name,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "\$${product.price}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.grey),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "\$${product.price}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.red,
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    child: Utility.imageFromBase64StringP(
                        product.product_photoId)),
              ),
            )),
      ),
    );
  }
}

class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: new DropdownButton<String>(
                hint: Text("Size"),
                items: <String>['A', 'B', 'C', 'D'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: new DropdownButton<String>(
                hint: Text("Color"),
                items: <String>['A', 'B', 'C', 'D'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: new DropdownButton<String>(
                hint: Text("Quntity"),
                items: <String>['A', 'B', 'C', 'D'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonCustom extends StatefulWidget {
  final Product product;
  final User user;
  ButtonCustom(this.product, this.user);

  @override
  _ButtonCustomState createState() => _ButtonCustomState();
}

class _ButtonCustomState extends State<ButtonCustom> {
  bool checkFav = false;
  bool checkCart = false;

  @override
  void initState() {
    Serveices.checkFavoraite(widget.user.userId, widget.product.productId)
        .then((value) {
      if (value == true) {
        setState(() {
          checkFav = true;
        });
      } else {
        setState(() {
          checkFav = false;
        });
      }
    });
    Serveices.checkCart(widget.user.userId, widget.product.productId)
        .then((value) {
      if (value == true) {
        setState(() {
          checkCart = true;
        });
      } else {
        setState(() {
          checkCart = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 2.0),
              child: MaterialButton(
                  elevation: 0.8,
                  child: Text(
                    "Buy Now",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  color: Colors.red[500],
                  onPressed: () {}),
            ),
          ),
          Expanded(
              child: IconButton(
                  icon: checkFav == true
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(Icons.favorite_outline_outlined),
                  onPressed: () {
                    Serveices.checkFavoraite(
                            widget.user.userId, widget.product.productId)
                        .then((value) {
                      if (value != true) {
                        setState(() {
                          checkFav = true;
                          Favorite favorite = Favorite(
                              productId: widget.product.productId,
                              userId: widget.user.userId);
                          Serveices.productFavoraite(favorite);
                        });
                      } else {
                        setState(() {
                          checkFav = false;
                          Serveices.deleteFavoraite(
                              widget.user.userId, widget.product.productId);
                        });
                      }
                    });
                  })),
          Expanded(
              child: IconButton(
                  icon: checkCart == true
                      ? Icon(
                          Icons.shopping_cart,
                          color: Colors.red,
                        )
                      : Icon(Icons.shopping_cart_outlined),
                  onPressed: () {
                    Serveices.checkCart(
                            widget.user.userId, widget.product.productId)
                        .then((value) {
                      if (value != true) {
                        setState(() {
                          checkCart = true;
                          Cart cart = Cart(
                              productId: widget.product.productId,
                              userId: widget.user.userId);
                          Serveices.productCart(cart);
                        });
                      } else {
                        setState(() {
                          checkCart = false;
                          Serveices.deleteCart(
                              widget.user.userId, widget.product.productId);
                        });
                      }
                    });
                  })),
        ],
      ),
    );
  }
}

class Description extends StatelessWidget {
  final Product product;
  Description({this.product});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: ListTile(
            title: Text("Description:",
                style: TextStyle(color: Colors.black, fontSize: 20)),
            subtitle: Text(product.descreption,
                style: TextStyle(color: Colors.black, fontSize: 18)),
          ),
        ),
        Divider(
          color: Colors.black,
        ),
        Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0, 8.0, 4.0),
                    child: Text("Product Name:",
                        style: TextStyle(color: Colors.black, fontSize: 20)),
                  ),
                  Text(product.product_name,
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0, 8.0, 4.0),
                    child: Text("Product Brand:",
                        style: TextStyle(color: Colors.black, fontSize: 20)),
                  ),
                  Text(product.product_brand,
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0, 8.0, 4.0),
                    child: Text("Product Condition:",
                        style: TextStyle(color: Colors.black, fontSize: 20)),
                  ),
                  Text(product.product_condition,
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
