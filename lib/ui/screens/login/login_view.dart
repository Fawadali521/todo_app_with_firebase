import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:todo/ui/custom_widgets/custom_sign_button.dart';
import 'package:todo/ui/custom_widgets/custom_textformfield.dart';
import 'package:todo/ui/custom_widgets/custom_hint_text.dart';
import 'package:todo/ui/screens/signup/signup_view.dart';
import 'login_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Login"),
            ),
            //
            //body start
            //
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.teal,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 190.h),
                            CustomTextFormField(
                              hintText: 'email',
                              pIcon: const Icon(Icons.email_outlined),
                              textEditingController: model.emailController,
                            ),
                            SizedBox(height: 15.h),
                            CustomTextFormField(
                              hintText: 'password',
                              pIcon: const Icon(Icons.password_outlined),
                              textEditingController: model.passwordController,
                              obscureText: true,
                            ),
                            SizedBox(height: 15.h),
                            CustomSignButton(
                              signText: 'Login',
                              onpressed: () {
                                model.loginAccount(context);
                              },
                            ),
                            SizedBox(height: 10.h),
                            CustomHintText(
                              text: 'Don\'t have and account?',
                              buttonText: 'Sign Up',
                              ontap: () {
                                Navigator.of(context)
                                    .pushNamed(SignUpView.routeName);
                              },
                            )
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
