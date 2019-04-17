import 'package:first_flutter_app/domain/image.dart';
import 'package:flutter/material.dart';
import './products.dart';
import './productControl.dart';

class ProductManager extends StatefulWidget {
  final CustomImage startingProduct;

  ProductManager({this.startingProduct});

  @override
  State<StatefulWidget> createState() {
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List<CustomImage> _products = [];

  @override
  void initState() {
    super.initState();
    if (widget.startingProduct != null) {
      _products.add(widget.startingProduct);
    }
  }

  void _addProduct(CustomImage product) {
    setState(() {
      this._products.add(product);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      this._products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          child: ProductControl(this._addProduct),
        ),
        Expanded(child: Products(_products, deleteProduct: this._deleteProduct))
      ],
    );
  }
}
