import 'package:e_commerce_app/Model/Category.dart';
import 'package:e_commerce_app/Model/Serveices.dart';
import 'package:e_commerce_app/Model/Utility.dart';
import 'package:e_commerce_app/pages/Products.dart';
import 'package:flutter/material.dart';

class ListViewHor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
        future: Serveices.getCategories(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Category> _category = snapshot.data;

            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _category.length,
                itemBuilder: (context, int index) {
                  return CategoryState(category: _category[index]);
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class CategoryState extends StatelessWidget {
  final Category category;

  CategoryState({this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductSim(category: category)));
        },
        child: Container(
          width: 100.0,
          child: ListTile(
              title: Utility.imageFromBase64String(category.category_photoId),
              subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  category.category_name,
                  style: new TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              )),
        ),
      ),
    );
  }
}
