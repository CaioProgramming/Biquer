import 'package:Biquer/model/user/UserData.dart';
import 'package:Biquer/screens/LoginScreen.dart';
import 'package:Biquer/screens/register/RegisterScreen.dart';
import 'package:Biquer/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import 'MainScreen.dart';

class HomeScreen extends StatefulWidget {
  static String screenRoute = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        user = ModalRoute.of(context).settings.arguments;
      });
      checkUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return user == null
        ? Center(child: CupertinoActivityIndicator())
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: Center(
                child: Text(
                  'Bico',
                  style: GoogleFonts.bangers().copyWith(
                      color: Theme.of(context).primaryColorDark, fontSize: 30),
                ),
              ),
              backgroundColor: Utils.barcolor(context),
              actions: [
                CupertinoButton(
                    child: Text(
                      'Sair',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () async {
                      await UserData().signOut();
                      Navigator.popAndPushNamed(
                          context, LoginScreen.screenRoute);
                    })
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: kbottombarIcons,
              unselectedItemColor: Theme.of(context).hintColor,
              selectedItemColor: Theme.of(context).primaryColor,
            ),
            body: SafeArea(child: MainScreen(user)),
          );
  }

  void checkUser() async {
    print('Checking user');
    bool registered = await UserData().checkUser(user.uid);
    print('user registered? $registered');
    if (!registered) {
      showDialog(
          context: context,
          barrierDismissible: false,
          child: CupertinoAlertDialog(
            title: Text('Atenção ${user.displayName}!'),
            content: Text('Seu cadastro está incompleto'),
            actions: [
              CupertinoButton(
                child: Text('Finalizar cadastro'),
                onPressed: () => Navigator.popAndPushNamed(
                    context, RegisterScreen.screenRoute,
                    arguments: user),
              )
            ],
          ));
    }
  }
}
