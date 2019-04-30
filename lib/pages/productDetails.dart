import 'package:first_flutter_app/domain/image.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final CustomImage _product;

  ProductDetails(this._product);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              _product.title,
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Oswald'),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(_product.url),
              SizedBox(height: 10.0,),
              DecoratedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
                  child: Text("Somewhere TLN"),
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4.0)),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text("Details: ${_product.description}"),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text("Price: ${_product.price}"),
              ),
            ],
          )),
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
    );
  }
}
