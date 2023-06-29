import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:messaging_app/utilities/animated_button.dart';
import 'package:messaging_app/utilities/constants.dart';
import 'package:messaging_app/utilities/user_authentication_text_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../main.dart';
import '../utilities/user_image_picker.dart';
import 'chat_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String _enteredUserName = "";

  String _enteredEmail = "";

  String _enteredPassword = "";

  File? _selectedImage;

  bool _isAuthenticating = false;

  void _submitUserData() async {
    if (_enteredUserName.trim().isEmpty ||
        _enteredEmail.trim().isEmpty ||
        _enteredEmail.trim().isEmpty ||
        _selectedImage == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please recheck all the fields!"),
        ),
      );
    } else {
      try {
        //Showing Loader or Progress
        setState(() {
          _isAuthenticating = true;
        });

        final userCredentials =
            await kFirebaseAuth.createUserWithEmailAndPassword(
                email: _enteredEmail, password: _enteredPassword);

        //We're storing the image in Firebase Storage after creating the user above
        //Here we're using the unique id of the user to name the image
        final imageStorageRef = FirebaseStorage.instance
            .ref()
            .child("user_images")
            .child("${userCredentials.user!.uid}.jpg");

        await imageStorageRef.putFile(_selectedImage!);

        final imageUrl = await imageStorageRef.getDownloadURL();

        //Storing the image for particular user
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredentials.user!.uid)
            .set({
          "userName": _enteredUserName,
          "email": _enteredEmail,
          "userImage":
              imageUrl //Here we're only storing the imageLink not the image file
        });

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Transform(
              transform: Matrix4.identity()
                ..translate(
                  -MediaQuery.of(context).size.width * .4,
                  -(MediaQuery.of(context).size.width * .2),
                )
                ..scale(1.0),
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
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 5.h,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Expanded(
                      //   flex: 5,
                      //   child: Center(
                      //     child: SizedBox(
                      //       width: 100.w,
                      //       child: const Text("Let's Get Started....",
                      //           style: kHeadingMaxTextStyle),
                      //     ),
                      //   ),
                      // ),
                      const Spacer(),

                      UserImagePicker(
                        onPickImage: (pickedImageFile) {
                          _selectedImage = pickedImageFile;
                        },
                      ),
                      SizedBox(height: 7.h),
                      UserAuthenticationTextField(
                        label: "User Name",
                        hintText: "Enter your username",
                        inputType: kInputType.userName,
                        typedString: (enteredUserName) {
                          _enteredUserName = enteredUserName;
                        },
                      ),
                      SizedBox(height: 3.h),
                      UserAuthenticationTextField(
                        label: "Email",
                        hintText: "Enter your email",
                        inputType: kInputType.email,
                        typedString: (enteredEmail) {
                          _enteredEmail = enteredEmail;
                        },
                      ),
                      SizedBox(height: 3.h),
                      UserAuthenticationTextField(
                        label: "Password",
                        hintText: "Enter your password",
                        inputType: kInputType.password,
                        typedString: (_) {},
                        isSignupPagePassword: true,
                      ),
                      SizedBox(height: 3.h),
                      UserAuthenticationTextField(
                        label: "Confirm Password",
                        hintText: "Confirm your password",
                        inputType: kInputType.password,
                        typedString: (confirmedPassword) {
                          _enteredPassword = confirmedPassword;
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
                          btnText: "Sign Up",
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
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Already have an account? Log In Now!",
                            style: kBodyTextStyle.copyWith(fontSize: 17.sp),
                          )),
                      SizedBox(
                        height: 3.h,
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
