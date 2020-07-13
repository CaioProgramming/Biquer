import 'package:Biquer/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseUser user;
  bool loading = true;
  final _auth = FirebaseAuth.instance;

  getUser() async {
    user = await _auth.currentUser();
    if (user != null) {
      print('user ${user.displayName}');
      setState(() {
        user = user;
        Navigator.pushNamed(context, '/home', arguments: user);
      });
    } else {
      Navigator.pushNamed(context, '/register');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    Utils.setBarAndNavColor(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'images/toucan.svg',
                width: 100,
                height: 100,
              ),
              Visibility(visible: loading, child: CupertinoActivityIndicator())
            ],
          ),
        ),
      ),
    );
  }
}
