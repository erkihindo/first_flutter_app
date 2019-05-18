import 'package:flutter/material.dart';

class Product {
  String id;
  String url;
  String title;
  double price;
  String description;
  bool isFavourite;
  String userEmail;
  String userId;

  Product({
    this.id,
    this.url,
    this.title,
    this.price,
    this.description,
    this.isFavourite = false,
    this.userEmail,
    this.userId,
  });

  toJson() {
  	return {
        "url": url,
        "title": title,
        "price": price,
        "description": description,
        "isFavourite": isFavourite,
        "userEmail": userEmail,
        "userId": userId,
    };
  }
}
