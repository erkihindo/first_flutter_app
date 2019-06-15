import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageFormInput extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return _ImageFormInput();
	}

}

class _ImageFormInput extends State<ImageFormInput> {

	File _imageFile;

	@override
	Widget build(BuildContext context) {
		return Column(
			children: <Widget>[
				OutlineButton(
					borderSide: BorderSide(color: Theme
						.of(context)
						.accentColor,
						width: 2.0),
					onPressed: () {
						_openImagePicker(context);
					},
					child: Row(
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							Icon(Icons.camera_alt),
							SizedBox(height: 10.0,),
							Text("Add image", style: TextStyle(color: Theme
								.of(context)
								.accentColor),)
						],
					),
				),
				SizedBox(height: 10,),
				_imageFile == null ? Container() :
				Image.file(_imageFile, fit: BoxFit.cover, height: 300.0, alignment: Alignment.center, width: MediaQuery
					.of(context)
					.size
					.width,),
			],
		);
	}

	void _getImage(BuildContext context, ImageSource source) {
		ImagePicker.pickImage(source: source, maxWidth: 400).then((File image) {
			setState(() {
				_imageFile = image;
			});
			Navigator.pop(context);
		});
	}

	void _openImagePicker(BuildContext context) {
		showModalBottomSheet(context: context, builder: (BuildContext context) {
			return Container(
				height: 150,
				padding: EdgeInsets.all(10), child: Column(children: <Widget>[
				Text("Pick an image", style: TextStyle(fontWeight: FontWeight.bold),),
				SizedBox(height: 10,),
				FlatButton(
					textColor: Theme
						.of(context)
						.primaryColor,
					child: Text("Use camera"), onPressed: () {
					_getImage(context, ImageSource.camera);
				},),
				FlatButton(textColor: Theme
					.of(context)
					.primaryColor,
					child: Text("Use Gallery"), onPressed: () {
						_getImage(context, ImageSource.gallery);
					},),
			],),);
		});
	}

}