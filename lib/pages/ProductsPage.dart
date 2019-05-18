import 'package:first_flutter_app/scoped_models/ProductsScopedModel.dart';
import 'package:first_flutter_app/scoped_models/mainScope.dart';
import 'package:first_flutter_app/widgets/products/products.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductsPage extends StatefulWidget {
	final MainScopeModel mainScopeModel;

	const ProductsPage({Key key, this.mainScopeModel}) : super(key: key);

	@override
	State<StatefulWidget> createState() {
		return _ProductsPageState();
	}
}

class _ProductsPageState extends State<ProductsPage> {

	@override
	void initState() {
	widget.mainScopeModel.findAllProducts();
    super.initState();
  }
	@override
	Widget build(BuildContext context) {
		return ScopedModelDescendant<MainScopeModel>(
			builder: (BuildContext context, Widget child,
				MainScopeModel model) {
				return buildPageWithScaffold(context);
			});
	}

	Scaffold buildPageWithScaffold(BuildContext context) {
		return Scaffold(
			drawer: _buildDrawer(context),
			appBar: AppBar(
				title: Text('EasyListt'),
				actions: <Widget>[
					IconButton(
						icon: Icon(getFilledOrUnfilledFavIcon()),
						onPressed: () {
							widget.mainScopeModel.toggleFavouriteMode();
						},
					)
				],
			),
			body: Products());
	}

	IconData getFilledOrUnfilledFavIcon() {
		return widget.mainScopeModel.isFavouriteFilterOn
			? Icons.favorite
			: Icons.favorite_border;
	}

	Drawer _buildDrawer(BuildContext context) {
		return Drawer(
			child: Column(
				children: <Widget>[
					AppBar(
						automaticallyImplyLeading: false,
						title: Text("Choose"),
					),
					ListTile(
						leading: Icon(Icons.edit),
						title: Text("Manage products"),
						onTap: () {
							Navigator.pushReplacementNamed(context, '/admin');
						},
					)
				],
			),
		);
	}
}
