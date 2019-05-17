

import 'package:first_flutter_app/models/User.dart';
import 'package:first_flutter_app/models/product.dart';
import 'package:scoped_model/scoped_model.dart';

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
		product.url = 'assets/food.jpg';
		this._products.add(product);
	}
}