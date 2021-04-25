import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication extends ChangeNotifier {
  String uid, userEmail;
  String get getUid => uid;
  String get getUserEmail => userEmail;
  dynamic errorMessage = "";
  String get getErrorMessage => errorMessage;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future loginIntoAccount(String email, String password) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      uid = user.uid;
      userEmail = user.email;
      sharedPreferences.setString('uid', uid);
      sharedPreferences.setString("useremail", userEmail);
      print("This is UID $getUid");
      errorMessage = "";
      notifyListeners();
    } catch (e) {
      print("??????????????????????????????????????????????");
      switch (e.code) {
        case 'user-not-found':
          errorMessage = "User not found";
          break;
        case 'wrong-password':
          errorMessage = "User not found";
          break;
        case 'invalid-email':
          errorMessage = "Inavlid Email";
          break;
        default:
          errorMessage = "Error in Login";
          break;
      }
    }
  }

  Future createNewAccount(String email, String password) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      uid = user.uid;
      sharedPreferences.setString('uid', uid);
      print("This is UID $getUid");
      notifyListeners();
    } catch (e) {
      print("??????????????????????????????????????????????");
      switch (e.code) {
        case 'account-exists-with-different-credentials':
          errorMessage = "Email already in use";
          break;
        case 'invalid-email':
          errorMessage = "Inavlid Email";
          break;
        default:
          errorMessage = "Error in SignUp";
          break;
      }
    }
  }
}
