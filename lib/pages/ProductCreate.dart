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

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              onChanged: (newValue) {
                setState(() {
                  title = newValue;
                });
              },
            ),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(labelText: 'Description'),
              onChanged: (newValue) {
                setState(() {
                  description = newValue;
                });
              },
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(labelText: 'Price'),
              onChanged: (newValue) {
                setState(() {
                  price = double.parse(newValue);
                });
              },
            ),
            SizedBox(height: 10.0,),
            RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text('Create'),
              onPressed: () {
                CustomImage newProduct = new CustomImage(
                    'assets/food.jpg', title, price, description);
                this.addProduct(newProduct);
              },
            )
          ],
        ));
  }
}
