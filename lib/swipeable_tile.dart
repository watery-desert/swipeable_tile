// library swipeable_tile;


import 'package:flutter/material.dart';
import 'src/const/enums.dart';
import 'src/build_tile.dart';
export 'src/const/enums.dart';

class SwipeableTile extends StatelessWidget {
  final double horizontalPadding;
  final double verticalPadding;
  final bool isCard;
  final BoxShadow shadow;
  final double borderRadius;
  final Color color;

  /// How to behave during hit tests.
  ///
  /// This defaults to [HitTestBehavior.opaque].
  final HitTestBehavior behavior;

  /// A widget that is stacked behind the child.
  final BackgroundBuilder backgroundBuilder;

  /// The offset threshold the item has to be dragged in order to be considered
  /// dismissed. For swipeToTigger it will be maximum siwpe offset.
  final double swipeThreshold;

  /// The direction in which the widget can be swiped.
  final SwipeDirection direction;

  /// The amount of time the widget will spend contracting before [onSwiped]
  /// is called. If null, the widget will not contract and [onSwiped] will
  /// be called immediately after the widget is swiped.
  final Duration? resizeDuration;

  /// Defines the duration for card to dismiss or to come back to original
  /// position if not swiped.
  final Duration movementDuration;

  /// Called when the widget has been swiped, after finishing resizing.
  final SwipedCallback onSwiped;

  /// Gives the app an opportunity to confirm or veto a pending swipe.
  /// If the returned Future<bool?> completes to false or null [onSwiped]
  /// callbacks will not run.
  final ConfirmSwipeCallback? confirmSwipe;

  /// The widget below this widget in the tree.
  final Widget child;

  final bool swipeToTigger;

  /// If there will be any elevation while swiping.
  final bool isEelevated;

  ///For basic swipe to dismiss. With slight elevation.
  ///
  /// The [key] argument must not be null because [SwipeableTile]s are commonly
  /// used in lists and removed from the list when swiped. Without keys, the
  /// default behavior is to sync widgets based on their index in the list,
  /// which means the item after the swiped item would be synced with the
  /// state of the swiped item. Using keys causes the widgets to sync
  /// according to their keys and avoids this pitfall.

  const SwipeableTile({
    required Key key,
    required this.child,
    required this.backgroundBuilder,
    required this.color,
    required this.onSwiped,
    this.swipeThreshold = 0.4,
    this.confirmSwipe,
    this.borderRadius = 8.0,
    this.direction = SwipeDirection.endToStart,
    this.resizeDuration = const Duration(milliseconds: 300),
    this.movementDuration = const Duration(milliseconds: 200),
    this.behavior = HitTestBehavior.opaque,
    this.isEelevated = true,
  })  : isCard = false,
        swipeToTigger = false,
        horizontalPadding = 0,
        verticalPadding = 1,
        shadow = const BoxShadow(color: Colors.black),
        assert(swipeThreshold > 0.0 && swipeThreshold < 1.0),
        super(key: key);

  /// Similar to normal [SwipeableTile] with additional card effet like,
  /// rounded corner, padding and elevation.
  ///
  /// The [key] argument must not be null because [SwipeableTile]s are commonly
  /// used in lists and removed from the list when swiped. Without keys, the
  /// default behavior is to sync widgets based on their index in the list,
  /// which means the item after the swiped item would be synced with the
  /// state of the swiped item. Using keys causes the widgets to sync
  /// according to their keys and avoids this pitfall.

  const SwipeableTile.card({
    required Key key,
    required this.child,
    required this.backgroundBuilder,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.shadow,
    required this.color,
    required this.onSwiped,
    this.borderRadius = 16,
    this.swipeThreshold = 0.4,
    this.confirmSwipe,
    this.direction = SwipeDirection.endToStart,
    this.resizeDuration = const Duration(milliseconds: 300),
    this.movementDuration = const Duration(milliseconds: 200),
    this.behavior = HitTestBehavior.opaque,
  })  : isCard = true,
        swipeToTigger = false,
        isEelevated = false,
        assert(swipeThreshold > 0.0 && swipeThreshold < 1.0),
        super(key: key);

  /// Similar to [SwipeableTile] but It doesn't allow dismiss instead you
  /// can swipe until [swipeThreshold] also doesn't have [confirmSwipe],
  /// [onSwiped], [resizeDuration]
  ///
  /// The [key] argument must not be null because [SwipeableTile]s are commonly
  /// used in lists and removed from the list when swiped. Without keys, the
  /// default behavior is to sync widgets based on their index in the list,
  /// which means the item after the swiped item would be synced with the
  /// state of the swiped item. Using keys causes the widgets to sync
  /// according to their keys and avoids this pitfall.

  const SwipeableTile.swipeToTigger({
    required Key key,
    required this.child,
    required this.backgroundBuilder,
    required this.color,
    required this.onSwiped,
    this.swipeThreshold = 0.4,
    this.borderRadius = 8.0,
    this.direction = SwipeDirection.endToStart,
    this.movementDuration = const Duration(milliseconds: 200),
    this.behavior = HitTestBehavior.opaque,
    this.isEelevated = true,
  })  : isCard = false,
        horizontalPadding = 0,
        verticalPadding = 1,
        confirmSwipe = null,
        // onSwiped = null,
        resizeDuration = null,
        swipeToTigger = true,
        shadow = const BoxShadow(color: Colors.black),
        assert(swipeThreshold > 0.0 && swipeThreshold <= 0.5),
        super(key: key);

  /// Similar to [SwipeableTile.swipeToTigger] with additional card effet like,
  /// rounded corner, padding and elevation.
  ///
  /// The [key] argument must not be null because [SwipeableTile]s are commonly
  /// used in lists and removed from the list when swiped. Without keys, the
  /// default behavior is to sync widgets based on their index in the list,
  /// which means the item after the swiped item would be synced with the
  /// state of the swiped item. Using keys causes the widgets to sync
  /// according to their keys and avoids this pitfall.

  const SwipeableTile.swipeToTiggerCard({
    required Key key,
    required this.child,
    required this.backgroundBuilder,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.shadow,
    required this.color,
    required this.onSwiped,
    this.borderRadius = 16,
    this.swipeThreshold = 0.4,
    this.direction = SwipeDirection.endToStart,
    this.movementDuration = const Duration(milliseconds: 200),
    this.behavior = HitTestBehavior.opaque,
  })  : isCard = true,
        swipeToTigger = true,
        confirmSwipe = null,
        isEelevated = false,
        resizeDuration = null,
        assert(swipeThreshold > 0.0 && swipeThreshold <= 0.5),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BuildTile(
      backgroundBuilder: backgroundBuilder,
      behavior: behavior,
      borderRadius: borderRadius,
      child: child,
      color: color,
      confirmSwipe: confirmSwipe,
      direction: direction,
      isCard: isCard,
      movementDuration: movementDuration,
      onSwiped: onSwiped,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      resizeDuration: resizeDuration,
      shadow: shadow,
      swipeThreshold: swipeThreshold,
      swipeToTigger: swipeToTigger,
      isEelevated: isEelevated,
    );
  }
}
