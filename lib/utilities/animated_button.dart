import 'dart:async';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'constants.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton(
      {this.width = 0,
      this.height = 0,
      this.btnText = "",
      required this.onPressed,
      super.key});
  final VoidCallback onPressed;
  final double width, height;
  final String btnText;
  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _isToggled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget sendButton() => Material(
        color: kButtonColor,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            //Closing the softKeyboard if it's open
            // if (FocusManager.instance.primaryFocus!.hasFocus) {
            //   FocusManager.instance.primaryFocus?.unfocus();
            // }

            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }

            setState(() {
              _isToggled = true;
            });

            //Ending the animation
            //Not using onEnd() because it was being invoked twice
            Future.delayed(const Duration(milliseconds: 250), () {
              setState(() {
                _isToggled = false;
              });

              //Invoking onPressed after the end of the animation
              Timer(
                const Duration(milliseconds: 150),
                () => widget.onPressed.call(),
              );
            });
          },
          child: Icon(
            Icons.send,
            color: kScaffoldBgColor,
            size: 18.sp,
          ),
        ),
      );

  Widget loginButton() => SizedBox(
        width: widget.width == 0 ? double.infinity : widget.width,
        height: widget.height == 0 ? 8.h : widget.height,
        child: Material(
          color: kButtonColor,
          borderRadius: BorderRadius.circular(20.sp),
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              setState(() {
                _isToggled = true;
              });

              //Ending the animation
              //Not using onEnd() because it was being invoked twice
              Future.delayed(const Duration(milliseconds: 250), () {
                setState(() {
                  _isToggled = false;
                });

                //Invoking onPressed after the end of the animation
                Timer(const Duration(milliseconds: 150), () {
                  widget.onPressed.call();
                });
              });
            },
            child: Center(
                child: Text(
              widget.btnText,
              style: kButtonTextStyle,
            )),
          ),
        ),
      );

  Widget getButton() {
    if (widget.btnText.isEmpty) {
      return sendButton();
    }

    return loginButton();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 200),
      scale: _isToggled ? 1.05 : 1,
      curve: Curves.easeInOut,
      child: getButton(),
    );
  }
}
