import 'package:first_flutter_app/models/User.dart';
import 'package:scoped_model/scoped_model.dart';

mixin UserScopeModel on Model {
  User authenticatedUser;

  void login(String email, String password) {
    authenticatedUser = new User(id: 'ssss', email: email, password: password);
  }
}
