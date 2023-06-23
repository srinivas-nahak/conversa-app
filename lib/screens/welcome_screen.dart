import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
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

  //Trying to change position directly in the json
  Future<Uint8List> _changeAnimPosition({int value = 60}) async {
    final data = await rootBundle
        .loadString("assets/animations/moving_circles_brighter.json");
    final aJson = await jsonDecode(data);

    final position = aJson["layers"][3]["ks"]["p"]["k"];
    List<dynamic> changedPosition = [];

    for (int i = 0; i < position.length; i++) {
      num yAxis = position[i];
      if (i == 1) {
        yAxis += value;
      }
      changedPosition = [...changedPosition, yAxis];
    }

    aJson["layers"][3]["ks"]["p"]["k"] = changedPosition;

    List<int> list = jsonEncode(aJson).toString().codeUnits;
    Uint8List bytes = Uint8List.fromList(list);
    return bytes;

    ///Using Future builder to receive Future values
    // Transform.scale(
    //   scale: 1.4,
    //   child: FutureBuilder<Uint8List>(
    //       future: _changeAnimPosition(value: _animationPosition),
    //       builder: (context, snapShot) {
    //         if (snapShot.data == null) {
    //           return Lottie.asset(
    //             "assets/animations/moving_circles_brighter.json",
    //           );
    //         }
    //
    //         return Lottie.memory(snapShot.data ?? Uint8List.fromList([]));
    //       }),
    // ),
  }

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
                            builder: (context) => LoginScreen(),
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
