import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {
  UserImagePicker({Key key}) : super(key: key);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _pickedImage = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundImage:
              _pickedImage == null ? null : FileImage(_pickedImage),
        ),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text("Add Image"),
        ),
      ],
    );
  }
}
