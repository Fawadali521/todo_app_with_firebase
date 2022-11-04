import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import 'package:todo/ui/custom_widgets/custom_sign_button.dart';
import 'package:todo/ui/custom_widgets/custom_textformfield.dart';
import 'package:todo/ui/custom_widgets/custom_hint_text.dart';
import 'package:todo/ui/screens/signup/signup_view_model.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);
  static const routeName = '/signup-page';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(),
      child: Consumer<SignUpViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("SignUp"),
            ),
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
                            SizedBox(height: 100.h),
                            CustomTextFormField(
                              hintText: 'user name',
                              pIcon: const Icon(Icons.person),
                              textEditingController: model.userController,
                            ),
                            SizedBox(height: 15.h),
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
                            SizedBox(height: 70.h),
                            CustomSignButton(
                              signText: 'Sign Up',
                              onpressed: () {
                                model.createAccount(context);
                                // model.addUser();
                              },
                            ),
                            SizedBox(height: 10.h),
                            CustomHintText(
                              text: 'Already have an account?',
                              buttonText: 'Login',
                              ontap: () {
                                Navigator.pop(context);
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
