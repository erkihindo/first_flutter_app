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
			? products[selectedProductIndex]
			: null;
	}

	void updateProduct(Product productUpdate) {
		products[selectedProductIndex] = productUpdate;
		notifyListeners();
	}

	void deleteProduct(int selectedProductIndex) {
		this.products.removeAt(selectedProductIndex);
		notifyListeners();
	}

	void selectProduct(int index) {
		selectedProductIndex = index;
		if (selectedProductIndex != null) {
			notifyListeners();
		}
	}

	bool toggleProductFavouriteStatus(int indexId) {
		final bool isCurrentlyFavourite =
			products[selectedProductIndex].isFavourite;
		products[selectedProductIndex].isFavourite = !isCurrentlyFavourite;
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
