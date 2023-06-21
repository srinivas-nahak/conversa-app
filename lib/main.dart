import 'package:flutter/material.dart';
import 'package:messaging_app/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData()
          .copyWith(useMaterial3: true, scaffoldBackgroundColor: Color(0xff)),
      home: const WelcomeScreen(),
    );
  }
}
