import 'dart:ui';

import 'package:Biquer/constants.dart';
import 'package:Biquer/screens/register/RegisterScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class LoginScreen extends StatelessWidget {
  static String screenRoute = '/Login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Expanded(
              child: FadeInImage(
                  placeholder: AssetImage(''),
                  image: NetworkImage(kLoginImage)),
            ),
            Text(
              'Bem-vindo a Bico',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 40),
            ),
            Text(
              'A sua nova maneira de trabalhar e arranjar aquela renda extra que você sempre quis em suas mãos! Afinal um bico é sempre bom né?',
              textAlign: TextAlign.center,
            ),
            Container(
              margin: kDefaultMargin,
              child: MaterialButton(
                color: Colors.black,
                disabledColor: Theme.of(context).hintColor.withOpacity(0.50),
                shape: RoundedRectangleBorder(borderRadius: kDefaultBorder),
                padding: EdgeInsets.all(0),
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(),
                      Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: kDefaultBorder),
                        child: Icon(AntDesign.arrowright),
                      )
                    ],
                  ),
                ),
              ),
            ),
            CupertinoButton(
              child: Text('Não possui conta? Registre-se agora'),
              onPressed: () => Navigator.popAndPushNamed(
                  context, RegisterScreen.screenRoute),
            )
          ],
        ),
      )),
    );
  }
}
