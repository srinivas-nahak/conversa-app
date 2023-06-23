import 'package:flutter/material.dart';
import 'package:messaging_app/utilities/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum kInputType { email, text, password }

class ReusableTextField extends StatefulWidget {
  const ReusableTextField(
      {required this.label,
      required this.hintText,
      required this.inputType,
      required this.typedString,
      super.key});

  final String label, hintText;
  final kInputType inputType;
  final void Function(String text) typedString;

  @override
  State<ReusableTextField> createState() => _ReusableTextFieldState();
}

class _ReusableTextFieldState extends State<ReusableTextField> {
  TextInputType getTextInputType() {
    switch (widget.inputType) {
      case kInputType.text:
        return TextInputType.text;
      case kInputType.email:
        return TextInputType.emailAddress;
      case kInputType.password:
        return TextInputType.visiblePassword;
    }
  }

  bool _hidePassword = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
  }

  void _verifyText(String text) {
    // if (widget.inputType == kInputType.email) {
    //   _verifyEmail(text);
    // } else if (widget.inputType == kInputType.password) {
    //   _verifyPassword(text);
    // }

    switch (widget.inputType) {
      case kInputType.email:
        _verifyEmail(text);
        break;
      case kInputType.password:
        _verifyPassword(text);
        break;
      case kInputType.text:
        _verifyEmail(text);
        break;
    }
  }

  void _verifyEmail(String text) {
    bool isEmail = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(text);

    setState(() {
      if (text.length > 5 && !isEmail) {
        _errorText = "Email is invalid!";

        //Passing String to the main Widget
        widget.typedString("");
      } else if (text.isEmpty || isEmail) {
        _errorText = null;

        //Passing String to the main Widget
        widget.typedString(text);
      }
    });
  }

  void _verifyPassword(String text) {
    bool isPassword =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(text);
    setState(() {
      if (text.length > 3 && !isPassword) {
        _errorText =
            "It must contain mixed case(aA), special characters like \$,@ & numbers";

        //Passing String to the main Widget
        widget.typedString("");
      } else if (text.isEmpty || isPassword) {
        _errorText = null;

        //Passing String to the main Widget
        widget.typedString(text);
      }
    });
  }

  OutlineInputBorder getOutineBorder(Color color) => OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 1.3),
        borderRadius: BorderRadius.circular(20.sp),
      );

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 1,
      keyboardType: getTextInputType(),
      onChanged: _verifyText,
      style: kBodyTextStyle.copyWith(fontSize: 16),
      obscureText: !_hidePassword && widget.inputType == kInputType.password,
      autocorrect: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 2.5.h, vertical: 5.w),
        labelText: widget.label,
        labelStyle: TextStyle(
          color: kPrimaryColor.withOpacity(0.7),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: kPrimaryColor.withOpacity(0.3),
        ),
        enabledBorder: getOutineBorder(kPrimaryColor.withOpacity(0.2)),
        focusedBorder: getOutineBorder(kPrimaryColor),
        errorBorder: getOutineBorder(Colors.redAccent),
        focusedErrorBorder: getOutineBorder(Colors.redAccent),
        errorText: _errorText,
        suffixIcon: widget.inputType == kInputType.password
            ? Padding(
                padding: EdgeInsets.only(right: 2.w),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: _hidePassword
                        ? kPrimaryColor
                        : kPrimaryColor.withOpacity(0.2),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
