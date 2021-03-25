import 'package:e_commerce_app/Model/Cart.dart';

import 'package:e_commerce_app/Model/Product.dart';
import 'package:e_commerce_app/Model/Serveices.dart';
import 'package:e_commerce_app/Model/User.dart';
import 'package:e_commerce_app/Model/Utility.dart';
import 'package:e_commerce_app/pages/ProductDetails.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final User user;
  bool iscart;
  CartPage({this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Products"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: FutureBuilder<List<Product>>(
          future: Serveices.getProducts(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<Product> _product = snapshot.data;

              return ListView.builder(
                  itemCount: _product.length,
                  itemBuilder: (context, int index) {
                    return CartProduct(
                      user: user,
                      product: _product[index],
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class CartProduct extends StatefulWidget {
  final Product product;

  final User user;

  CartProduct({this.product, this.user});
  @override
  _CartProductState createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  bool checkCart;
  @override
  void initState() {
    CheckCart();
    super.initState();
  }

  CheckCart() {
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
  }

  @override
  Widget build(BuildContext context) {
    if (checkCart == true) {
      return Card(
        elevation: 5.0,
        child: Material(
          child: InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (context) => ProductDetails(
                            product: widget.product,
                            user: widget.user,
                          )))
                  .then((value) {
                setState(() {
                  CheckCart();
                });
              });
            },
            child: ListTile(
                leading: Utility.imageFromBase64StringF(
                    widget.product.product_photoId),
                title: Text(
                  widget.product.product_name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "\$${widget.product.price}",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
                ),
                trailing: IconButton(
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
          ),
        ),
      );
    } else {
      return Container(
        height: 0,
        width: 0,
      );
    }
  }
}
