import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttie/fluttie.dart';

import 'HomeScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),
    home: SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/HomeScreen': (BuildContext context) => new HomeScreen()
    },
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// Animation to display a shocked emoji taken from lottiefiles.com
  FluttieAnimationController shockedEmoji;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/HomeScreen');
  }

  @override
  void initState() {
    super.initState();
    startTime();
    prepareAnimation();
  }

  prepareAnimation() async {
    // Checks if the platform we're running on is supported by the animation plugin
    bool canBeUsed = await Fluttie.isAvailable();
    if (!canBeUsed) {
      print("Animations are not supported on this platform");
      return;
    }

    var instance = Fluttie();

    // Load our first composition for the emoji animation
    var emojiComposition =
        await instance.loadAnimationFromAsset("assets/bin.json");
    // And prepare its animation, which should loop infinitely and take 2s per
    // iteration. Instead of RepeatMode.START_OVER, we could have choosen
    // REVERSE, which would play the animation in reverse on every second iteration.
    shockedEmoji = await instance.prepareAnimation(emojiComposition,
        duration: const Duration(seconds: 3),
        repeatCount: const RepeatCount.infinite(),
        repeatMode: RepeatMode.START_OVER);

    setState(() {
      shockedEmoji.start();
    });

    // Load the composition for our star animation. Notice how we only have to
    // load the composition once, even though we're using it for 5 animations!

    // Create the star animation with the default setting. 5 times. The
    // preferredSize needs to be set because the original star animation is quite
    // small. See the documentation for the method prepareAnimation for details.

    // Loading animations may take quite some time. We should check that the
    // widget is still used before updating it, it might have been removed while
    // we were loading our animations!
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                width: 200.0,
                height: 200.0,
                child: FluttieAnimation(shockedEmoji)),
            Text(
              "Save world !",
              style: TextStyle(fontSize: 40, color: Colors.green),
            )
          ],
        ),
      ),
    );
  }
}
