import 'package:Biquer/SplashScreen.dart';
import 'package:Biquer/screens/HomeScreen.dart';
import 'package:Biquer/screens/register/RegisterScreen.dart';
import 'package:Biquer/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    TextTheme textTheme(TextTheme appTheme) =>
        GoogleFonts.ubuntuTextTheme(appTheme);

    return MaterialApp(
      title: 'Biquer',
      theme: ThemeData(
          textTheme: textTheme(Theme.of(context).textTheme),
          accentColor: Colors.deepOrange,
          appBarTheme: Theme.of(context)
              .appBarTheme
              .copyWith(color: Utils.barcolor(context)),
          primaryColorDark: Colors.deepOrange,
          primaryColor: Colors.orange),
      darkTheme: ThemeData.dark().copyWith(
          textTheme: textTheme(ThemeData.dark().textTheme),
          appBarTheme: ThemeData.dark()
              .copyWith()
              .appBarTheme
              .copyWith(color: Utils.barcolor(context)),
          accentColor: Colors.deepOrange,
          primaryColorDark: Colors.deepOrange,
          primaryColor: Colors.orange),
      routes: {
        '/': (context) => SplashScreen(),
        '/register': (context) => RegisterScreen(),
        '/login': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
      },
      initialRoute: '/register',
    );
  }
}
