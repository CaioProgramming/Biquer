import 'package:Biquer/components/HomeHeader.dart';
import 'package:Biquer/components/Section.dart';
import 'package:Biquer/screens/ServicesScreen.dart';
import 'package:Biquer/screens/TransactionsScreen.dart';
import 'package:Biquer/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  static String screenRoute = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseUser user;

  Widget serviceSection() {
    return Section(
      title: 'Seus serviços',
      section: ServiceScreen(user.uid),
    );
  }

  Widget headerSection() {
    return HomeHeader(
      title: Utils.moneyText(2000),
      caption: 'Você já lucrou',
    );
  }

  Widget transactionsSection() {
    return Section(
        title: 'Últimas transações', section: TransactionsScreen(user.uid));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => {
          setState(() {
            user = ModalRoute.of(context).settings.arguments;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return user == null
        ? Center(child: CupertinoActivityIndicator())
        : Scaffold(
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Utils.barcolor(context),
              centerTitle: true,
              leading: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Text(
                    'Bico',
                    style: GoogleFonts.bangers(
                        color: Theme.of(context).primaryColor, fontSize: 30),
                  ),
                ),
              ),
              title: Text(user.displayName),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.redAccent,
              items: kbottombarIcons,
              unselectedItemColor: Theme.of(context).hintColor,
              selectedItemColor: Theme.of(context).primaryColor,
            ),
            body: SafeArea(child: MainScreen(user.uid)),
          );
  }
}

class MainScreen extends StatelessWidget {
  final String userID;

  MainScreen(this.userID);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeHeader(
                title: Utils.moneyText(2000),
                caption: 'Você já lucrou',
              ),
              Section(
                  title: 'Últimas transações',
                  section: TransactionsScreen(userID)),
              Section(
                title: 'Seus serviços',
                section: ServiceScreen(userID),
              )
            ],
          ),
        ),
      ),
    );
  }
}
