import 'package:first_flutter_app/domain/image.dart';
import 'package:first_flutter_app/pages/productDetails.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<CustomImage> _products;
  final Function deleteProduct;

  Products(this._products, {this.deleteProduct});

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset('assets/food.jpg'),
          Text(_products[index].title),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text("Details"),
                onPressed: () => Navigator.push<bool>(context,
                    MaterialPageRoute(builder: (context) => ProductDetails(_products[index]))
                ).then((bool value) {
                  if (value) {
                    this.deleteProduct(index);
                  }
                }),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Center(child: Text("No products yet"));

    if (_products.isNotEmpty) {
      body = ListView.builder(
        itemBuilder: _buildProductItem,
        itemCount: _products.length,
      );
    }
    return body;
  }
}
