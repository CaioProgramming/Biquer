import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'file:///C:/Users/cacai/StudioProjects/Biquer/lib/model/service/ServiceStore.dart';

class ServiceScreen extends StatefulWidget {
  final FirebaseUser _user;

  ServiceScreen(this._user);

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  Widget serviceView = Center(
    child: CupertinoActivityIndicator(),
  );

  void getService() async {
    serviceView = await ServiceStore(widget._user).getServices(context);
    print('service view updated');
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getService();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: serviceView,
    );
  }
}
