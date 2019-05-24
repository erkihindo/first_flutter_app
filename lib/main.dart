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
	final MainScopeModel model = MainScopeModel();

	@override
	void initState() {
		model.autoAuthenticate();
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
//      home: AuthPage(),
				routes: {
					'/': (BuildContext context) =>
						ScopedModelDescendant(
							builder: (BuildContext context, Widget child, MainScopeModel model) {
								return model.authenticatedUser == null ? AuthPage(model: model,) : ProductsPage(mainScopeModel: model,);
							},
						),
					'/products': (context) => ProductsPage(mainScopeModel: model),
					'/admin': (context) => ProductAdminPage(model)
				},
			),
		);
	}
}
