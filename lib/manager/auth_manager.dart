import 'dart:io';

import 'package:famlicious/services/fileuploadservice.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthManager with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FileUploadService _fileUploadService = FileUploadService();
  String _message = '';
  String get message => _message;
  setMessage(String message) {
    _message = message;
    notifyListeners();
  }

  //Authentication with email and password

  creatNewUser(
      {
      required String email,
      required String password,
      required File imageFile}) async {
  
        await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((UserCredential) async {
      String? photoUrl = await _fileUploadService.uploadFile(
          file: imageFile, userUid: UserCredential.user!.uid);

      if (photoUrl != null) {

      } else {
        setMessage("Image Upload  failed");
      }
    }).catchError((onError) {
      setMessage('$onError');
    }).timeout(const Duration(seconds: 60),onTimeout:(){
      setMessage('Please check your internet connection');
    });
  }
}
