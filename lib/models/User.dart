import 'package:flutter/material.dart';

class User {
	String id;
	String email;
	String token;

	User({this.id, this.email, @required this.token});
}