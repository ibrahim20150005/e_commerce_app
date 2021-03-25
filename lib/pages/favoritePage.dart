import 'package:e_commerce_app/Model/Favorite.dart';
import 'package:e_commerce_app/Model/Product.dart';
import 'package:e_commerce_app/Model/Serveices.dart';
import 'package:e_commerce_app/Model/User.dart';
import 'package:e_commerce_app/Model/Utility.dart';
import 'package:e_commerce_app/pages/ProductDetails.dart';
import 'package:flutter/material.dart';

class FavoraitePage extends StatelessWidget {
  final User user;
  bool isFav;
  FavoraitePage({this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoraite Products"),
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
                    return FavoraiteProduct(
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

class FavoraiteProduct extends StatefulWidget {
  final Product product;

  final User user;

  FavoraiteProduct({this.product, this.user});
  @override
  _FavoraiteProductState createState() => _FavoraiteProductState();
}

class _FavoraiteProductState extends State<FavoraiteProduct> {
  bool checkFav;
  @override
  void initState() {
    CheckFav();
    super.initState();
  }

  CheckFav() {
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
  }

  @override
  Widget build(BuildContext context) {
    if (checkFav == true) {
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
                  CheckFav();
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
