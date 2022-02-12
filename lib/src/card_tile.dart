import 'package:flutter/material.dart';

import '/src/const/enums.dart';

class CardTile extends StatelessWidget {
  final Animation<Offset> moveAnimation;
  final AnimationController controller;
  final Widget child;
  final SwipeDirection direction;
  final Widget background;
  final EdgeInsetsGeometry padding;
  final BoxShadow shadow;
  final double borderRadius;
  final Color color;

  const CardTile({
    Key? key,
    required this.moveAnimation,
    required this.controller,
    required this.child,
    required this.background,
    required this.direction,
    required this.padding,
    required this.shadow,
    required this.borderRadius,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Stack(
        children: <Widget>[
          if (!moveAnimation.isDismissed)
            Positioned.fill(
              child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: background),
            ),

          SlideTransition(
            position: moveAnimation,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(borderRadius),
                boxShadow: <BoxShadow>[shadow],
              ),
              child: child,
            ),
          ),

          // content,
        ],
      ),
    );
  }
}
