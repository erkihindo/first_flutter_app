import 'package:flutter/material.dart';

class Product {
  num id;
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
}
