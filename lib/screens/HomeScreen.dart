import 'package:Biquer/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Utils.barcolor(context),
        leading: CircleAvatar(
          radius: 10,
          backgroundImage: NetworkImage(user.photoUrl),
        ),
        title: Text(user.displayName),
      ),
      body: Container(
        child: loading ? CupertinoActivityIndicator() : SizedBox(),
      ),
    );
  }
}
