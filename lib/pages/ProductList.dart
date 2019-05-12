import 'package:first_flutter_app/models/product.dart';
import 'package:first_flutter_app/pages/ProductEditPage.dart';
import 'package:first_flutter_app/scoped_models/ProductsScopedModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatelessWidget {
  ProductsScopeModel productsService;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsScopeModel>(builder:
        (BuildContext context, Widget child, ProductsScopeModel model) {
      this.productsService = model;
      return buildListViewOfAllProducts();
    });
  }

  ListView buildListViewOfAllProducts() {
    return ListView.builder(
      itemBuilder: (context, int index) {
        return Dismissible(
          key: Key(productsService.products[index].title),
          onDismissed: (DismissDirection direction) {

            if (direction == DismissDirection.startToEnd) {
              productsService.deleteProduct(index);
            }
          },
          background: Container(
            color: Colors.red,
            child: Icon(Icons.delete),
          ),
          child: Column(
            children: <Widget>[buildListTile(index, context), Divider()],
          ),
        );
      },
      itemCount: productsService.products.length,
    );
  }

  ListTile buildListTile(int index, BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(productsService.products[index].url),
        ),
        title: Text(productsService.products[index].title),
        subtitle: Text('€${productsService.products[index].price}'),
        trailing: ScopedModelDescendant<ProductsScopeModel>(
          builder:
              (BuildContext context, Widget child, ProductsScopeModel model) {
            return IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  model.selectProduct(index);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ProductEditPage();
                  }));
                });
          },
        ));
  }
}
