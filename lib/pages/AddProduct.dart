import 'package:e_commerce_app/Model/Category.dart';
import 'package:e_commerce_app/Model/Product.dart';
import 'package:e_commerce_app/Model/Serveices.dart';
import 'package:e_commerce_app/Model/User.dart';
import 'package:e_commerce_app/Model/Utility.dart';
import 'package:e_commerce_app/pages/MyHomePage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class AddPoduct extends StatefulWidget {
  AddPoduct({Key key, this.user5}) : super(key: key);
  final User user5;
  @override
  _AddPoductState createState() => _AddPoductState();
}

class _AddPoductState extends State<AddPoduct> {
  final _formKey = GlobalKey<FormState>();
  String dropdownSize = 'small';
  String dropdownCondetion = 'New';
  Category dropdownCategory;
  List<Category> category;
  List<DropdownMenuItem<Category>> _dropdownMenuItems;

  final productNameControl = TextEditingController();
  final descreptionControl = TextEditingController();
  final colorControl = TextEditingController();
  final productBrandControl = TextEditingController();
  final priceControl = TextEditingController();
  String imgString;
  @override
  void initState() {
    GetCategories();

    super.initState();
  }

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
              title: Text("Add Product"),
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
                        if (productNameControl.text.isNotEmpty &&
                            descreptionControl.text.isNotEmpty &&
                            colorControl.text.isNotEmpty &&
                            productBrandControl.text.isNotEmpty &&
                            priceControl.text.isNotEmpty &&
                            dropdownCategory != null &&
                            imgString != null) {
                          Product product = Product.constructor(
                              productNameControl.text,
                              descreptionControl.text.toString(),
                              dropdownSize,
                              colorControl.text,
                              productBrandControl.text,
                              dropdownCondetion,
                              priceControl.text,
                              dropdownCategory.categoryId,
                              imgString);
                          Serveices.insertProduct(product);
                          Toast.show("successful save a data", context,
                              backgroundColor: Colors.black,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM);
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                    user1: widget.user5,
                                  )));
                        } else {
                          Toast.show("there is data Missing", context,
                              backgroundColor: Colors.black,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM);
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
                          controller: productNameControl,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.design_services),
                            labelText: ' Product Name :',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter the Name of Product';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          minLines: 2,
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          controller: descreptionControl,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.description_rounded),
                            labelText: 'Description :',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter the Description';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(flex: 1, child: Text("Chiose Size: ")),
                              Expanded(
                                flex: 3,
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: dropdownSize,
                                  icon: const Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.grey,
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      dropdownSize = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'small',
                                    'Large',
                                    'x Large',
                                    'xx Large'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: colorControl,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.color_lens_outlined),
                            labelText: 'color :',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter the color';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: productBrandControl,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.branding_watermark),
                            labelText: 'product brand :',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter the product brand';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 1, child: Text("Enter Condtion: ")),
                              Expanded(
                                flex: 3,
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: dropdownCondetion,
                                  icon: const Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.grey,
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      dropdownCondetion = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'New',
                                    'Old',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: priceControl,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.money_sharp),
                            labelText: 'price :',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter the price';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 1, child: Text("Choise Category: ")),
                              Expanded(
                                flex: 3,
                                child: DropdownButton(
                                  style: const TextStyle(color: Colors.black),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.grey,
                                  ),
                                  isExpanded: true,
                                  icon: const Icon(Icons.arrow_downward),
                                  value: dropdownCategory,
                                  items: _dropdownMenuItems,
                                  onChanged: onChangeDropdownItem,
                                ),
                              ),
                            ],
                          )),
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
                            'Add Photo For Product',
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

  GetCategories() async {
    category = await Serveices.getCategories();
    print(category);
    // itemCategories = List(category.length);

    for (int i = 0; i < category.length; i++) {
      onChangeDropdownItem(category[i]);
    }
    _dropdownMenuItems = buildDropdownMenuItems(category);
  }

  List<DropdownMenuItem<Category>> buildDropdownMenuItems(List category) {
    List<DropdownMenuItem<Category>> items = List();
    for (Category cate in category) {
      items.add(
        DropdownMenuItem(
          value: cate,
          child: Text(cate.category_name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Category selectedCompany) {
    setState(() {
      dropdownCategory = selectedCompany;
    });
  }
}
