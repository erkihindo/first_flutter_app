import 'package:first_flutter_app/pages/ProductsPage.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String email = '';
  String password = '';
  bool acceptTerms = false;

  Widget createUserForm() {
    return Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              onChanged: (newValue) {
                setState(() {
                  email = newValue;
                });
              },
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
              onChanged: (newValue) {
                setState(() {
                  password = newValue;
                });
              },
            ),
            SwitchListTile(
              value: acceptTerms,
              onChanged: (bool value) {
                setState(() {
                  this.acceptTerms = value;
                });
            },
            title: Text("Accept terms"),),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text('Create'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/products");
              },
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Please login'),
        ),
        body: this.createUserForm());
  }
}
