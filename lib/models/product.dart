class Product {
  num id;
  String url;
  String title;
  double price;
  String description;
  bool isFavourite;

  Product(
      {this.id,
      this.url,
      this.title,
      this.price,
      this.description,
      this.isFavourite = false});
}
