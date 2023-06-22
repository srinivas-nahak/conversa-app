import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:messaging_app/utilities/animated_button.dart';
import 'package:messaging_app/utilities/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  final String _heading = "Words Unite Worlds.",
      _subText =
          "Unite through seamless conversations. Connect, chat, and discover meaningful connections.",
      _dummyLicenceText =
          "Disclaimer: Free Preview. While we make every effort to provide accurate information, occasional inaccuracies about individuals, locations, or facts may occur. Enjoy using our app!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Transform.scale(
            scale: 1.4,
            child: Lottie.asset(
              "assets/animations/moving_circles_brighter.json",
            ),
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
                  AnimatedButton(onPressed: () {}),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Text(
                    _dummyLicenceText,
                    style: TextStyle(color: kMainTextColor.withOpacity(0.3)),
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
