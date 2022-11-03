import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/utils/constant/kColors.dart';
import '../../../core/utils/package_utils.dart';

class SignUpViewModel with ChangeNotifier {
  final TextEditingController userController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void createAccount(BuildContext context) async {
    String user = userController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (user == '' || email == '' || password == '') {
      Utils().toastMessage('Please Fill All Details', kColors.redColor);
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        Utils()
            .toastMessage('Your Account Successful sign up', kColors.blueColor);
        log(userCredential.user!.uid.toString());
        if (userCredential.user != null) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (error) {
        Utils().toastMessage(error.code.toString(), kColors.redColor);
      }
    }
    notifyListeners();
  }
}
