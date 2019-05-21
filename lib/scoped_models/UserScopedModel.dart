import 'dart:convert';

import 'package:first_flutter_app/models/User.dart';
import 'package:first_flutter_app/scoped_models/UserAndProductsScopedModel.dart';
import 'package:http/http.dart' as http;

mixin UserScopeModel on UserAndProductsScopedModel {

	final String signUpUrl = 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyDK9oj7dxbH_Yr4Bym_HUufdnmwlkGKkI4';

	void login(String email, String password) {
		authenticatedUser = new User(id: 'ssss', email: email, password: password);
	}

	Future<Map<String, dynamic>> signUp(String email, String password) async {
		Map<String, dynamic> authData = {
			"email": email,
			"password": password,
			"returnSecureToken": true
		};
		http.Response response = await http.post(this.signUpUrl,
			headers: {'Content-Type': 'application/json'},
			body: json.encode(authData));

		final Map<String, dynamic> responseData = json.decode(response.body);
		bool wasSuccesful = responseData.containsKey("idToken");
		var message = wasSuccesful ? 'Auth succeeded' : responseData['error']['message'];
		return {'success': wasSuccesful, 'message': message};
	}
}
