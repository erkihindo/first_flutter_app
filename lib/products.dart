import 'package:first_flutter_app/domain/image.dart';
import 'package:first_flutter_app/pages/productDetails.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<CustomImage> _products;

  Products(this._products);

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset('assets/food.jpg'),
          Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _products[index].title,
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Oswald'),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 2.5),
                        decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Text(
                          '€${_products[index].price.toString()}',
                          style: TextStyle(color: Colors.white),
                        ))
                  ])),
          DecoratedBox(
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5), child: Text("Somewhere TLN"),),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4.0)),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text("Details"),
                onPressed: () => Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductDetails(_products[index])))
                    .then((bool value) {}),
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
