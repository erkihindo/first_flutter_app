
import 'package:first_flutter_app/models/product.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductsScopeModel extends Model {
	List<Product> _products = [];
	int _selectedProductIndex;

	int get selectedProductIndex => _selectedProductIndex;

	List<Product> get products {
		return List.from(_products);
	}

	Product get selectedProduct {
		return _selectedProductIndex != null ?
		_products[_selectedProductIndex] :
		null;
	}

	void addProduct(Product product) {
		product.id = _products.length;
		product.url = 'assets/food.jpg';
		this._products.add(product);
		_selectedProductIndex = null;
	}

	void updateProduct(Product productUpdate) {
		_products[productUpdate.id] = productUpdate;
		_selectedProductIndex = null;
	}

	void deleteProduct(int selectedProductIndex) {
		this._products.removeAt(selectedProductIndex);
		selectedProductIndex = null;
	}

	void selectProduct(int index) {
		_selectedProductIndex = index;
	}
}