import 'package:first_flutter_app/models/product.dart';
import 'package:first_flutter_app/scoped_models/ProductsScopedModel.dart';
import 'package:first_flutter_app/scoped_models/mainScope.dart';
import 'package:first_flutter_app/widgets/products/product_card.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScopeModel>(
      builder: (BuildContext context, Widget child, MainScopeModel model) {
        if (model.products.isEmpty) {
          model.addProduct(new Product(
              url: 'assets/food.jpg',
              title: 'Title',
              price: 1.0,
              description: 'desc'));
        }

        return _buildProductsList(model.productsByFavourite);
      },
    );
  }

  Widget _buildProductsList(List<Product> products) {
    Widget body = Center(child: Text("No products yet"));

    if (products.isNotEmpty) {
      body = ListView.builder(
        itemBuilder: (context, index) => ProductCard(
              productId: products[index].id,
            ),
        itemCount: products.length,
      );
    }
    return body;
  }
}
