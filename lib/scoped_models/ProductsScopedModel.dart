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

	Product getProduct(int index) {
		return this.products[index];
	}

	void selectProduct(String productId) {
		selectedProductIndex = productId;
		if (selectedProductIndex != null) {
			notifyListeners();
		}
	}

	bool toggleProductFavouriteStatus(Product product) {
		final bool isCurrentlyFavourite = product.isFavourite;
		product.isFavourite = !isCurrentlyFavourite;
		http.put('https://first-flutter-app-9a199.firebaseio.com/products/${product.id}.json',
			body: json.encode(product.toJson()));
		notifyListeners();
		return !isCurrentlyFavourite;
	}

	bool toggleFavouriteMode() {
		this.isFavouriteFilterOn = !this.isFavouriteFilterOn;
		notifyListeners();
		selectedProductIndex = null;
		return this.isFavouriteFilterOn;
	}
}
