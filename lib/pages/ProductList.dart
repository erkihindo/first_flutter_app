import 'package:first_flutter_app/domain/image.dart';
import 'package:first_flutter_app/pages/ProductEditPage.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  final List<CustomImage> products;
  final Function updateProduct;

  ProductListPage(this.products, this.updateProduct);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, int index) {
        return ListTile(
//          leading: Image.asset(products[index].url),
          title: Text(products[index].title),
          trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ProductEditPage(
                    product: products[index],
                    updateProduct: this.updateProduct,
                    productIndex: index,
                  );
                }));
              }),
        );
      },
      itemCount: products.length,
    );
  }
}
