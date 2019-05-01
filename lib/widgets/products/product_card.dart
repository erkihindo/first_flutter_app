import 'package:first_flutter_app/domain/image.dart';
import 'package:first_flutter_app/widgets/products/addressTag.dart';
import 'package:first_flutter_app/widgets/ui_elements/TitleDefault.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_app/pages/productDetails.dart';
import './price_tag.dart';

class ProductCard extends StatelessWidget {
 final CustomImage product;

  const ProductCard({this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset('assets/food.jpg'),
          Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TitleDefault(title: product.title,),
                    SizedBox(
                      width: 10.0,
                    ),
                    PriceTag(price: product.price.toString(),)
                  ])),
          AddressTag(address: "Somewhere TLN",),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.info),
                color: Theme.of(context).accentColor,
                onPressed: () => Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProductDetails(product)))
                    .then((bool value) {}),
              ),
              IconButton(
                icon: Icon(Icons.favorite_border),
                color: Colors.red,
                onPressed: () => Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProductDetails(product)))
                    .then((bool value) {}),
              )
            ],
          )
        ],
      ),
    );
  }

}