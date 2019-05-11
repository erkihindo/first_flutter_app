import 'package:first_flutter_app/models/product.dart';
import 'package:first_flutter_app/helpers/EnsureVisible.dart';
import 'package:first_flutter_app/scoped_models/ProductsScopedModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductEditPage extends StatefulWidget {
  final Product product;
  final int productIndex;

  const ProductEditPage(
      {this.product, this.productIndex});

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
  final _titleFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  _ProductEditPageState();

  @override
  Widget build(BuildContext context) {
    return widget.product == null ? editPage() : editPageWithScaffold();
  }

  void submitForm(Function addProduct, Function updateProduct) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Product newProduct =
        new Product('assets/food.jpg', title, price, description);
    if (widget.product == null) {
      addProduct(newProduct);
    } else {
      updateProduct(widget.productIndex, newProduct);
    }
  }

  Widget editPage() {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550 ? 500 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
            margin: EdgeInsets.all(10.0),
            child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: targetPadding),
                  children: <Widget>[
                    EnsureVisibleWhenFocused(
                        focusNode: _titleFocusNode,
                        child: TextFormField(
                          focusNode: _titleFocusNode,
                          maxLines: 1,
                          decoration: InputDecoration(labelText: 'Title'),
                          initialValue: widget.product?.title,
                          validator: (String input) {
                            if (input.trim().length <= 2)
                              return 'Title should be at least 3 characters long';
                          },
                          onSaved: (String newValue) {
                            title = newValue;
                          },
                        )),
                    EnsureVisibleWhenFocused(
                        focusNode: _descFocusNode,
                        child: TextFormField(
                          focusNode: _descFocusNode,
                          maxLines: 4,
                          decoration: InputDecoration(labelText: 'Description'),
                          initialValue: widget.product?.description,
                          validator: (String input) {
                            if (input.trim().length <= 4)
                              return 'Description should be at least 5 characters long';
                          },
                          onSaved: (String newValue) {
                            description = newValue;
                          },
                        )),
                    EnsureVisibleWhenFocused(
                        focusNode: _priceFocusNode,
                        child: TextFormField(
                          focusNode: _priceFocusNode,
                          keyboardType: TextInputType.numberWithOptions(),
                          decoration: InputDecoration(labelText: 'Price'),
                          validator: (String input) {
                            if (input.isEmpty ||
                                !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$')
                                    .hasMatch(input))
                              return 'Price is required and should be a number';
                          },
                          initialValue: widget.product?.price?.toString(),
                          onSaved: (String newValue) {
                            price = double.parse(newValue);
                          },
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    buildSubmitButton()
                  ],
                ))));
  }

  Widget buildSubmitButton() {
    return ScopedModelDescendant<ProductsScopeModel>(
        builder: (BuildContext context, Widget child, ProductsScopeModel model) {
            return RaisedButton(
            color: Theme.of(context).accentColor,
            child: Text('Create'),
            onPressed: () => this.submitForm(model.addProduct, model.updateProduct),
        );
        }
    );
  }

  Widget editPageWithScaffold() {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit product"),
        ),
        body: editPage());
  }
}
