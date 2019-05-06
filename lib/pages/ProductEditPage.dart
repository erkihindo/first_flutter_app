import 'package:first_flutter_app/domain/image.dart';
import 'package:flutter/material.dart';

class ProductEditPage extends StatefulWidget {
	final Function addProduct;
	final Function updateProduct;
	final CustomImage product;
	final int productIndex;

	const ProductEditPage({this.product, this.addProduct, this.updateProduct, this.productIndex});

	@override
	State<StatefulWidget> createState() {
		return _ProductEditPageState();
	}
}

class _ProductEditPageState extends State<ProductEditPage> {
	String title = '';
	String description = '';
	double price = 0.0;
	final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

	_ProductEditPageState();

	void submitForm() {
		if (!_formKey.currentState.validate()) {
			return;
		}
		_formKey.currentState.save();
		CustomImage newProduct =
		new CustomImage('assets/food.jpg', title, price, description);
		if (widget.product == null) {
			widget.addProduct(newProduct);
		} else {
			widget.updateProduct(widget.productIndex, newProduct);
		}

	}

	@override
	Widget build(BuildContext context) {
		final double deviceWidth = MediaQuery
			.of(context)
			.size
			.width;
		final double targetWidth = deviceWidth > 550 ? 500 : deviceWidth * 0.95;
		final double targetPadding = deviceWidth - targetWidth;

		Widget editPage() {
			return GestureDetector(
				onTap: () {
					FocusScope.of(context).requestFocus(FocusNode());
				},
				child: Container(
					margin: EdgeInsets.all(10.0),
					child: Form(
						key: _formKey,
						child: ListView(
							padding: EdgeInsets.symmetric(
								horizontal: targetPadding),
							children: <Widget>[
								TextFormField(
									maxLines: 1,
									decoration: InputDecoration(
										labelText: 'Title'),
									initialValue: widget.product?.title,
									validator: (String input) {
										if (input
											.trim()
											.length <= 2)
											return 'Title should be at least 3 characters long';
									},
									onSaved: (String newValue) {
										title = newValue;
									},
								),
								TextFormField(
									maxLines: 4,
									decoration: InputDecoration(
										labelText: 'Description'),
									initialValue: widget.product?.description,
									validator: (String input) {
										if (input
											.trim()
											.length <= 4)
											return 'Description should be at least 5 characters long';
									},
									onSaved: (String newValue) {
										description = newValue;
									},
								),
								TextFormField(
									keyboardType: TextInputType
										.numberWithOptions(),
									decoration: InputDecoration(
										labelText: 'Price'),
									validator: (String input) {
										if (input.isEmpty ||
											!RegExp(
												r'^(?:[1-9]\d*|0)?(?:\.\d+)?$')
												.hasMatch(input))
											return 'Price is required and should be a number';
									},
									initialValue: widget.product?.price?.toString(),
									onSaved: (String newValue) {
										price = double.parse(newValue);
									},
								),
								SizedBox(
									height: 10.0,
								),
								RaisedButton(
									color: Theme
										.of(context)
										.accentColor,
									child: Text('Create'),
									onPressed: this.submitForm,
								)
							],
						))));
		}

		return widget.product == null ?
		editPage() :
		Scaffold(
			appBar: AppBar(title: Text("Edit product"),),
			body: editPage()
		);
	}
}
