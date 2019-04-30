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
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.dstATop),
                fit: BoxFit.cover,
                image: AssetImage('assets/background.jpg'))),
        padding: EdgeInsets.all(10.0),
        child: Center(
            child: SingleChildScrollView(
                child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  labelText: 'Email', filled: true, fillColor: Colors.white),
              keyboardType: TextInputType.emailAddress,
              onChanged: (newValue) {
                setState(() {
                  email = newValue;
                });
              },
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Password', filled: true, fillColor: Colors.white),
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
              title: Text("Accept terms"),
            ),
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
        ))));
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
