import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famlicious/services/fileuploadservice.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthManager with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FileUploadService _fileUploadService = FileUploadService();
  bool isCreated = false;
  String _message = '';
  bool _isLoading = false;
  String get message => _message;
  bool get isLoading => _isLoading;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  setMessage(String message) {
    _message = message;
    notifyListeners();
  }

  setIsLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  //Authentication with email and password

  Future<bool> creatNewUser(
      {required String name,
      required String email,
      required String password,
      required File imageFile}) async {
    setIsLoading(true);
    await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((UserCredential) async {
      String? photoUrl = await _fileUploadService.uploadFile(
          file: imageFile, userUid: UserCredential.user!.uid);

      if (photoUrl != null) {
        userCollection.doc(UserCredential.user!.uid).set({
          "name": name,
          "email": email,
          "picture": photoUrl,
          "createdAt": FieldValue.serverTimestamp()
        });
        isCreated = true;
      } else {
        setMessage("Image Upload  failed");
        isCreated = false;
        setIsLoading(false);
      }
    }).catchError((onError) {
      setMessage('$onError');
    }).timeout(const Duration(seconds: 60), onTimeout: () {
      setMessage('Please check your internet connection');
    });
    return isCreated;
  }

  Future<bool> loginUser(
      {required String email, required String password}) async {
    bool isSuccessful = false;
    await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((UserCredential) {
      if (UserCredential.user != null) {
        isSuccessful = true;
      } else {
        isSuccessful = false;
        setMessage('Could not log you in!');
      }
    }).catchError((onError) {
      setMessage('$onError');
      isSuccessful = false;
    }).timeout(const Duration(seconds: 60), onTimeout: () {
      setMessage('Please check your internet Connection');
    });
    return isSuccessful;
  }

  Future<bool> sendResetLink(String email) async {
    bool isSent = false;
    await _firebaseAuth.sendPasswordResetEmail(email: (email)).then((_) {
      isSent = true;
    }).catchError((onError) {
      setMessage('$onError');
      isSent = false;
    }).timeout(const Duration(seconds: 60), onTimeout: () {
      setMessage('Please check your internet Connection');
    });
    return isSent;
  }
}
