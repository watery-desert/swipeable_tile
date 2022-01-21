<p align="center">
   <img src="https://raw.githubusercontent.com/watery-desert/assets/main/swipeable_tile/package_cover.png" alt="Loading Animation Widget" />
</p>


<div align="center">

[![Instagram Badge](https://img.shields.io/badge/-Instagram-e84393?style=for-the-badge&labelColor=e84393&logo=instagram&logoColor=white)](https://instagram.com/watery_desert)
[![Twitter Badge](https://img.shields.io/badge/-Twitter-1ca0f1?style=for-the-badge&logo=twitter&logoColor=white&link=https://twitter.com/watery_desert)](https://twitter.com/watery_desert)
[![pub package](https://img.shields.io/pub/v/swipeable_tile.svg?style=for-the-badge)](https://pub.dev/packages/swipeable_tile)
</div>

<hr>

#### ⚠️  If you like this package please consider supporting me. This will help me to maintain free and open source flutter packages.

<a href="https://www.buymeacoffee.com/watery_desert"><img src="https://raw.githubusercontent.com/watery-desert/assets/main/watery_desert/bmc-button.png" height="56"></a>

<div>

<img src="https://raw.githubusercontent.com/watery-desert/assets/main/swipeable_tile/demo_recording.gif"  width="400"/>


The package is fork of [Dismissible](https://api.flutter.dev/flutter/widgets/Dismissible-class.html). Without any vertical, up and down swipe.

### Problems with dismissible

1. Dismissible doesn't allow animated rounded corner and elevation similar to google Gmail, Telegram, Messages (these are android apps) if you swipe you will notice. Here is the result with Dismissible.

<p align="left">
<img src="https://raw.githubusercontent.com/watery-desert/assets/main/swipeable_tile/dismissible_issue1.png" height="200"/>

<img src="https://raw.githubusercontent.com/watery-desert/assets/main/swipeable_tile/dismissible_issue2.png" height="200"/>
</p>

2. Dismissible can't make rounded Card there is always some UI issue. Here is the result with Dismissible.

<p align="left">
<img src="https://raw.githubusercontent.com/watery-desert/assets/main/swipeable_tile/dismissible_issue3.png" height="200"/>

<img src="https://raw.githubusercontent.com/watery-desert/assets/main/swipeable_tile/dismissible_issue4.png" height="200"/>
</p>

3. It's not possible to animated the background while swiping.

4. Swipe to tigger action function. Similar to telegram or instagram DM message reply.

### Do and don't
 - Don't call `setState()` from `backgroundBuilder`.
 - Set the `Scaffold`'s (or whatever background widget you are using) `backgroundColor` and `SwipeableTile` or `SwipeableTile.swipeToTigger`'s `color` same.

## How to use?

#### Installation

Add `swipeable_tile` to your `pubspec.yaml` dependencies then run `flutter pub get`

```yaml
 dependencies:
  swipeable_tile:
```

#### Import
Add this line to import the package.

```dart 
import 'package:swipeable_tile/swipeable_tile.dart';
```

### There are four named constructors:

1. `SwipeableTile` This is the basic tile when you swipe there will be a, you can remove it by setting `isEelevated` to false. The corner will be rounded when dragged.

```dart
SwipeableTile(
  color: Colors.white,
  swipeThreshold: 0.2,
  direction: SwipeDirection.horizontal,
  onSwiped: (direction) {// Here call setState to update state
  },
  backgroundBuilder: (context, direction, progress) {
    if (direction == SwipeDirection.endToStart) {
      // return your widget
    } else if (direction == SwipeDirection.startToEnd) {
      // return your widget
    }
    return Container();
  },
  key: UniqueKey(),
  child: // Here Tile which will be shown at the top
),

```

2. `SwipeableTile.card` This will make the tile look like card with rounded corner which will not animate unlike `SwipeableTile`. You also have to set the padding which will wrap around the tile as well background.

```dart
SwipeableTile.card(
  color: Color(0xFFab9ee8),
  shadow: BoxShadow(
    color: Colors.black.withOpacity(0.35),
    blurRadius: 4,
    offset: Offset(2, 2),
  ),
  horizontalPadding: 16,
  verticalPadding: 8,
  direction: SwipeDirection.horizontal,
  onSwiped: (direction) {
    // Here call setState to update state
  },
  backgroundBuilder: (context, direction, progress) {
      // You can animate background using the progress
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          color: progress.value > 0.4
              ? Color(0xFFed7474)
              : Color(0xFFeded98),
        );
      },
    );
  },
  key: UniqueKey(),
  child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: // Here Tile which will be shown at the top
  ),
),
```

3. `SwipeableTile.swipeToTigger` This is exactly the same as `SwipeableTile` but instead of dismiss it, tile will return back to initial position when maximum drag reaches `swipeThreshold`

4. `SwipeableTile.swipeToTiggerCard` This is exactly the same as `SwipeableTile.card` but instead of dismiss it will return back to initial position when maximum drag reaches `swipeThreshold`



You can build the background dynamically and animate them using `backgroundBuilder`. Use `direction` parameter to check swipe direction and show different widget. 

 ```dart 
 backgroundBuilder: (context, direction, progress) {
    if (direction == SwipeDirection.endToStart) {
        return Container(color: Colors.red);
    } else if (direction == SwipeDirection.startToEnd) {
        return Container(color: Colors.blue);
    }
    return Container();
},
```

And the `progress` is basically the same animation controller responsible for tile slide animation. You can use this controller and animate the background.

To tigger vibration you have to check when tile is dragged certain animation controller value. And I used [vibration package](https://pub.dev/packages/vibration) for vibration and worked batter than [HapticFeedback](https://api.flutter.dev/flutter/services/HapticFeedback-class.html)

```dart
backgroundBuilder: (context, direction, progress) {
    bool vibrated = false;
    return AnimatedBuilder(
        animation: progress,
        builder: (context, child) {
        if (progress.value > 0.2 && !vibrated) {
            Vibration.vibrate(duration: 40);
            vibrated = true;
        } else if (progress.value < 0.2) {
            vibrated = false;
        }
    // return your background
        },
    );
},
```

`swipeThreshold` defines how far you can drag and will consider as dismiss. In case of swipe to tigger this will define maximun drag limit.


### How to swipe to tigger action?

It's possible to do from `backgroundBuilder` using `progress` parameter but to select exact message (or tile) requires calling `setState()` which is not possible from `backgroundBuilder` however you can call `setState()` from `onSwiped` callback which will invoke when the tile return to initial position. 

Vibrate & animate the icon when it's dragged maximum by checking `progress.isCompleted` or you can check animation value. Then call `setState()` from `onSwiped` User will not notice unless you set `movementDuration` to longer time and `swipeThreshold` to 0.4 (which is default). Check the example app how it's implemented.


<br>
<details>
   <summary>All flutter packages</summary>
   <br>

  ● [Sliding Clipped Nav Bar](https://github.com/watery-desert/sliding_clipped_nav_bar)\
  ● [Water Drop Nav Bar](https://github.com/watery-desert/water_drop_nav_bar)\
  ➜ [Swipeable Tile](https://github.com/watery-desert/swipeable_tile)\
  ● [Loading Animation Widget](https://github.com/watery-desert/loading_animation_widget)

   </summary> 
</details>
<br>
