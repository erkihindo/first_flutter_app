import 'package:first_flutter_app/helpers/EnsureVisible.dart';
import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';

class LocationFormInput extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return _LocationFormInput();
	}

}

class _LocationFormInput extends State<LocationFormInput> {

	FocusNode _addressInputFocusNode = new FocusNode();
	Uri _staticMapUri;

	@override
	void initState() {
		_addressInputFocusNode.addListener(_updateLocation);
		getStaticMap();
		super.initState();
	}

	void _updateLocation() {

	}

	@override
	void dispose() {
		_addressInputFocusNode.removeListener(_updateLocation);
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Column(
			children: <Widget>[
				EnsureVisibleWhenFocused(
					focusNode: _addressInputFocusNode,
					child: TextFormField(
						focusNode: _addressInputFocusNode,
					),
				),
				SizedBox(height: 10.0,),
				Image.network(_staticMapUri.toString())
			],

		);
	}

	void getStaticMap() async {
		final StaticMapProvider staticMapProvider = new StaticMapProvider('AIzaSyAY_8EoEsugfJPx9EVWlrBe9IYjCj3Au-Q');

		final Uri staticMapUri = staticMapProvider.getStaticUriWithMarkers(
			[
				Marker(
					'position',
					'Position',
					41.40338,
					2.17403)
			],
			center: Location(41.40338, 2.17403),
			width: 500,
			height: 300,
			maptype: StaticMapViewType.roadmap
		);
		setState(() {
		  _staticMapUri = staticMapUri;
		});
	}

}