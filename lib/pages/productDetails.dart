import 'package:first_flutter_app/models/product.dart';
import 'package:first_flutter_app/widgets/products/ProductCardFloatingButton.dart';
import 'package:first_flutter_app/widgets/products/addressTag.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
	final Product _product;

	ProductDetails(this._product);

	@override
	Widget build(BuildContext context) {
		return WillPopScope(
			child: Scaffold(
//          appBar: AppBar(
//            title: TitleDefault(title: _product.title,),
//          ),
				body: CustomScrollView(slivers: <Widget>[
					SliverAppBar(
						expandedHeight: 256,
						pinned: true,
						flexibleSpace: FlexibleSpaceBar(
							title: Text(_product.title, style: TextStyle(color: Colors.black),),
							background: Hero(
								tag: _product.id,
								child: FadeInImage(
									height: 300.0,
									fit: BoxFit.cover,
									image: NetworkImage(_product.url),
									placeholder: AssetImage('assets/food.jpg'),),),
						),
					),
					SliverList(
						delegate: SliverChildListDelegate([
							AddressTag(address: "Somewhere TLN",),
							Container(
								padding: EdgeInsets.all(10.0),
								child: Text("Details: ${_product.description}"),
							),
							Container(
								padding: EdgeInsets.all(10.0),
								child: Text("Price: ${_product.price}"),
							)
						]),
					)
				],),
				floatingActionButton: ProductCardFloatingButton(product: _product),
			),
			onWillPop: () {
				Navigator.pop(context, false);
				return Future.value(false);
			},
		);
	}
}
