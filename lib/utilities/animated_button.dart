import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'constants.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({required this.onPressed, super.key});
  final VoidCallback onPressed;
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

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 200),
      scale: _isToggled ? 1.05 : 1,
      curve: Curves.easeInOut,
      child: SizedBox(
        width: 60.w,
        height: 8.h,
        child: Material(
          color: kBtnColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20.sp),
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              setState(() {
                _isToggled = !_isToggled;
              });

              //Executing onPressed of the parent class
              widget.onPressed;
            },
            child: const Center(
                child: Text(
              "Unite Now!",
              style: kButtonTextStyle,
            )),
          ),
        ),
      ),
      onEnd: () {
        setState(() {
          if (_isToggled) {
            _isToggled = !_isToggled;
          }
        });
      },
    );
  }
}
