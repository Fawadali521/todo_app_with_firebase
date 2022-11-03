import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/utils/constant/kColors.dart';
import '../../../core/utils/package_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpViewModel with ChangeNotifier {
  final TextEditingController userController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  UserCredential? userCredential;

  void createAccount(BuildContext context) async {
    String user1 = userController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (user1 == '' || email == '' || password == '') {
      Utils().toastMessage('Please Fill All Details', kColors.redColor);
    } else {
      try {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        Utils()
            .toastMessage('Your Account Successful sign up', kColors.blueColor);
        log(userCredential!.user!.uid.toString());
        addUser(user1);
        if (userCredential!.user != null) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (error) {
        Utils().toastMessage(error.code.toString(), kColors.redColor);
      }
    }
    notifyListeners();
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(String user1) {
    String user1 = userController.text.trim();
    return users
        .doc(userCredential!.user!.uid.toString())
        .set({
          'userName': user1,
        })
        .then((value) => log("User Added"))
        .catchError((error) => log("Failed to add user: $error"));
  }
}
