import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'constants.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField({required this.messageController, super.key});

  final TextEditingController messageController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: messageController,
      style: kBodyTextStyle.copyWith(fontSize: 15.sp),
      textCapitalization: TextCapitalization.sentences,
      autocorrect: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 2.5.h, vertical: 5.w),
        hintText: "Type your message...",
        hintStyle: TextStyle(
          color: kPrimaryColor.withOpacity(0.3),
        ),
        enabledBorder: kGetOutineBorder(kPrimaryColor.withOpacity(0.2)),
        focusedBorder: kGetOutineBorder(kPrimaryColor),
      ),
    );
  }
}
