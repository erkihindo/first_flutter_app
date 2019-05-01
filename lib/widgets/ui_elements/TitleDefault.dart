import 'package:flutter/material.dart';


class TitleDefault extends StatelessWidget {
  final String title;

  const TitleDefault({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          fontFamily: 'Oswald'),
    );
  }

}