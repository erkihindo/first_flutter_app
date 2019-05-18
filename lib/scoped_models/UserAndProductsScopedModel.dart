

import 'dart:convert';

import 'package:first_flutter_app/models/User.dart';
import 'package:first_flutter_app/models/product.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

mixin UserAndProductsScopedModel on Model {
	List<Product> _products = [];
	User authenticatedUser;
	int selectedProductIndex;

	List<Product> get products {
		return List.from(_products);
	}

	void addProduct(Product product) {
		product.userEmail = authenticatedUser.email;
		product.userId = authenticatedUser.id;
		product.id = _products.length;
		product.url = 'https://www.france-export-fv.com/WebRoot/Orange/Shops/6449c484-4b17-11e1-a012-000d609a287c/5448/A3EA/0B6A/3BD0/1009/0A0C/05EA/5DDA/Chocolat.jpg';
		http.post('https://first-flutter-app-9a199.firebaseio.com/products.json',
			body: jsonEncode(product.toJson())
		).then((response) {
			print(response);
		});
		this._products.add(product);
	}
}