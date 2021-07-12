
<p align="center">
<img src="https://raw.githubusercontent.com/watery-desert/assets/main/watery_desert/logo.png" height="200" alt="Water Drop Nav Bar" />
</p>

<div align="center">

[![Instagram Badge](https://img.shields.io/badge/-watery_desert-e84393?style=flat-square&labelColor=e84393&logo=instagram&logoColor=white)](https://instagram.com/watery_desert)
[![Twitter Badge](https://img.shields.io/badge/-watery_desert-1ca0f1?style=flat-square&logo=twitter&logoColor=white&link=https://twitter.com/watery_desert)](https://twitter.com/watery_desert)
</div>

# SwipeableTile

<img src="https://raw.githubusercontent.com/watery-desert/assets/main/swipeable_tile/demo_recording.gif"  width="500"/>


The package is fork of [Dismissible](https://api.flutter.dev/flutter/widgets/Dismissible-class.html). Without any vertical, up and down swipe.

### So what problem does this package solve?

1. The Dismissible widget doesn't allow animated rounded corner and elevation similar to google Gmail, Telegram, Messages (these are android apps) if you swipe you will notice. Here is the result with Dismissible.

<p align="left">
<img src="https://raw.githubusercontent.com/watery-desert/assets/main/swipeable_tile/dismissible_issue1.png" height="200"/>

<img src="https://raw.githubusercontent.com/watery-desert/assets/main/swipeable_tile/dismissible_issue2.png" height="200"/>
</p>

2. The Dismissible widget can't make rounded Card there is always some UI issue. As a UI designer I can't live with this. Here is the result with Dismissible.

<p align="left">
<img src="https://raw.githubusercontent.com/watery-desert/assets/main/swipeable_tile/dismissible_issue3.png" height="200"/>

<img src="https://raw.githubusercontent.com/watery-desert/assets/main/swipeable_tile/dismissible_issue4.png" height="200"/>
</p>

3. I wanted to animated the background as I swipe not just elevation or rounded corner which is not possible. 

4. Finally in some situation I just don't wanna dismiss. I wanna swipe to tigger some action which not possible. Telegram has somthing similar where user can swipe to reply, I love this UX.

### **Do and don't**
 - Don't call `setState()` from `backgroundBuilder`.
 - Set the `Scaffold`'s (or whatever background widget you are using) `backgroundColor` and `SwipeableTile`'s `color` same.

## How to use?

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


**There are found named constructor:**

1. `SwipeableTile` This is just basic tile when you swipe there will be a, you can remove it by setting `isEelevated` to false. The corner will be rounded when dragged.

2. `SwipeableTile.card` This will make the tile look like card with rounded corner (will also be applied to the background) which will not animate unlike `SwipeableTile`. You also have to set the padding which will wrap around the tile as well background.

3. `SwipeableTile.swipeToTigger` This is exactly the same as `SwipeableTile` but instead of dismiss it will return back to initial position when maximum drag reaches `swipeThreshold`

4. `SwipeableTile.swipeToTiggerCard` This is exactly the same as `SwipeableTile.card` but instead of dismiss it will return back to initial position when maximum drag reaches `swipeThreshold`

### Use case of swipe to tigger:
If you don't wanna swipe to dismiss instead you wanna slide or drag to a certain percentage to tigger something like, make done a task or rescheduled (show date picker) or add item to cart, you don't wanna remove from the list but still wanna do it without any extra button. And of course telegram swipe.

### How to Telegram swipe to reply?

It's not possible to create the exact same effect like telegram. In Telegram when user swipes or drags after and a certain percent the icon appears with vibration (still dragable little), at this point if the user leaves then it selects that message and the tile returns back to initial position. But if the user drag back then the icon disappers (with vibration) leaving at this point will not cause any message select. It's possible to do from `backgroundBuilder` using `progress` parameter but to select exact message (or tile) requires calling `setState()` which is not possible from `backgroundBuilder` however you can call `setState()` from `onSwiped` callback which will invoke when the tile return to initial position. 

If you don't care about exact telegram UI & UX then vibrate & animate the icon when it's dragged maximum by checking `progress.isCompleted` or you can check animation value. Then call `setState()` from `onSwiped` User will not notice unless you set `movementDuration` to longer time and `swipeThreshold` to 0.4 (which is default). Check the example app how it's implemented.


