import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:fast_and_yummy/HomePage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 120,
      splash: const RiveAnimation.asset("assets/raeds.riv"),
      nextScreen: HomePage(),
      duration: 3500,
      backgroundColor: Colors.white,
    );
  }
}
