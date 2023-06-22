import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messaging_app/screens/welcome_screen.dart';
import 'package:messaging_app/utilities/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(ResponsiveSizer(
    builder: (context, orientation, screenType) {
      return const MyApp();
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Restricting the app's orientation to be portrait
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
          useMaterial3: true, scaffoldBackgroundColor: kScaffoldBgColor),
      home: const WelcomeScreen(),
    );
  }
}
