import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/ui/screens/login/login_view.dart';
import 'package:todo/core/utils/constant/kColors.dart';
import '../../../core/utils/package_utils.dart';

class HomeViewModel with ChangeNotifier {
  List todo = ["first day", 'second day'];
  final TextEditingController todoController = TextEditingController();

  String? labelString;
  String? userName;
  String label() {
    int currentTime = DateTime.now().hour;
    if (currentTime > 5 && currentTime <= 12) {
      return labelString = 'Morning';
    } else if (currentTime > 12 && currentTime <= 17) {
      return labelString = 'Afternoon';
    } else {
      return labelString = 'Evening';
    }
  }

  void logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.of(context).pushReplacementNamed(LoginView.routeName);
  }

  String? readUser(String uid) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        userName = documentSnapshot.get("userName");
        log('$userName');
      } else {
        Utils().toastMessage('User Name does Not Exist', kColors.redColor);
      }
    });
    return userName;
  }
}
