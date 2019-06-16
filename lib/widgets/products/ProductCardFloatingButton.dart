import 'package:first_flutter_app/models/product.dart';
import 'package:first_flutter_app/scoped_models/mainScope.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:math' as math;
class ProductCardFloatingButton extends StatefulWidget {

	final Product product;

	const ProductCardFloatingButton({Key key, this.product}) : super(key: key);

	@override
	State<StatefulWidget> createState() {
		return _ProductCardFloatingButtonState();
	}
}

class _ProductCardFloatingButtonState extends State<ProductCardFloatingButton> with TickerProviderStateMixin {
	MainScopeModel productsService;
	AnimationController _controller;

	@override
	void initState() {
		_controller = new AnimationController(vsync: this, duration: Duration(milliseconds: 200));
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		return ScopedModelDescendant<MainScopeModel>(
			builder: (BuildContext context, Widget child, MainScopeModel model) {
				this.productsService = model;
				return buildFloatingButtons(context);
			});
	}

	Column buildFloatingButtons(BuildContext context) {
		return Column(
			mainAxisSize: MainAxisSize.min,
			children: <Widget>[

				Container(
					height: 70,
					width: 56,
					alignment: FractionalOffset.topCenter,
					child: ScaleTransition(
						scale: CurvedAnimation(parent: _controller, curve: Interval(0.3, 1.0, curve: Curves.easeOut)),
						child: FloatingActionButton(
							heroTag: 'contact',
							backgroundColor: Theme
								.of(context)
								.cardColor,
							onPressed: () {
								print("asdasda");
							},
							mini: true,
							child: Icon(Icons.mail, color: Theme
								.of(context)
								.primaryColor,),),),),

				Container(
					height: 70,
					width: 56,
					alignment: FractionalOffset.topCenter,
					child: ScaleTransition(
						scale: CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.5, curve: Curves.easeOut)),
						child: FloatingActionButton(
							heroTag: 'favourite',
							backgroundColor: Theme
								.of(context)
								.cardColor,
							onPressed: () {
								productsService.toggleProductFavouriteStatus(widget.product);
							},
							mini: true,
							child: Icon(Icons.favorite, color: Colors.redAccent,),),)),

				Container(
					child: FloatingActionButton(
						heroTag: 'parent',
						onPressed: () {
							print("asdasda");
							if (_controller.isDismissed) {
								_controller.forward();
							} else {
								_controller.reverse();
							}
						},
						child: AnimatedBuilder(
							animation: _controller,
							builder: (context, child) {
								return Transform(
									alignment: FractionalOffset.center,
									transform: Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
									child: Icon(_controller.isDismissed ? Icons.more_vert : Icons.arrow_forward_ios)
									,);
							}),),),

			],);
	}

}