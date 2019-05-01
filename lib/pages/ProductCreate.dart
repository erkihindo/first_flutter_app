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

  _ProductCreatePageState(this.addProduct);

  _buildInputTextField(String text, Function onChanged, int maxLines) {
    return TextField(maxLines: maxLines, decoration: InputDecoration(labelText: text), onChanged: onChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            this._buildInputTextField('Title', (newValue) {
              setState(() {
                title = newValue;
              });
            }, 1),
            this._buildInputTextField('Description', (newValue) {
              setState(() {
                description = newValue;
              });
            }, 4),
            TextField(
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(labelText: 'Price'),
              onChanged: (newValue) {
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
              onPressed: () {
                print(title);
                CustomImage newProduct = new CustomImage('assets/food.jpg', title, price, description);
                this.addProduct(newProduct);
              },
            )
          ],
        ));
  }
}
