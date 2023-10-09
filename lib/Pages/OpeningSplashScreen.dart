import 'dart:async';
import 'package:rive/rive.dart';
import 'package:digikit/Pages/locationAccess.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 6),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => GetLocationAccess())));

    return Scaffold(
      body: Center(
        child: RiveAnimation.asset(
          'assets/splash_screen.riv',
          fit: BoxFit.fitWidth,
        ),
      )

      // Column(
      //   // mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //
      //     // Image(
      //     //   image: new AssetImage('assets/logo.png'),
      //     //   width: 200.0,
      //     // ),
      //     // Center(
      //     //   child: Text(
      //     //     "Digikit",
      //     //     style: TextStyle(fontSize: 50.0),
      //     //   ),
      //     // )
      //   ],
      // ),
    );
  }
}
