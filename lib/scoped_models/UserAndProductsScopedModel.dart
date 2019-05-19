import 'package:first_flutter_app/models/User.dart';
import 'package:first_flutter_app/models/product.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

mixin UserAndProductsScopedModel on Model {
	List<Product> products = [];
	User authenticatedUser;
	int selectedProductIndex;
	bool isLoading = false;

	List<Product> get allProducts {
		return List.from(products);
	}

	Future updateProduct(Product productUpdate) {
		startSpinner();
		products[selectedProductIndex] = productUpdate;
		return http.put('https://first-flutter-app-9a199.firebaseio.com/products/${productUpdate.id}.json',
			body: json.encode(productUpdate.toJson())
		).then((http.Response response) {
			stopSpinner();
		});
	}

	Future addProduct(Product product) {
		startSpinner();
		product.userEmail = authenticatedUser.email;
		product.userId = authenticatedUser.id;
		product.url =
		'https://www.france-export-fv.com/WebRoot/Orange/Shops/6449c484-4b17-11e1-a012-000d609a287c/5448/A3EA/0B6A/3BD0/1009/0A0C/05EA/5DDA/Chocolat.jpg';
		return http.post('https://first-flutter-app-9a199.firebaseio.com/products.json',
			body: json.encode(product.toJson())
		).then((http.Response response) {
			dynamic nameId = (json.decode(response.body)["name"]);
			product.id = nameId;
			this.products.add(product);
			stopSpinner();
		});
	}

	findAllProducts() {
		startSpinner();
		http.get('https://first-flutter-app-9a199.firebaseio.com/products.json')
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
				isFavourite: data["isFavourite"],
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

