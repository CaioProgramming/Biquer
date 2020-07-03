import 'dart:async';

import 'package:Biquer/model/RegisterData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class SavingScreen extends StatefulWidget {
  @override
  _SavingScreenState createState() => _SavingScreenState();
}

class _SavingScreenState extends State<SavingScreen> {
  String message = "Salvando informações";
  bool saved = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => saveUser());
  }

  void saveUser() async {
    print('Saving user');
    RegisterData _biquerData = Provider.of<RegisterData>(context);
    saved = await _biquerData.saveUserInfo();

    if (saved) {
      setState(() {
        message = 'Cadastro concluído com sucesso';
        Timer(Duration(seconds: 5), () {
          Navigator.pop(context);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        saved ? Icon(AntDesign.check) : CupertinoActivityIndicator(),
        Text(message),
      ],
    );
  }
}
