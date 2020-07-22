import 'dart:async';

import 'package:Biquer/components/NewServicePages.dart';
import 'package:Biquer/model/ServiceData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class NewService extends StatefulWidget {
  static String screenRoute = '/newService';

  @override
  _NewServiceState createState() => _NewServiceState();
}

class _NewServiceState extends State<NewService> {
  var currentPage = 0;
  bool loading = true;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        user = ModalRoute.of(context).settings.arguments;
      });
      Timer(Duration(seconds: 2), () {
        setState(() {
          loading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: (IconButton(
            icon: Icon(AntDesign.close),
            onPressed: () => Navigator.pop(context))),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: loading
          ? Center(child: CupertinoActivityIndicator())
          : ChangeNotifierProvider(
              create: (context) => ServiceData(this.user),
              child: NewServicePages(),
            ),
    );
  }
}
