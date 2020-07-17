import 'package:Biquer/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
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
      Sections(
          title: 'Últimos serviços',
          section: ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (context, index) => TransactionCard(),
          )),
    );

    sections.add(Sections(
      title: 'Serviços mais buscados',
      section: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 16, crossAxisSpacing: 16),
        itemBuilder: (context, index) => ServiceCard(),
        shrinkWrap: true,
        itemCount: 4,
      ),
    ));

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Utils.barcolor(context),
        centerTitle: true,
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: Padding(
            padding: EdgeInsets.all(1.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(user.photoUrl),
            ),
          ),
        ),
        title: Text(user.displayName),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Utils.barcolor(context),
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Theme.of(context).hintColor,
        elevation: 0,
        items: kbottombarIcons,
      ),
      body: Container(
        child: loading
            ? CupertinoActivityIndicator()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemBuilder: (context, index) => sections[index],
                  itemCount: sections.length,
                ),
              ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  final String caption, title;

  HomeHeader({this.caption, this.title});

  @override
  Widget build(BuildContext context) {
    return this.caption != null && this.title != null
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    caption,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontSize: 20),
                  ),
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  )
                ],
              ),
            ),
          )
        : SizedBox();
  }
}

class Sections extends StatelessWidget {
  final String title;
  final Widget section;

  Sections({this.title, this.section});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
        ),
        section
      ],
    );
  }
}

class ServiceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
              colors: [Colors.red.shade800, Colors.orange.shade900])),
      child: Stack(
        children: [
          Positioned(
            child: FadeInImage(
              image: NetworkImage(
                  'https://ferramentasinteligentes.com.br/wp-content/uploads/2016/10/Illustrator.png'),
              placeholder: AssetImage('images/chick.png'),
              fadeInDuration: Duration(seconds: 1),
            ),
            top: 70,
            right: 50,
            bottom: 0,
          ),
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Text(
              'Criação de logos',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 16),
            ),
          ),
          Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(15)),
                  color: Colors.green),
              child: Text(
                'R\$ 1000,00',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.white),
              ))
        ],
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(4),
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage('images/debavatar.jpeg'),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Debora',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          Text(
            'Desenvolvimento de app',
            style: Theme.of(context).textTheme.caption.copyWith(fontSize: 14),
          )
        ],
      ),
      trailing: Text(
        '+ 1500,00',
        style: TextStyle(color: Colors.green),
      ),
      dense: true,
    );
  }
}
