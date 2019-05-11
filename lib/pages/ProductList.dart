import 'package:first_flutter_app/models/product.dart';
import 'package:first_flutter_app/pages/ProductEditPage.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  final List<Product> products;
  final Function updateProduct;
  final Function deleteProduct;

  ProductListPage(this.products, this.updateProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, int index) {
        return Dismissible(
          key: Key(products[index].title), // TODO use id instead
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.startToEnd) {
              this.deleteProduct(index);
            }
          },
          background: Container(color: Colors.red, child: Icon(Icons.delete),),
          child: Column(
            children: <Widget>[buildListTile(index, context), Divider()],
          ),
        );
      },
      itemCount: products.length,
    );
  }

  ListTile buildListTile(int index, BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(products[index].url),
      ),
      title: Text(products[index].title),
      subtitle: Text('€${products[index].price}'),
      trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return ProductEditPage(
                product: products[index],
                updateProduct: this.updateProduct,
                productIndex: index,
              );
            }));
          }),
    );
  }
}
