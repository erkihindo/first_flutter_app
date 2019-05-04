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
    final double deviceWidth = MediaQuery.of(context).size.width;
    final targetWidth =  deviceWidth * 0.8 > 350.0 ? 200.0 : deviceWidth * 0.95;
    return Container(
        decoration: BoxDecoration(image: this._buildBackgroundImage()),
        padding: EdgeInsets.all(10.0),
        child: Center(
            child: SingleChildScrollView(
                child: Container(
                  width: targetWidth,
                    child: Column(
          children: <Widget>[
            _buildEmailTextField(),
            _buildPasswordTextField(),
            _buildAcceptSwitch(),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text('Create'),
              onPressed: _submitForm,
            )
          ],
        )))));
  }

  void _submitForm() {
    print("Submitted form");
    Navigator.pushReplacementNamed(context, "/products");
  }

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
        fit: BoxFit.cover,
        image: AssetImage('assets/background.jpg'));
  }

  SwitchListTile _buildAcceptSwitch() {
    return SwitchListTile(
      value: acceptTerms,
      onChanged: (bool value) {
        setState(() {
          this.acceptTerms = value;
        });
      },
      title: Text("Accept terms"),
    );
  }

  TextField _buildPasswordTextField() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(labelText: 'Password', filled: true, fillColor: Colors.white),
      onChanged: (newValue) {
        setState(() {
          password = newValue;
        });
      },
    );
  }

  TextField _buildEmailTextField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Email', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      onChanged: (newValue) {
        setState(() {
          email = newValue;
        });
      },
    );
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
