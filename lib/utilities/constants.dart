import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

//Firebased Related
final kFirebaseAuth = FirebaseAuth.instance;

//Color
const kScaffoldBgColor = Color(0xffe1dede);
const kPrimaryColor = Color(0xff2F4858);
const kButtonColor = Color(0xff5C7ECC);

//Text Styles
final kHeadingMaxTextStyle = TextStyle(
  color: kPrimaryColor,
  fontSize: 32.sp,
  fontFamily: "Poppins",
  height: 1.2,
);

final kBodyTextStyle = TextStyle(
  color: kPrimaryColor,
  fontSize: 19.sp,
);

final kButtonTextStyle = TextStyle(
  color: kScaffoldBgColor,
  fontSize: 19.sp,
);

OutlineInputBorder kGetOutineBorder(Color color) => OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1),
      borderRadius: BorderRadius.circular(20.sp),
    );
