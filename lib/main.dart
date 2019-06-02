import 'package:first_flutter_app/pages/ProductAdmin.dart';
import 'package:first_flutter_app/pages/ProductsPage.dart';
import 'package:first_flutter_app/pages/auth.dart';
import 'package:first_flutter_app/scoped_models/mainScope.dart';
import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:scoped_model/scoped_model.dart';

main() {
//  debugPaintSizeEnabled = true;
	MapView.setApiKey('AIzaSyAY_8EoEsugfJPx9EVWlrBe9IYjCj3Au-Q');
	runApp(MyApp());
}

class MyApp extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return _MyAppState();
	}
}

class _MyAppState extends State<MyApp> {
	final MainScopeModel model = MainScopeModel();
	bool isAuthenticated = false;

	@override
	void initState() {
		model.autoAuthenticate();
		model.userSubject.listen((bool isAuthenticated) {
			setState(() {
			  this.isAuthenticated = isAuthenticated;
			});
		});
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		return ScopedModel<MainScopeModel>(
			model: model,
			child: MaterialApp(
				theme: ThemeData(
//        brightness: Brightness.dark,
					primarySwatch: Colors.deepPurple,
					accentColor: Colors.blue),
				routes: {
					'/': (BuildContext context) => this.isAuthenticated == false ? AuthPage(model: model,) : ProductsPage(mainScopeModel: model,),
					'/admin': (context) => this.isAuthenticated == false ? AuthPage(model: model,) : ProductAdminPage(model)
				},
			),
		);
	}
}
