import 'package:first_flutter_app/models/product.dart';
import 'package:first_flutter_app/scoped_models/ProductsScopedModel.dart';
import 'package:first_flutter_app/widgets/products/product_card.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsScopeModel>(
      builder: (BuildContext context, Widget child, ProductsScopeModel model) {
        return _buildProductsList(model.products);
      },
    );
  }

  Widget _buildProductsList(List<Product> products) {
    Widget body = Center(child: Text("No products yet"));

    if (products.isNotEmpty) {
      body = ListView.builder(
        itemBuilder: (context, index) => ProductCard(
              product: products[index],
            ),
        itemCount: products.length,
      );
    }
    return body;
  }
}
