import 'package:Biquer/components/service/NewServicePages.dart';
import 'package:Biquer/model/service/BicoData.dart';
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
  String uid;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      uid = ModalRoute.of(context).settings.arguments;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: (IconButton(
            icon: Icon(AntDesign.close),
            onPressed: () {
              Navigator.pop(context);
            })),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: uid == null
          ? Center(child: CupertinoActivityIndicator())
          : ChangeNotifierProvider(
              create: (context) => BicoData(uid),
              child: NewServicePages(),
            ),
    );
  }
}
