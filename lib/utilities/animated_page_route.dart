import 'package:flutter/cupertino.dart';

class AnimatedPageRoute extends PageRouteBuilder {
  AnimatedPageRoute({required this.child})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionDuration: const Duration(milliseconds: 700),
        );

  final Widget child;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // TODO: implement buildTransitions

    return SlideTransition(
      position: Tween<Offset>(
              begin: const Offset(0.2, 0.0), end: const Offset(0.0, 0.0))
          .animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ),
      ),
      child: child,
    );
    //return super.buildTransitions(context, animation, secondaryAnimation, child);
  }
}
