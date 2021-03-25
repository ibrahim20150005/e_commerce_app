import 'package:e_commerce_app/Model/Category.dart';
import 'package:e_commerce_app/Model/Serveices.dart';
import 'package:e_commerce_app/Model/User.dart';
import 'package:e_commerce_app/Model/Utility.dart';
import 'package:e_commerce_app/pages/MyHomePage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class AddCategory extends StatefulWidget {
  AddCategory({Key key, this.user4}) : super(key: key);
  final User user4;
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final _formKey = GlobalKey<FormState>();
  String imgString;
  bool result = false;
  final categoryNameControl = TextEditingController();

  pickImageFromGallery(ImageSource source) {
    ImagePicker.pickImage(source: source).then((imgFile) {
      setState(() {
        imgString = Utility.base64String(imgFile.readAsBytesSync());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Add Categorry"),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              actions: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {
                        if (categoryNameControl.text.isNotEmpty &&
                            imgString != null) {
                          /*  Category category = Category.constructor(
                              categoryNameControl.text, "");*/
                          Category category = Category.constructor(
                              categoryNameControl.text, imgString);
                          Serveices.insertCategory(category).then((value) {
                            if (value == true) {
                              Toast.show("successful save a data", context,
                                  backgroundColor: Colors.black,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MyHomePage(
                                        user1: widget.user4,
                                      )));
                            } else {
                              Toast.show(
                                  "${categoryNameControl.text} already exit",
                                  context,
                                  backgroundColor: Colors.black,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            }
                            return true;
                          });
                        } else {
                          if (categoryNameControl.text.isEmpty) {
                            Toast.show("Enter the name of category", context,
                                backgroundColor: Colors.black,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                          } else {
                            Toast.show("Enter the photo", context,
                                backgroundColor: Colors.black,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                          }
                        }
                      },
                    ))
              ],
            ),
            body: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: categoryNameControl,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.category),
                            labelText: 'Name :',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter the Name of Category';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          child: imgString == null
                              ? Container(
                                  height: 0,
                                  width: 0,
                                )
                              : Stack(
                                  children: [
                                    Utility.imageFromBase64String(imgString),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.red,
                                            size: 40,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              imgString = null;
                                            });
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(25),
                        child: MaterialButton(
                          child: Text(
                            'Add Photo',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          color: Colors.red,
                          textColor: Colors.white,
                          onPressed: () {
                            pickImageFromGallery(ImageSource.gallery);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}

/* ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Save Data'))); */
