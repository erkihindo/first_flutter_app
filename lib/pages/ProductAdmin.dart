import 'package:first_flutter_app/pages/ProductEditPage.dart';
import 'package:first_flutter_app/pages/ProductList.dart';
import 'package:flutter/material.dart';

class ProductAdmin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: buildDrawer(context),
        appBar: AppBar(
          title: Text("AdminPage"),
          bottom: TabBar(tabs: <Widget>[
            Tab(
              icon: Icon(Icons.check_circle_outline),
              text: "Edit product",
            ),
            Tab(
              icon: Icon(Icons.map),
              text: "'My products",
            )
          ]),
        ),
        body: TabBarView(children: <Widget>[
          ProductEditPage(),
          ProductListPage()
        ]),
      ),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text("Choose"),
            ),
            ListTile(
              leading: Icon(Icons.format_list_bulleted),
              title: Text("All products"),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/products");
              },
            )
          ],
        ),
      );
  }
}
