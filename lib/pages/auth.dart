import 'package:first_flutter_app/pages/ProductsPage.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Please login'),
        ),
        body: Center(
          child: RaisedButton(
              child: Text("Login"),
              onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ProductsPage()));
          }),
        ));
    ;
  }
}
