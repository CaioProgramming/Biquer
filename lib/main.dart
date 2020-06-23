import 'package:Biquer/model/BiquerData.dart';
import 'package:Biquer/screens/register/RegisterScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth.currentUser().then((user) {
      if (user != null) {
        print('user ${user.displayName}');
      }
      setState(() {
        loggedUser = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.orange, // status bar color
    ));

    return ChangeNotifierProvider(
      create: (context) => BiquerData(loggedUser),
      child: MaterialApp(
          title: 'Biquer',
          theme: ThemeData(
              fontFamily: 'Roboto',
              accentColor: Colors.deepOrange,
              primaryColorDark: Colors.deepOrange,
              primaryColor: Colors.orange,
              backgroundColor: Colors.white),
          darkTheme: ThemeData.dark(),
          home: Scaffold(
            body: RegisterScreen(),
          )),
    );
  }
}
