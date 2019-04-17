import 'package:first_flutter_app/domain/image.dart';
import 'package:flutter/material.dart';

/// In charge of adding and deleting products
class ProductControl extends StatelessWidget {
  final Function addProduct;

  ProductControl(this.addProduct);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      child: Text('Add'),
      onPressed: () {
        addProduct(new CustomImage('assets/food.jpg', 'Chocolate'));
      }
    );
    }
}