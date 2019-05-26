
import 'package:first_flutter_app/scoped_models/mainScope.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LogoutListTile extends StatelessWidget {

	@override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(builder: (BuildContext context, Widget child, MainScopeModel model) {
    	return ListTile(
		    title: Text("Logout"),
		    leading: Icon(Icons.exit_to_app),
		    onTap: () {
				model.logout();
				Navigator.pushReplacementNamed(context, '/');
		    },
	    );
    },);
  }

}