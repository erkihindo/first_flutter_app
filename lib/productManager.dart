import 'package:first_flutter_app/domain/image.dart';
import 'package:flutter/material.dart';
import './products.dart';


class ProductManager extends StatelessWidget {
  final List<CustomImage> products;

  ProductManager(this.products);

  @override
  Widget build(BuildContext context) {
    print('[ProductManager State] build()');
    return Column(
      children: [
        Expanded(child: Products(products))
      ],
    );
  }
}