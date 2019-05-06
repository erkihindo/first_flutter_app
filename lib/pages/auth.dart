import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final emailRegexp = RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");

  String email = '';
  String password = '';
  bool acceptTerms = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget createUserForm() {
    return GestureDetector(
        // clicking on random spot will close keyboard
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
            decoration: BoxDecoration(image: this._buildBackgroundImage()),
            padding: EdgeInsets.all(10.0),
            child: Center(
                child: SingleChildScrollView(
                    child: Container(
                        child: Form(
                          key: _formKey,
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
            )))))));
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    print("Submitted form");
    Navigator.pushReplacementNamed(context, "/products");
  }

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
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

  TextFormField _buildPasswordTextField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password invalid';
        }
      },
      onSaved: (newValue) {
          password = newValue;
      },
    );
  }

  TextFormField _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Email', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (input) {
        if (!emailRegexp.hasMatch(input)) {
          return "Please enter correct email";
        };
      },
      onSaved: (newValue) {
          email = newValue;
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
