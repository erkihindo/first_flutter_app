import 'package:first_flutter_app/domain/image.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final CustomImage _product;

  ProductDetails(this._product);

  _showDeleteAlert(context) {
    return showDialog(builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Are you sure?"),
        content: Text("This action cannot be undone"),
        actions: <Widget>[
          FlatButton(child: Text("Delete"), onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context, true);
          },),
          FlatButton(child: Text("Cancel"), onPressed: () {
            Navigator.pop(context);

          },)
        ],
      );
    }, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            title: Text(_product.title),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(_product.url),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text("Some details"),
              ),
              RaisedButton(
                color: Theme
                    .of(context)
                    .primaryColor,
                child: Text("DELETE"),
                onPressed: () => _showDeleteAlert(context),
              )
            ],
          )),
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
    );
  }
}
