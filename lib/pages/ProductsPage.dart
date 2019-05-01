import 'package:first_flutter_app/domain/image.dart';
import 'package:first_flutter_app/widgets/products/products.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  final List<CustomImage> products;

  ProductsPage(this.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _buildDrawer(context),
        appBar: AppBar(
          title: Text('EasyListt'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {},
            )
          ],
        ),
        body: Products(products));
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text("Choose"),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Manage products"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/admin');
              },
            )
          ],
        ),
      );
  }
}
