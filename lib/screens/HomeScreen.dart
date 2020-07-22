import 'package:Biquer/components/HomeHeader.dart';
import 'package:Biquer/components/Section.dart';
import 'package:Biquer/components/ServiceCard.dart';
import 'package:Biquer/components/TransactionCard.dart';
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

  @override
  void initState() {
    // TODO: implement initState
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
    List<Widget> sections = [];

    sections.add(HomeHeader(
      title: 'R\$ 5000,00',
      caption: 'Você já lucrou',
    ));

    sections.add(
      Section(
          title: 'Últimos serviços',
          section: ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (context, index) => TransactionCard(),
          )),
    );

    sections.add(Section(
      title: 'Serviços mais buscados',
      section: Container(
        width: double.infinity,
        height: 500,
        child: PageView.builder(
            itemBuilder: (context, index) => ServiceCard(), itemCount: 4),
      ),
    ));

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
                    children: sections,
                  ),
                ),
              ),
      ),
    );
  }
}
