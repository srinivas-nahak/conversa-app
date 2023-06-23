import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:messaging_app/utilities/animated_button.dart';
import 'package:messaging_app/utilities/constants.dart';
import 'package:messaging_app/utilities/reusable_text_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Expanded(
                  flex: 5,
                  child: Center(
                    child: SizedBox(
                      width: 100.w,
                      child: const Text("Let's Get Started....",
                          style: kHeadingMaxTextStyle),
                    ),
                  ),
                ),
                ReusableTextField(
                  label: "User Name",
                  hintText: "Enter your username",
                  inputType: kInputType.text,
                  typedString: (_) {},
                ),
                SizedBox(height: 3.h),
                ReusableTextField(
                  label: "Email",
                  hintText: "Enter your email",
                  inputType: kInputType.email,
                  typedString: (_) {},
                ),
                SizedBox(height: 3.h),
                ReusableTextField(
                  label: "Password",
                  hintText: "Enter your password",
                  inputType: kInputType.password,
                  typedString: (_) {},
                ),
                SizedBox(height: 3.h),
                ReusableTextField(
                  label: "Confirm Password",
                  hintText: "Confirm your password",
                  inputType: kInputType.password,
                  typedString: (_) {},
                ),
                SizedBox(height: 3.h),
                AnimatedButton(
                  height: 6.h,
                  btnText: "Sign Up",
                  onPressed: () {},
                ),
                const Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Already have an account? Log In Now!",
                      style: kBodyTextStyle.copyWith(fontSize: 18),
                    )),
                SizedBox(
                  height: 3.h,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
