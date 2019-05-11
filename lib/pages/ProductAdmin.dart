import 'package:first_flutter_app/models/product.dart';
import 'package:first_flutter_app/pages/ProductCreate.dart';
import 'package:first_flutter_app/pages/ProductEditPage.dart';
import 'package:first_flutter_app/pages/ProductList.dart';
import 'package:first_flutter_app/pages/ProductsPage.dart';
import 'package:flutter/material.dart';

class ProductAdmin extends StatelessWidget {
  final Function addProduct;
  final Function deleteProduct;
  final Function updateProduct;
  final List<Product> products;

  ProductAdmin(this.addProduct, this.updateProduct, this.deleteProduct, this.products);

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
          ProductEditPage(addProduct: this.addProduct),
          ProductListPage(products, this.updateProduct, deleteProduct)
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
