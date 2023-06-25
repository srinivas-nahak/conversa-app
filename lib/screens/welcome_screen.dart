import 'dart:convert';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:messaging_app/screens/chat_screen.dart';
import 'package:messaging_app/screens/login_screen.dart';
import 'package:messaging_app/utilities/animated_button.dart';
import 'package:messaging_app/utilities/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  final String _heading = "Words Unite Worlds.",
      _subText =
          "Unite through seamless conversations. Connect, chat, and discover meaningful connections.",
      _dummyLicenceText =
          "Disclaimer: Chat for fun only. Inaccuracies may occur. Use responsibly, verify info independently. Connect and enjoy our app!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Transform.scale(
            scale: 1.4,
            child: Lottie.asset("assets/animations/moving_circles.json",
                delegates: LottieDelegates(values: [
                  // ValueDelegate.blurRadius(
                  //   const ["**"],
                  //   value: 50,
                  // ),
                  ValueDelegate.opacity(
                    const [
                      "**",
                    ],
                    value: 80,
                  ),
                  ValueDelegate.transformPosition(
                    const ["Square", "**"],
                    callback: (frameInfo) {
                      final currentOffset = frameInfo.startValue;

                      Offset changedOffset =
                          Offset(currentOffset!.dx, currentOffset.dy + 60);

                      return changedOffset;
                    },
                  ),
                ])),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: const SizedBox(),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.w,
                right: 20.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(_heading, style: kHeadingMaxTextStyle),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Text(
                    _subText,
                    style: kBodyTextStyle,
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                  AnimatedButton(
                      width: 60.w,
                      btnText: "Unite Now!",
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StreamBuilder(
                                stream:
                                    FirebaseAuth.instance.authStateChanges(),
                                builder: (context, snapShot) {
                                  if (snapShot.connectionState ==
                                      ConnectionState.waiting) {
                                    //TODO: We can show the loading screen here.
                                  }

                                  if (snapShot.hasData) {
                                    return ChatScreen();
                                  }
                                  return LoginScreen();
                                }),
                          ),
                        );
                      }),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    _dummyLicenceText,
                    style: TextStyle(color: kPrimaryColor.withOpacity(0.3)),
                  ),
                  const Spacer()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
