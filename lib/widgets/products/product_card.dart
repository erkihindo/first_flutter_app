import 'package:first_flutter_app/pages/productDetails.dart';
import 'package:first_flutter_app/scoped_models/ProductsScopedModel.dart';
import 'package:first_flutter_app/widgets/products/addressTag.dart';
import 'package:first_flutter_app/widgets/ui_elements/TitleDefault.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './price_tag.dart';

class ProductCard extends StatelessWidget {
    final num productId;
    ProductsScopeModel productsService;

    ProductCard({this.productId});

  @override
  Widget build(BuildContext context) {
      return ScopedModelDescendant<ProductsScopeModel>(
          builder: (BuildContext context, Widget child, ProductsScopeModel model)
      {
          this.productsService = model;
          this.productsService.selectProduct(productId);
          return buildCard(context);
      });
  }

  Card buildCard(BuildContext context) {
    return Card(
    child: Column(
      children: <Widget>[
        Image.asset('assets/food.jpg'),
        Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TitleDefault(title: productsService.selectedProduct.title,),
                  SizedBox(
                    width: 10.0,
                  ),
                  PriceTag(price:  productsService.selectedProduct.price.toString(),)
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
                          ProductDetails( productsService.selectedProduct)))
                  .then((bool value) {}),
            ),
            IconButton(
              icon: Icon(getFilledOrUnfilledFavIcon()),
              color: Colors.red,
              onPressed: () {
                  productsService.toggleProductFavouriteStatus(productId);
              },
            )
          ],
        )
      ],
    ),
  );
  }

  IconData getFilledOrUnfilledFavIcon() {
      return productsService.selectedProduct.isFavourite ?
          Icons.favorite :
          Icons.favorite_border;
  }

}