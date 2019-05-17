import 'package:first_flutter_app/models/User.dart';
import 'package:first_flutter_app/scoped_models/UserAndProductsScopedModel.dart';
import 'package:scoped_model/scoped_model.dart';

mixin UserScopeModel on UserAndProductsScopedModel {

  void login(String email, String password) {
    authenticatedUser = new User(id: 'ssss', email: email, password: password);
  }
}
