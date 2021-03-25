import 'package:e_commerce_app/Model/Category.dart';
import 'package:e_commerce_app/Model/Product.dart';
import 'package:e_commerce_app/Model/Serveices.dart';
import 'package:e_commerce_app/Model/Utility.dart';
import 'package:e_commerce_app/pages/ProductDetails.dart';
import 'package:flutter/material.dart';

class ProductSim extends StatelessWidget {
  final Category category;
  ProductSim({this.category});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.category_name),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: FutureBuilder<List<Product>>(
          future: Serveices.getSimilarProducts(category.categoryId),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<Product> _product = snapshot.data;

              return GridView.builder(
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: _product.length,
                  itemBuilder: (context, int index) {
                    return Single_product(
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

class Single_product extends StatelessWidget {
  final Product product;
  Single_product({this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Material(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductDetails(
                      product: product,
                    )));
          },
          child: GridTile(
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    product.product_name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  title: Text(
                    "\$${product.price}",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w800),
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
              child: Utility.imageFromBase64StringP(product.product_photoId)),
        ),
      ),
    );
  }
}
