import 'package:flutter/material.dart';

class SignUpViewModel with ChangeNotifier {
  final TextEditingController userController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
}
