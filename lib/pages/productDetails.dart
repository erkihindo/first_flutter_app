import 'package:first_flutter_app/models/product.dart';
import 'package:first_flutter_app/widgets/products/addressTag.dart';
import 'package:first_flutter_app/widgets/ui_elements/TitleDefault.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final Product _product;

  ProductDetails(this._product);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            title: TitleDefault(title: _product.title,),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.network(_product.url),
              SizedBox(height: 10.0,),
              AddressTag(address: "Somewhere TLN",),
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
