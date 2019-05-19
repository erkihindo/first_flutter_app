import 'package:first_flutter_app/pages/productDetails.dart';
import 'package:first_flutter_app/scoped_models/ProductsScopedModel.dart';
import 'package:first_flutter_app/scoped_models/mainScope.dart';
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
      return ScopedModelDescendant<MainScopeModel>(
          builder: (BuildContext context, Widget child, MainScopeModel model)
      {
          this.productsService = model;
          return buildCard(context);
      });
  }

  Card buildCard(BuildContext context) {
    return Card(
    child: Column(
      children: <Widget>[
        Image.network(productsService.getProduct(productId).url),
        Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TitleDefault(title: productsService.getProduct(productId).title,),
                  SizedBox(
                    width: 10.0,
                  ),
                  PriceTag(price: productsService.getProduct(productId).price.toString(),)
                ])),
        AddressTag(address: "Somewhere TLN",),
        Text(productsService.getProduct(productId).userEmail),
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
                          ProductDetails( productsService.getProduct(productId))))
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
      return productsService.getProduct(productId).isFavourite ?
          Icons.favorite :
          Icons.favorite_border;
  }

}