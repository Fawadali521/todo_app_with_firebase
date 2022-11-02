import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {
  List todo = ["first day", 'second day'];
  final TextEditingController todoController = TextEditingController();

  String? labelString;

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
}
