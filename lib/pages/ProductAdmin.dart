import 'package:first_flutter_app/pages/ProductCreate.dart';
import 'package:first_flutter_app/pages/ProductList.dart';
import 'package:first_flutter_app/pages/ProductsPage.dart';
import 'package:flutter/material.dart';

class ProductAdmin extends StatelessWidget {
  final Function addProduct;
  final Function deleteProduct;

  ProductAdmin(this.addProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text("Choose"),
              ),
              ListTile(
                title: Text("All products"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/");
                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("AdminPage"),
          bottom: TabBar(tabs: <Widget>[
            Tab(
              icon: Icon(Icons.check_circle_outline),
              text: "Create product",
            ),
            Tab(
              icon: Icon(Icons.map),
              text: "'My products",
            )
          ]),
        ),
        body: TabBarView(children: <Widget>[
          ProductCreatePage(addProduct: this.addProduct),
          ProductListPage()
        ]),
      ),
    );
  }
}
