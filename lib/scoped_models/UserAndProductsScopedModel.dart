import 'package:first_flutter_app/models/User.dart';
import 'package:first_flutter_app/models/product.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

mixin UserAndProductsScopedModel on Model {
	List<Product> products = [];
	User authenticatedUser;
	String selectedProductIndex;
	bool isLoading = false;

	Future updateProduct(Product productUpdate) {
		startSpinner();
		return http.put('https://first-flutter-app-9a199.firebaseio.com/products/${productUpdate.id}.json?auth=${this.authenticatedUser.token}',
			body: json.encode(productUpdate.toJson())
		).then((http.Response response) {
			stopSpinner();
		});
	}

	void deleteProduct(int index) {
		this.startSpinner();
		this.selectedProductIndex = null;
		Product product = this.products[index];
		this.products.removeAt(index);
		http.delete('https://first-flutter-app-9a199.firebaseio.com/products/${product.id}.json?auth=${this.authenticatedUser.token}')
			.then((http.Response response) {
			this.stopSpinner();
		});
	}

	Future findAllProducts() {
		startSpinner();
		return http.get('https://first-flutter-app-9a199.firebaseio.com/products.json?auth=${this.authenticatedUser.token}')
			.then((http.Response response) {
			dynamic productsFromServer = json.decode(response.body);
			mapServerProductsToProductsDto(productsFromServer);
			print(products);
			stopSpinner();
		});
	}

	void mapServerProductsToProductsDto(productsFromServer) {
		if (productsFromServer == null) return;
		List<Product> fetchedProducts = [];
		productsFromServer.forEach((String key, dynamic data) {
			Product productDto = new Product(
				id: key,
				title: data["title"],
				description: data["description"],
				url: data["url"],
				price: data["price"],
				userEmail: data["userEmail"],
				userId: data["userId"],
				isFavourite: data["likes"] == null ? false : (data["likes"] as Map<String, dynamic>).containsKey(this.authenticatedUser.id),
			);
			fetchedProducts.add(productDto);
		});
		products = fetchedProducts;
	}

	void stopSpinner() {
		this.isLoading = false;
		notifyListeners();
	}

	void startSpinner() {
		isLoading = true;
		notifyListeners();
	}
}

