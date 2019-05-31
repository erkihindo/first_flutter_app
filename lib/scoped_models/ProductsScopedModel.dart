import 'package:first_flutter_app/models/product.dart';
import 'package:first_flutter_app/scoped_models/UserAndProductsScopedModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

mixin ProductsScopeModel on UserAndProductsScopedModel {
	bool isFavouriteFilterOn = false;

	List<Product> get productsByFavourite {
		if (!isFavouriteFilterOn) return products;

		return List.from(products.where((Product p) => p.isFavourite).toList());
	}

	Product get selectedProduct {
		return selectedProductIndex != null
			? products.firstWhere((p) {
			return p.id == selectedProductIndex;
		}) : null;
	}

	Future<bool> addProduct(Product product) async {
		startSpinner();
		product.userEmail = authenticatedUser.email;
		product.userId = authenticatedUser.id;
		product.url =
		'https://www.france-export-fv.com/WebRoot/Orange/Shops/6449c484-4b17-11e1-a012-000d609a287c/5448/A3EA/0B6A/3BD0/1009/0A0C/05EA/5DDA/Chocolat.jpg';
		http.Response response = await http.post('https://first-flutter-app-9a199.firebaseio.com/products.json',
			body: json.encode(product.toJson())
		);
		stopSpinner();
		if (response.statusCode != 200 && response.statusCode != 201) {
			return false;
		}
		dynamic nameId = (json.decode(response.body)["name"]);
		product.id = nameId;
		this.products.add(product);
		return true;
	}

	Product getProduct(int index) {
		return this.products[index];
	}

	void selectProduct(String productId) {
		selectedProductIndex = productId;
		if (selectedProductIndex != null) {
			notifyListeners();
		}
	}

	void toggleProductFavouriteStatus(Product product) async {
		final bool isCurrentlyFavourite = product.isFavourite;
		product.isFavourite = !isCurrentlyFavourite;
		if (product.isFavourite) {
			http.put('https://first-flutter-app-9a199.firebaseio.com/products/${product.id}/likes/${authenticatedUser.id}.json?auth=${this
				.authenticatedUser.token}',
				body: json.encode(true));
		} else {
			await http.delete(
				'https://first-flutter-app-9a199.firebaseio.com/products/${product.id}/likes/${authenticatedUser.id}.json?auth='
					'${this.authenticatedUser.token}');
		}

		notifyListeners();
	}

	bool toggleFavouriteMode() {
		this.isFavouriteFilterOn = !this.isFavouriteFilterOn;
		notifyListeners();
		selectedProductIndex = null;
		return this.isFavouriteFilterOn;
	}
}
