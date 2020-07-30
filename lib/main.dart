import 'package:Biquer/SplashScreen.dart';
import 'package:Biquer/screens/HomeScreen.dart';
import 'package:Biquer/screens/LoginScreen.dart';
import 'package:Biquer/screens/NewServiceScreen.dart';
import 'package:Biquer/screens/register/RegisterScreen.dart';
import 'package:Biquer/utils.dart';
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
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme(TextTheme appTheme) =>
        GoogleFonts.latoTextTheme(appTheme);

    return MaterialApp(
      title: 'Biquer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: textTheme(Theme.of(context).textTheme),
          accentColor: Colors.deepOrange,
          scaffoldBackgroundColor: Colors.white,
          canvasColor: Colors.white,
          appBarTheme: Theme.of(context)
              .appBarTheme
              .copyWith(color: Utils.barcolor(context)),
          primaryColorDark: Colors.deepOrange,
          primaryColor: Colors.orange),
      darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          canvasColor: Colors.black,
          textTheme: textTheme(ThemeData.dark().textTheme),
          appBarTheme: ThemeData.dark()
              .copyWith()
              .appBarTheme
              .copyWith(color: Utils.barcolor(context)),
          accentColor: Colors.deepOrange,
          primaryColorDark: Colors.deepOrange,
          primaryColor: Colors.orange),
      routes: {
        SplashScreen.screenRoute: (context) => SplashScreen(),
        RegisterScreen.screenRoute: (context) => RegisterScreen(),
        LoginScreen.screenRoute: (context) => LoginScreen(),
        HomeScreen.screenRoute: (context) => HomeScreen(),
        NewService.screenRoute: (context) => NewService()
      },
      initialRoute: NewService.screenRoute,
    );
  }
}
