import 'package:first_flutter_app/pages/ProductAdmin.dart';
import 'package:first_flutter_app/pages/ProductsPage.dart';
import 'package:first_flutter_app/pages/auth.dart';
import 'package:first_flutter_app/scoped_models/mainScope.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

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
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainScopeModel>(
      model: MainScopeModel(),
      child: MaterialApp(
        theme: ThemeData(
//        brightness: Brightness.dark,
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.blue),
//      home: AuthPage(),
        routes: {
          '/': (context) => AuthPage(),
          '/products': (context) => ProductsPage(),
          '/admin': (context) => ProductAdmin()
        },
      ),
    );
  }
}
