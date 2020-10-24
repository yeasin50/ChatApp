import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import '../widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String userName,
    // File image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // print('uID' + authResult.user.uid);
        //storing userData
        //.....
        print('Image Storing');
        // final ref = FirebaseStorage.instance
        //     .ref()
        //     .child('user_image')
        //     .child(authResult.user.uid + '.jpg');
        // await ref.putFile(image).onComplete;
        // print('Image Storing');

        final url = 'urls ';
        print(url);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set({
          'username': userName,
          'email': email,
          'image_url': url,
        });
      }
    } on PlatformException catch (err) {
      var msg = 'please check your credentials!';

      if (err.message != null) {
        msg = err.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print("On Globe");
      print(error.toString());
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
