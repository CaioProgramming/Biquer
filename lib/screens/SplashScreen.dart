import 'dart:ui';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Bico',
        style: TextStyle(
            fontSize: 32,
            color: Colors.orange,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic),
      ),
    );
  }
}
