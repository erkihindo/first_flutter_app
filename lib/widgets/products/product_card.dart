import 'package:first_flutter_app/helpers/custom_route.dart';
import 'package:first_flutter_app/models/product.dart';
import 'package:first_flutter_app/pages/productDetails.dart';
import 'package:first_flutter_app/scoped_models/ProductsScopedModel.dart';
import 'package:first_flutter_app/scoped_models/mainScope.dart';
import 'package:first_flutter_app/widgets/products/addressTag.dart';
import 'package:first_flutter_app/widgets/ui_elements/TitleDefault.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './price_tag.dart';

class ProductCard extends StatelessWidget {
    final Product product;
    ProductsScopeModel productsService;

    ProductCard({this.product});

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
        Hero(
	        tag: product.id,
	        child: FadeInImage(
	        height: 300.0,
	        fit: BoxFit.cover,
	        image: NetworkImage(product.url),
	        placeholder: AssetImage('assets/food.jpg'),),),
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
	              CustomRoute(
                      builder: (context) =>
                          ProductDetails(product)))
                  .then((bool value) {}),
            ),
            IconButton(
              icon: Icon(getFilledOrUnfilledFavIcon()),
              color: Colors.red,
              onPressed: () {
                  productsService.toggleProductFavouriteStatus(product);
              },
            )
          ],
        )
      ],
    ),
  );
  }

  IconData getFilledOrUnfilledFavIcon() {
      return product.isFavourite ?
          Icons.favorite :
          Icons.favorite_border;
  }

}