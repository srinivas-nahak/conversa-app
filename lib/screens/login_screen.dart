import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:messaging_app/main.dart';
import 'package:messaging_app/screens/chat_screen.dart';
import 'package:messaging_app/screens/signup_screen.dart';
import 'package:messaging_app/utilities/animated_button.dart';
import 'package:messaging_app/utilities/animated_page_route.dart';
import 'package:messaging_app/utilities/constants.dart';
import 'package:messaging_app/utilities/user_authentication_text_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _enteredEmail = "";

  String _enteredPassword = "";

  bool _isAuthenticating = false;

  List<TextEditingController> _textFieldControllerList = [];

  void _submitUserData() async {
    if (_enteredEmail.trim().isEmpty || _enteredEmail.trim().isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please recheck you email and password!"),
        ),
      );
    } else {
      setState(() {
        _isAuthenticating = true;
      });

      try {
        final userCredentials = await kFirebaseAuth.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);

        //Navigating to the chat screen on Successful login
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? "Some unknown error occured!"),
          ),
        );

        //Closing the Loader or Progress
        setState(() {
          _isAuthenticating = false;
        });
      }
    }
  }

  void _clearText() {
    for (final controller in _textFieldControllerList) {
      controller.text = "a";
      controller.clear();
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
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 3.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: Text("Welcome Back!",
                                style: kHeadingMaxTextStyle),
                          ),
                        ),
                        UserAuthenticationTextField(
                          fetchController: (emailController) =>
                              _textFieldControllerList.add(emailController),
                          label: "Username or Email",
                          hintText: "Enter your username or email",
                          inputType: kInputType.email,
                          typedString: (enteredEmail) {
                            _enteredEmail = enteredEmail;
                          },
                        ),
                        SizedBox(height: 3.h),
                        UserAuthenticationTextField(
                          fetchController: (passwordController) =>
                              _textFieldControllerList.add(passwordController),
                          label: "Password",
                          hintText: "Enter your password",
                          inputType: kInputType.password,
                          typedString: (enteredPassword) {
                            _enteredPassword = enteredPassword;
                          },
                        ),
                        SizedBox(height: 3.h),
                        if (_isAuthenticating)
                          const CircularProgressIndicator(
                            color: kButtonColor,
                          ),
                        if (!_isAuthenticating)
                          AnimatedButton(
                            height: 6.h,
                            btnText: "Log In",
                            onPressed: () {
                              //Closing the keyboard
                              FocusScope.of(context).unfocus();

                              //Submitting the data
                              _submitUserData();
                            },
                          ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            //Clearing text of the text fields
                            _clearText();

                            Navigator.push(
                              context,
                              AnimatedPageRoute(
                                child: const SignupScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Don't have any account? Sign Up Now!",
                            style: kBodyTextStyle.copyWith(fontSize: 17.sp),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
