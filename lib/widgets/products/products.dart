import 'package:first_flutter_app/models/product.dart';
import 'package:first_flutter_app/scoped_models/mainScope.dart';
import 'package:first_flutter_app/widgets/products/product_card.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductsOrSpinner extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return ScopedModelDescendant<MainScopeModel>(
			builder: (BuildContext context, Widget child, MainScopeModel model) {
				Widget content = Center(child: CircularProgressIndicator(),);
				if (!model.isLoading) {
					content = _buildProductsList(model.productsByFavourite);
				}
				return RefreshIndicator(child: content,
					onRefresh: model.findAllProducts,
				);
			},
		);
	}

	Widget _buildProductsList(List<Product> products) {
		Widget body = Center(child: Text("No products yet"));

		if (products.isNotEmpty) {
			body = ListView.builder(
				itemBuilder: (context, index) =>
					ProductCard(
						product: products[index],
					),
				itemCount: products.length,
			);
		}
		return body;
	}
}
