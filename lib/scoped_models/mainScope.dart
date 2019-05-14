import 'package:first_flutter_app/scoped_models/ProductsScopedModel.dart';
import 'package:first_flutter_app/scoped_models/UserScopedModel.dart';
import 'package:scoped_model/scoped_model.dart';


class MainScopeModel extends Model with UserScopeModel, ProductsScopeModel {

}