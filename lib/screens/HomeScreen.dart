import 'package:Biquer/components/Section.dart';
import 'package:Biquer/model/user/UserData.dart';
import 'package:Biquer/screens/LoginScreen.dart';
import 'package:Biquer/screens/ServicesScreen.dart';
import 'package:Biquer/screens/TransactionsScreen.dart';
import 'package:Biquer/screens/register/RegisterScreen.dart';
import 'package:Biquer/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../constants.dart';

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
              backgroundColor: Utils.barcolor(context),
              leading: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: Theme
                              .of(context)
                              .primaryColor, width: 1),
                      image:
                      DecorationImage(image: NetworkImage(user.photoUrl))),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Olá, ${user.displayName}'),
                  Text(
                    'Você já lucrou ${Utils.moneyText(2000)}',
                    style: Theme
                        .of(context)
                        .textTheme
                        .caption,
                  ),
                ],
              ),
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
        unselectedItemColor: Theme
            .of(context)
            .hintColor,
        selectedItemColor: Theme
            .of(context)
            .primaryColor,
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
                onPressed: () =>
                    Navigator.popAndPushNamed(
                        context, RegisterScreen.screenRoute,
                        arguments: user),
              )
            ],
          ));
    }
  }
}

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
            children: [
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
