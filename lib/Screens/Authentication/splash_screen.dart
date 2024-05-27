import 'dart:async';

import 'package:flutter/material.dart';
import 'package:starsmeetupcelebrity/Utilities/app_colors.dart';
import 'package:starsmeetupcelebrity/Utilities/app_routes.dart';

import '../../LocalStorage/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    splashNavigator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: purpleGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo.png",
                scale: 1,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  splashNavigator() {
    Timer(const Duration(seconds: 3), () {
      if (MyPreferences.instance.user != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, homeScreenRoute, (route) => false,arguments: true);
      } else {
        Navigator.pushNamed(context, loginScreenRoute);
      }
    },
    );
  }
}
