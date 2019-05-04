import 'package:first_flutter_app/domain/image.dart';
import 'package:first_flutter_app/pages/ProductAdmin.dart';
import 'package:first_flutter_app/pages/ProductsPage.dart';
import 'package:first_flutter_app/pages/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

main() {
//  debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }

}

class _MyAppState extends State<MyApp> {

  List<CustomImage> _products = [];

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
    this._addProduct(new CustomImage('assets/food.jpg', 'Title', 1.0, 'desc'));
    return MaterialApp(
      theme: ThemeData(
//        brightness: Brightness.dark,
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.blue
      ),
//      home: AuthPage(),
      routes: {
        '/': (context) => AuthPage(),
        '/products': (context) => ProductsPage(_products),
        '/admin': (context) => ProductAdmin(_addProduct, _deleteProduct)
      },
    );
  }
}
