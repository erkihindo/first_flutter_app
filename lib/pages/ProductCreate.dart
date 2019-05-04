import 'package:first_flutter_app/domain/image.dart';
import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  const ProductCreatePage({this.addProduct});

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState(this.addProduct);
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String title = '';
  String description = '';
  double price = 0.0;
  final Function addProduct;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _ProductCreatePageState(this.addProduct);

  void submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    CustomImage newProduct =
        new CustomImage('assets/food.jpg', title, price, description);
    this.addProduct(newProduct);
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550 ? 500 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: targetPadding),
              children: <Widget>[
                TextFormField(
                  maxLines: 1,
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (String input) {
                    if (input.trim().length <= 2)
                      return 'Title should be at least 3 characters long';
                  },
                  onSaved: (String newValue) {
                    setState(() {
                      title = newValue;
                    });
                  },
                ),
                TextFormField(
                  maxLines: 4,
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (String input) {
                    if (input.trim().length <= 4)
                      return 'Description should be at least 5 characters long';
                  },
                  onSaved: (String newValue) {
                    setState(() {
                      description = newValue;
                    });
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(labelText: 'Price'),
                  validator: (String input) {
                    if (input.isEmpty ||
                        RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(input))
                      return 'Price is required and should be a number';
                  },
                  onSaved: (String newValue) {
                    setState(() {
                      price = double.parse(newValue);
                    });
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text('Create'),
                  onPressed: this.submitForm,
                )
              ],
            )));
  }
}
