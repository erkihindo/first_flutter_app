import 'package:first_flutter_app/models/AuthMode.dart';
import 'package:first_flutter_app/scoped_models/mainScope.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AuthPage extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return _AuthPageState();
	}
}

class _AuthPageState extends State<AuthPage> {
	final emailRegexp = RegExp(
		r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
	final TextEditingController _passwordTextController = new TextEditingController();
	String email = '';
	String password = '';
	bool acceptTerms = false;
	final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
	AuthMode authMode = AuthMode.LOGIN;

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
										authMode == AuthMode.SIGN_UP ?
										_buildPasswordConfirmTextField() : Container(),
										_buildAcceptSwitch(),
										SizedBox(
											height: 10.0,
										),
										FlatButton(
											child: Text('Switch to ${authMode == AuthMode.LOGIN ? "Sign up" : "Login"}'),
											onPressed: () {
												setState(() {
													authMode = authMode == AuthMode.LOGIN ?
													AuthMode.SIGN_UP :
													AuthMode.LOGIN;
												});
											},
										),
										SizedBox(
											height: 10.0,
										),
										buildLoginButton()
									],
								)))))));
	}

	Widget buildLoginButton() {
		return ScopedModelDescendant<MainScopeModel>(
			builder: (BuildContext context, Widget child, MainScopeModel model) {
				return RaisedButton(
					color: Theme
						.of(context)
						.accentColor,
					child: Text('Create'),
					onPressed: () => _submitForm(model.login),
				);
			});
	}

	void _submitForm(Function login) {
		if (!_formKey.currentState.validate()) {
			return;
		}
		_formKey.currentState.save();
		print("Submitted form");
		login(this.email, this.password);
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
			controller: _passwordTextController,
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
				}
			},
			onSaved: (newValue) {
				email = newValue;
			},
		);
	}

	TextFormField _buildPasswordConfirmTextField() {
		return TextFormField(
			obscureText: true,
			decoration: InputDecoration(
				labelText: 'Confirm Password', filled: true, fillColor: Colors.white),
			validator: (String value) {
				if (_passwordTextController.text != value) {
					return 'Passwords do not match';
				}
			},
			onSaved: (newValue) {
				password = newValue;
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
