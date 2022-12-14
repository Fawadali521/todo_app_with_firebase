import 'package:flutter/material.dart';
import 'package:todo/ui/screens/home/home_view.dart';
import 'package:todo/ui/screens/login/login_view.dart';
import 'package:todo/ui/screens/signup/signup_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              theme: ThemeData(
                useMaterial3: true,
              ),
              // home: (FirebaseAuth.instance.currentUser != null)
              //     ? HomeView()
              //     : LoginView(),
              initialRoute: (FirebaseAuth.instance.currentUser != null)
                  ? HomeView.routeName
                  : LoginView.routeName,
              routes: {
                LoginView.routeName: (context) => const LoginView(),
                SignUpView.routeName: (context) => const SignUpView(),
                HomeView.routeName: (context) => HomeView(),
              });
        });
  }
}
