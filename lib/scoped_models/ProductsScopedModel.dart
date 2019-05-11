
import 'package:first_flutter_app/models/product.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductsScopeModel extends Model {
	List<Product> _products = [];

	List<Product> get products {
		return List.from(_products);
	}

	void addProduct(Product product) {
		this._products.add(product);
	}

	void updateProduct(int index, Product productUpdate) {
		_products[index] = productUpdate;
	}

	void deleteProduct(int index) {
			this._products.removeAt(index);
	}
}