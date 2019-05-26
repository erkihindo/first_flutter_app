import 'dart:async';
import 'dart:convert';

import 'package:first_flutter_app/models/User.dart';
import 'package:first_flutter_app/scoped_models/UserAndProductsScopedModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

mixin UserScopeModel on UserAndProductsScopedModel {

	Timer _authTimer;
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

	void logout() async {
		authenticatedUser = null;
		final SharedPreferences prefs = await SharedPreferences.getInstance();
		prefs.remove("idToken");
		prefs.remove("email");
		prefs.remove("token");
		prefs.remove("localId");
		this._authTimer.cancel();
		notifyListeners();
	}

	void setAuthTimeout(num timeSeconds) {
		this._authTimer = Timer(Duration(seconds: timeSeconds), () {
			this.logout();
		});
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
			final currentTime = DateTime.now();
			final tokenExpiryTime = currentTime.add(Duration(seconds: num.parse(responseData['expiresIn'])));
			prefs.setString('token', authenticatedUser.token);
			prefs.setString('userEmail', authenticatedUser.email);
			prefs.setString('userId', authenticatedUser.id);
			prefs.setString('expiryTime', tokenExpiryTime.toIso8601String());
			this.setAuthTimeout(num.parse(responseData['expiresIn']));
		}
	}
	
	autoAuthenticate() async {
		final SharedPreferences prefs = await SharedPreferences.getInstance();
		final String token = prefs.getString('token');
		if (token != null) {
			final String email = prefs.getString('userEmail');
			final String id = prefs.getString('userId');
			final expiryTime = DateTime.parse(prefs.getString('expiryTime'));
			final currentTime = DateTime.now();

			if(expiryTime.isBefore(currentTime)) {
				print("Token has expired, cant autoAuthenticate");
				return;
			}
			final tokenLifespanSeconds = expiryTime.difference(currentTime).inSeconds;
			this.setAuthTimeout(tokenLifespanSeconds);
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
