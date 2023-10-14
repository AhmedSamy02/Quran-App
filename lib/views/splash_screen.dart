import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quran_app/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        opc = 1;
      });
    });
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, kHomeScreen);
    });
  }

  var image = 'assets/images/starting_splash_background.png';
  var opc = 0.0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          image,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: AnimatedOpacity(
            duration: Duration(seconds: 2),
            opacity: opc,
            child: Align(
              alignment: Alignment.lerp(
                Alignment.topCenter,
                Alignment.bottomCenter,
                0.25,
              )!,
              child: Image.asset('assets/images/first_logo.png'),
            ),
          ),
        ),
      ],
    );
  }
}
