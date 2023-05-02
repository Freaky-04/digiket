import 'package:digikit/Pages/OpeningSplashScreen.dart';
import 'package:digikit/Pages/PublicTransportationFinder.dart';
import 'package:digikit/Pages/displayRoutes.dart';
import 'package:digikit/Pages/letsgo.dart';
import 'package:digikit/Pages/mainHomeScreen.dart';
import 'package:digikit/utils/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digikit',
      theme: DAppTheme.lightTheme,
      themeMode: ThemeMode.light,
      home: SplashScreen(),
    );
  }
}
