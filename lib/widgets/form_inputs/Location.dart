import 'dart:convert';

import 'package:first_flutter_app/helpers/EnsureVisible.dart';
import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:http/http.dart' as http;

class LocationFormInput extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return _LocationFormInput();
	}

}

class _LocationFormInput extends State<LocationFormInput> {

	FocusNode _addressInputFocusNode = new FocusNode();
	Uri _staticMapUri;
	final TextEditingController _addressInputController = new TextEditingController();

	@override
	void initState() {
		_addressInputFocusNode.addListener(_updateLocation);
		super.initState();
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
						controller: _addressInputController,
						decoration: InputDecoration(labelText: 'Address'),
					),
				),
				SizedBox(height: 10.0,),
				_staticMapUri == null ? Container() : Image.network(_staticMapUri.toString())
			],

		);
	}

	void _updateLocation() {
		if (!_addressInputFocusNode.hasFocus) {
			getStaticMap(_addressInputController.text);
		}
	}

	void getStaticMap(String address) async {
		if (address.isEmpty) {
			return;
		}

		final Uri uri = Uri.https(
			'maps.googleapis.com',
			'/maps/api/geocode/json', {
			'address': address,
			'key': 'AIzaSyAY_8EoEsugfJPx9EVWlrBe9IYjCj3Au-Q'
		});
		final http.Response response = await http.get(uri);
		final decodedResponse = json.decode(response.body);
		final formattedAddress = decodedResponse['results'][0]['formatted_address'];
		final coords = decodedResponse['results'][0]['geometry']['location'];

		final StaticMapProvider staticMapProvider = new StaticMapProvider('AIzaSyAY_8EoEsugfJPx9EVWlrBe9IYjCj3Au-Q');

		final Uri staticMapUri = staticMapProvider.getStaticUriWithMarkers(
			[
				Marker(
					'position',
					'Position',
					coords['lat'],
					coords['lng'])
			],
			center: Location(coords['lat'], coords['lng']),
			width: 500,
			height: 300,
			maptype: StaticMapViewType.roadmap
		);
		setState(() {
			_addressInputController.text = formattedAddress;
			_staticMapUri = staticMapUri;
		});
	}

}