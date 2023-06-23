import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:messaging_app/utilities/animated_button.dart';
import 'package:messaging_app/utilities/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utilities/reusable_text_field.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData().copyWith(color: kPrimaryColor),
        centerTitle: true,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: const SizedBox(),
          ),
        ),
        elevation: 0,
        backgroundColor: kScaffoldBgColor.withAlpha(200),
        title: const Text(
          "Chat Screen",
          style: kBodyTextStyle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //region Row

            SizedBox(
              height: 30.sp,
              child: Row(
                children: [
                  Expanded(
                    child: ReusableTextField(
                      label: "User Name",
                      hintText: "Enter your username",
                      inputType: kInputType.text,
                      typedString: (_) {},
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  SizedBox(
                    height: double.infinity,
                    width: 30.sp,
                    child: AnimatedButton(
                      onPressed: () {},
                    ),
                  ),

                  // FloatingActionButton(
                  //   onPressed: () {},
                  //   elevation: 0.0,
                  //   disabledElevation: 0.0,
                  //   hoverColor: Colors.transparent,
                  //   focusColor: Colors.transparent,
                  //   backgroundColor: kMainTextColor.withOpacity(0.2),
                  //   child: const Icon(Icons.send),
                  // )
                ],
              ),
            ),

            //endregion
          ],
        ),
      ),
    );
  }
}
