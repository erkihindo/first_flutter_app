import 'package:first_flutter_app/domain/image.dart';
import 'package:first_flutter_app/widgets/products/product_card.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<CustomImage> _products;

  Products(this._products);
  @override
  Widget build(BuildContext context) {
    Widget body = Center(child: Text("No products yet"));

    if (_products.isNotEmpty) {
      body = ListView.builder(
        itemBuilder: (context, index) => ProductCard(product: _products[index],),
        itemCount: _products.length,
      );
    }
    return body;
  }
}
