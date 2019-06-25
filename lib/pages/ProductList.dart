import 'package:first_flutter_app/helpers/custom_route.dart';
import 'package:first_flutter_app/pages/ProductEditPage.dart';
import 'package:first_flutter_app/scoped_models/ProductsScopedModel.dart';
import 'package:first_flutter_app/scoped_models/mainScope.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatefulWidget {
	final MainScopeModel model;

	const ProductListPage(this.model);

	@override
	State<StatefulWidget> createState() {
		return ProductListPageState();
	}
}

class ProductListPageState extends State<ProductListPage> {
	ProductsScopeModel productsService;

	@override
	void initState() {
		widget.model.findAllProducts(onlyForUser: true);
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		return ScopedModelDescendant<MainScopeModel>(
			builder: (BuildContext context, Widget child, MainScopeModel model) {
				this.productsService = model;
				return buildListViewOfAllProducts();
			});
	}

	ListView buildListViewOfAllProducts() {
		return ListView.builder(
			itemBuilder: (context, int index) {
				return Dismissible(
					key: Key(productsService.getProduct(index).title),
					onDismissed: (DismissDirection direction) {
						if (direction == DismissDirection.startToEnd) {
							productsService.deleteProduct(index);
						}
					},
					background: Container(
						color: Colors.red,
						child: Icon(Icons.delete),
					),
					child: Column(
						children: <Widget>[buildListTile(index, context), Divider()],
					),
				);
			},
			itemCount: productsService.products.length,
		);
	}

	ListTile buildListTile(int index, BuildContext context) {
		return ListTile(
			leading: CircleAvatar(
				backgroundImage: NetworkImage(productsService.products[index].url),
			),
			title: Text(productsService.products[index].title),
			subtitle: Text('€${productsService.products[index].price}'),
			trailing: ScopedModelDescendant<MainScopeModel>(
				builder:
					(BuildContext context, Widget child, MainScopeModel model) {
					return IconButton(
						icon: Icon(Icons.edit),
						onPressed: () {
							model.selectProduct(productsService.products[index].id);
							Navigator.of(context)
								.push(CustomRoute(builder: (context) {
								return ProductEditPage();
							})).then((_) {
								productsService.selectProduct(null);
							});
						});
				},
			));
	}
}
