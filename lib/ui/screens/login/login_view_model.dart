import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/core/utils/constant/kColors.dart';
import '../../../core/utils/package_utils.dart';
import '../home/home_view.dart';

class LoginViewModel with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  UserCredential? userCredential;
  //
  //Login Account Method
  //
  void loginAccount(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email == '' || password == '') {
      Utils().toastMessage('Please Fill All Details', kColors.redColor);
    } else {
      try {
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Utils()
            .toastMessage('Your Account Successful sign in', kColors.blueColor);
        log(userCredential!.user!.uid.toString());
        if (userCredential!.user != null) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.of(context).pushReplacementNamed(HomeView.routeName,
              arguments: userCredential!.user!.uid.toString());
        }
      } on FirebaseAuthException catch (error) {
        Utils().toastMessage(error.code.toString(), kColors.redColor);
      }
    }
    notifyListeners();
  }
}
