import 'dart:convert';

import 'package:first_flutter_app/models/User.dart';
import 'package:first_flutter_app/scoped_models/UserAndProductsScopedModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

mixin UserScopeModel on UserAndProductsScopedModel {
	static String apiKey = 'AIzaSyDK9oj7dxbH_Yr4Bym_HUufdnmwlkGKkI4';
	final String signUpUrl = 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=' + apiKey;
	final String signInUrl = 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=' + apiKey;

	Future<Map<String, dynamic>> login(String email, String password) async {
		Map<String, dynamic> authData = {
			"email": email,
			"password": password,
			"returnSecureToken": true
		};

		http.Response response = await http.post(this.signInUrl,
			headers: {'Content-Type': 'application/json'},
			body: json.encode(authData));

		final Map<String, dynamic> responseData = json.decode(response.body);
		bool wasSuccessful = responseData.containsKey("idToken");
		var message = wasSuccessful ? 'Auth succeeded' : responseData['error']['message'];
		this.stopSpinner();
		createUserIfSuccessful(wasSuccessful, responseData);
		return {'success': wasSuccessful, 'message': message};

	}

	void createUserIfSuccessful(
		bool wasSuccessful,
		Map<String, dynamic> responseData) async {
		if (wasSuccessful) {
			authenticatedUser = new User(
				id: responseData['localId'],
				email: responseData['email'],
				token: responseData['idToken']);
			final SharedPreferences prefs = await SharedPreferences.getInstance();
			prefs.setString('token', authenticatedUser.token);
			prefs.setString('userEmail', authenticatedUser.email);
			prefs.setString('userId', authenticatedUser.id);
		}
	}
	
	autoAuthenticate() async {
		final SharedPreferences prefs = await SharedPreferences.getInstance();
		final String token = prefs.getString('token');
		if (token != null) {
			final String email = prefs.getString('userEmail');
			final String id = prefs.getString('userId');
			this.authenticatedUser = User(token: token, id: id, email: email);
			notifyListeners();
		}
	}


	Future<Map<String, dynamic>> signUp(String email, String password) async {
		this.startSpinner();
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
		this.stopSpinner();
		return {'success': wasSuccesful, 'message': message};
	}

}
