import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
}
