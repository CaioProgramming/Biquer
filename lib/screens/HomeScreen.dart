import 'package:Biquer/components/HomeHeader.dart';
import 'package:Biquer/components/Section.dart';
import 'package:Biquer/components/TransactionCard.dart';
import 'package:Biquer/screens/ServicesScreen.dart';
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
  bool loading = true;
  FirebaseUser user;

  Widget serviceSection() {
    return Section(
      title: 'Seus serviços',
      section: ServiceScreen(this.user),
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
        title: 'Últimas transações',
        section: ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) => TransactionCard(),
        ));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => {
          setState(() {
            user = ModalRoute.of(context).settings.arguments;
            loading = false;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Utils.barcolor(context),
        centerTitle: true,
        title: Text(user.displayName),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: kbottombarIcons,
        unselectedItemColor: Theme.of(context).hintColor,
        selectedItemColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        child: loading
            ? CupertinoActivityIndicator()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      headerSection(),
                      transactionsSection(),
                      serviceSection()
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
