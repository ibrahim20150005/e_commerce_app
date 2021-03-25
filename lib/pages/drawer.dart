import 'package:e_commerce_app/Model/User.dart';
import 'package:e_commerce_app/pages/AdminPage.dart';
import 'package:e_commerce_app/pages/favoritePage.dart';
import 'package:flutter/material.dart';

class DrawerPage extends StatefulWidget {
  DrawerPage({Key key, this.user2}) : super(key: key);

  final User user2;

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(widget.user2.name),
            accountEmail: Text(widget.user2.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.home, color: Colors.red),
              title: Text("Home Page"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
              child: widget.user2.user_roleId == "1"
                  ? InkWell(
                      onTap: () {},
                      child: ListTile(
                        leading: Icon(Icons.person, color: Colors.red),
                        title: Text("Admin"),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) =>
                                      AdminPage(user3: widget.user2)))
                              .then((value) {});
                        },
                      ),
                    )
                  : Container(
                      height: 0,
                      width: 0,
                    )),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.shopping_bag, color: Colors.red),
              title: Text("My Orders"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.dashboard, color: Colors.red),
              title: Text("Categories"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              title: Text("Favorite"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FavoraitePage(user: widget.user2)));
              },
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.red,
              ),
              title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(
                Icons.help,
                color: Colors.green,
              ),
              title: Text("About"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
