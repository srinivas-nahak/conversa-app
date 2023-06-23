import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:messaging_app/screens/chat_screen.dart';
import 'package:messaging_app/screens/signup_screen.dart';
import 'package:messaging_app/utilities/animated_button.dart';
import 'package:messaging_app/utilities/animated_page_route.dart';
import 'package:messaging_app/utilities/constants.dart';
import 'package:messaging_app/utilities/reusable_text_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  String _enteredEmail = "";
  String _enteredPassword = "";

  void _submitUserData(BuildContext context) {
    if (_enteredEmail.trim().isEmpty || _enteredEmail.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please recheck you email and password!"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text("email:$_enteredEmail, password:$_enteredPassword"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Transform(
              transform: Matrix4.identity()
                ..translate(
                  MediaQuery.of(context).size.width * .4,
                  -(MediaQuery.of(context).size.width * .2),
                )
                ..scale(1.15),
              child: Lottie.asset(
                "assets/animations/color_changing_circles-2.json",
                delegates: LottieDelegates(
                  values: [
                    ValueDelegate.opacity(
                      ["circle", "**"],
                      value: 20,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Center(
                          child: SizedBox(
                            width: 100.w,
                            child: const Text("Welcome Back!",
                                style: kHeadingMaxTextStyle),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(top: 1.h),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 2.3,
                            child: Column(
                              children: [
                                ReusableTextField(
                                  label: "Username or Email",
                                  hintText: "Enter your username or email",
                                  inputType: kInputType.email,
                                  typedString: (enteredEmail) {
                                    print(enteredEmail);
                                    _enteredEmail = enteredEmail;
                                  },
                                ),
                                SizedBox(height: 3.h),
                                ReusableTextField(
                                  label: "Password",
                                  hintText: "Enter your password",
                                  inputType: kInputType.password,
                                  typedString: (enteredPassword) {
                                    _enteredPassword = enteredPassword;
                                  },
                                ),
                                SizedBox(height: 3.h),
                                AnimatedButton(
                                  height: 6.h,
                                  btnText: "Log In",
                                  onPressed: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         const ChatScreen(),
                                    //   ),
                                    // );

                                    print(_enteredEmail);

                                    _submitUserData(context);
                                  },
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      AnimatedPageRoute(
                                        child: const SignupScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Don't have any account? Sign Up Now!",
                                    style:
                                        kBodyTextStyle.copyWith(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
