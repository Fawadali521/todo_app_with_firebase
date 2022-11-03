import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/utils/constant/kColors.dart';
import 'package:todo/ui/custom_widgets/custom_sign_button.dart';
import 'package:todo/ui/custom_widgets/custom_textformfield.dart';
import 'package:todo/ui/custom_widgets/custom_hint_text.dart';
import 'package:todo/ui/screens/home/home_view.dart';
import 'package:todo/ui/screens/signup/signup_view.dart';
import 'package:todo/ui/screens/signup/signup_view_model.dart';

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
              title: Text("Login"),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 15),
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
                            CustomTextFormField(
                              hintText: 'email',
                              pIcon: Icon(Icons.email_outlined),
                              textEditingController: model.emailController,
                            ),
                            CustomTextFormField(
                              hintText: 'password',
                              pIcon: Icon(Icons.password_outlined),
                              textEditingController: model.passwordController,
                            ),
                            CustomSignButton(
                              signText: 'Login',
                              onpressed: () {
                                model.loginAccount(context);
                              },
                            ),
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
