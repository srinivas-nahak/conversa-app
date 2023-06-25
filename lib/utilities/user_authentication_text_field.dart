import 'package:flutter/material.dart';
import 'package:messaging_app/utilities/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum kInputType { email, userName, password }

String signupPassword = "";

class UserAuthenticationTextField extends StatefulWidget {
  const UserAuthenticationTextField(
      {required this.label,
      required this.hintText,
      required this.inputType,
      required this.typedString,
      this.fetchController,
      this.isSignupPagePassword = false,
      super.key});

  final String label, hintText;
  final kInputType inputType;
  final void Function(String text) typedString;
  final bool isSignupPagePassword;
  final void Function(TextEditingController controller)? fetchController;

  //Function get clearFields => this.resetFields;

  @override
  State<UserAuthenticationTextField> createState() =>
      _UserAuthenticationTextFieldState();
}

class _UserAuthenticationTextFieldState
    extends State<UserAuthenticationTextField> {
  final TextEditingController _textEditingController = TextEditingController();

  TextInputType getTextInputType() {
    switch (widget.inputType) {
      case kInputType.userName:
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

    //Passing controller to the main parent class
    if (widget.fetchController != null) {
      widget.fetchController!(_textEditingController);
    }
  }

  void resetFields() {}

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
      case kInputType.userName:
        _verifyUserName(text);
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
      } else if (text.isEmpty || isEmail) {
        _errorText = null;

        //Passing String to the main Widget
        widget.typedString(text.toLowerCase());
      }
    });
  }

  void _verifyUserName(String text) {
    setState(() {
      if (text.length > 1 && text.length < 4) {
        _errorText = "Please enter at least 4 characters";
      } else if (text.isEmpty || text.length > 4) {
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
      } else if (text.isEmpty || isPassword) {
        //Storing password in signup screen for password check
        if (widget.isSignupPagePassword && text.isNotEmpty) {
          signupPassword = text;
        }

        //Showing error for password mismatch when entering confirm password
        if (widget.label == "Confirm Password" && text != signupPassword) {
          _errorText = "Passwords are not matching!";
          return;
        }

        _errorText = null;

        //Passing String to the main Widget
        widget.typedString(text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      maxLines: 1,
      keyboardType: getTextInputType(),
      onChanged: _verifyText,
      style: kBodyTextStyle.copyWith(fontSize: 15.sp),
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
        enabledBorder: kGetOutineBorder(kPrimaryColor.withOpacity(0.2)),
        focusedBorder: kGetOutineBorder(kPrimaryColor),
        errorBorder: kGetOutineBorder(Colors.redAccent),
        focusedErrorBorder: kGetOutineBorder(Colors.redAccent),
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
