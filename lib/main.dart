import 'package:biquerapp/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.orange, // status bar color
    ));
    return MaterialApp(
        title: 'Biquer',
        theme: ThemeData(
            fontFamily: 'Roboto',
            accentColor: Colors.deepOrange,
            primaryColorDark: Colors.deepOrange,
            primaryColor: Colors.orange,
            backgroundColor: Colors.white),
        home: Scaffold(
          body: RegisterScreen(),
        ));
  }
}
