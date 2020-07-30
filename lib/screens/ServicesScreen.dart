import 'package:Biquer/model/service/ServiceData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceScreen extends StatefulWidget {
  final String categoryID, userID;

  ServiceScreen(this.userID, {this.categoryID});

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  Widget services = CupertinoActivityIndicator();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getServices();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: services,
    );
  }

  void getServices() async {
    services = await ServiceData().findUserServices(widget.userID, context);
    setState(() {});
  }
}
