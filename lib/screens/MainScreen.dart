import 'package:Biquer/components/Section.dart';
import 'package:Biquer/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ServicesScreen.dart';
import 'TransactionsScreen.dart';

class MainScreen extends StatelessWidget {
  final FirebaseUser user;

  MainScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          color: Utils.barcolor(context)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Lucro total',
                    style: TextStyle(fontWeight: FontWeight.w100, fontSize: 12),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Text(
                      Utils.moneyText(2000),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Section(
                  title: 'Últimas transações',
                  section: TransactionsScreen(user.uid)),
              Section(
                title: 'Seus serviços',
                section: ServiceScreen(user.uid),
              )
            ],
          ),
        ),
      ),
    );
  }
}
