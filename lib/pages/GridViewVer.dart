import 'package:e_commerce_app/Model/Product.dart';
import 'package:e_commerce_app/Model/Serveices.dart';
import 'package:e_commerce_app/Model/User.dart';
import 'package:e_commerce_app/Model/Utility.dart';
import 'package:e_commerce_app/pages/ProductDetails.dart';
import 'package:flutter/material.dart';

class GridViewVer extends StatelessWidget {
  final User user;
  GridViewVer({this.user});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
        future: Serveices.getProducts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Product> _product = snapshot.data;
            return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: _product.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Single_prod(product: _product[index], user: user);
                  }),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class Single_prod extends StatelessWidget {
  final Product product;
  final User user;
  Single_prod({this.product, this.user});

  @override
  Widget build(BuildContext context) {
    return new GridTile(
        footer: Container(
          color: Colors.white70,
          child: ListTile(
            leading: Text(
              product.product_name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            title: Text(
              "\$${product.price}",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
            ),
            subtitle: Text(
              "\$${product.price}",
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w800,
                  decoration: TextDecoration.lineThrough),
            ),
          ),
        ),
        child: MaterialButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductDetails(
                      product: product,
                      user: user,
                    )));
          },
          child: new Card(
              elevation: 1.0,
              child: new Center(
                child: Utility.imageFromBase64StringP(product.product_photoId),
              )),
        ));
  }
}
