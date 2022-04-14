import 'package:flutter/material.dart';
import '/src/const/enums.dart';

class NormalTile extends StatelessWidget {
  final Animation<Offset> moveAnimation;
  final AnimationController controller;
  final Widget child;
  final SwipeDirection direction;
  final Widget background;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color color;
  final bool isElevated;

  const NormalTile({
    Key? key,
    required this.moveAnimation,
    required this.controller,
    required this.child,
    required this.background,
    required this.direction,
    required this.padding,
    required this.borderRadius,
    required this.color,
    required this.isElevated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Stack(
        children: <Widget>[
          if (!moveAnimation.isDismissed)
            Positioned.fill(
              child: background,
            ),

          SlideTransition(
            position: moveAnimation,
            child: AnimatedBuilder(
              animation: controller,
              builder: (_, __) {
                final Radius radius = Radius.circular(
                  Tween<double>(begin: 0, end: borderRadius)
                      .animate(
                        CurvedAnimation(
                          parent: controller,
                          curve: const Interval(0.0, 0.05),
                        ),
                      )
                      .value,
                );
                return Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.horizontal(
                        right: (direction == SwipeDirection.endToStart ||
                                direction == SwipeDirection.horizontal)
                            ? radius
                            : Radius.zero,
                        left: (direction == SwipeDirection.startToEnd ||
                                direction == SwipeDirection.horizontal)
                            ? radius
                            : Radius.zero,
                      ),
                      boxShadow: isElevated
                          ? <BoxShadow>[
                              BoxShadow(
                                  blurRadius: 2.0,
                                  color: ColorTween(
                                    begin: Colors.transparent,
                                    end: Colors.black.withOpacity(0.25),
                                  )
                                      .animate(
                                        CurvedAnimation(
                                          parent: controller,
                                          curve: const Interval(0.0, 0.05),
                                        ),
                                      )
                                      .value!)
                            ]
                          : null),
                  child: child,
                );
              },
            ),
          ),

          // content,
        ],
      ),
    );
  }
}
