import 'package:first_flutter_app/models/product.dart';
import 'package:first_flutter_app/helpers/EnsureVisible.dart';
import 'package:first_flutter_app/scoped_models/ProductsScopedModel.dart';
import 'package:first_flutter_app/scoped_models/mainScope.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  _ProductEditPageState();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScopeModel>(builder:
        (BuildContext context, Widget child, MainScopeModel model) {
      return model.selectedProductIndex != null
          ? editPageWithScaffold(model.selectedProduct)
          : editPage(new Product());
    });
  }

  void submitForm(
      Function addProduct, Function updateProduct, Product selectedProduct, Function selectProduct) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    if (selectedProduct.id == null) {
      addProduct(selectedProduct);
    } else {
      updateProduct(selectedProduct);
    }
    Navigator.pushReplacementNamed(context, '/products').then((_) => selectProduct(null));
  }

  Widget editPage(Product selectedProduct) {
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
                          initialValue: selectedProduct?.title,
                          validator: (String input) {
                            if (input.trim().length <= 2)
                              return 'Title should be at least 3 characters long';
                          },
                          onSaved: (String newValue) {
                              selectedProduct.title = newValue;
                          },
                        )),
                    EnsureVisibleWhenFocused(
                        focusNode: _descFocusNode,
                        child: TextFormField(
                          focusNode: _descFocusNode,
                          maxLines: 4,
                          decoration: InputDecoration(labelText: 'Description'),
                          initialValue: selectedProduct?.description,
                          validator: (String input) {
                            if (input.trim().length <= 4)
                              return 'Description should be at least 5 characters long';
                          },
                          onSaved: (String newValue) {
                              selectedProduct.description = newValue;
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
                          initialValue: selectedProduct?.price?.toString(),
                          onSaved: (String newValue) {
                              selectedProduct.price = double.parse(newValue);
                          },
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    buildSubmitButton(selectedProduct)
                  ],
                ))));
  }

  Widget buildSubmitButton(Product selectedProduct) {
    return ScopedModelDescendant<MainScopeModel>(builder:
        (BuildContext context, Widget child, MainScopeModel model) {
      return RaisedButton(
        color: Theme.of(context).accentColor,
        child: Text('Save'),
        onPressed: () => this
            .submitForm(model.addProduct, model.updateProduct, selectedProduct, model.selectProduct),
      );
    });
  }

  Widget editPageWithScaffold(Product product) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit product"),
        ),
        body: editPage(product));
  }
}
