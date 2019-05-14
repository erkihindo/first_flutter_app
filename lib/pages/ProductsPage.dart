import 'package:first_flutter_app/scoped_models/ProductsScopedModel.dart';
import 'package:first_flutter_app/widgets/products/products.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductsPage extends StatelessWidget {
  ProductsScopeModel productsService;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsScopeModel>(builder:
        (BuildContext context, Widget child, ProductsScopeModel model) {
      this.productsService = model;
      return buildPageWithScaffold(context);
    });
  }

  Scaffold buildPageWithScaffold(BuildContext context) {
    return Scaffold(
        drawer: _buildDrawer(context),
        appBar: AppBar(
          title: Text('EasyListt'),
          actions: <Widget>[
            IconButton(
              icon: Icon(getFilledOrUnfilledFavIcon()),
              onPressed: () {
                productsService.toggleFavouriteMode();
              },
            )
          ],
        ),
        body: Products());
  }

  IconData getFilledOrUnfilledFavIcon() {
    return productsService.isFavouriteFilterOn
        ? Icons.favorite
        : Icons.favorite_border;
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
