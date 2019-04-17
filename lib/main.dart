import 'package:first_flutter_app/pages/ProductAdmin.dart';
import 'package:first_flutter_app/pages/ProductsPage.dart';
import 'package:first_flutter_app/pages/auth.dart';
import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
//        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.blue
      ),
//      home: AuthPage(),
      routes: {
        '/': (context) => ProductsPage(),
        '/admin': (context) => ProductAdmin()
      },
    );
  }
}
