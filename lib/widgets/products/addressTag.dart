import 'package:flutter/material.dart';


class AddressTag extends StatelessWidget {
  final String address;

  const AddressTag({this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(this.address),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(4.0)),
    );
  }

}