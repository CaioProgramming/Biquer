import 'dart:async';

import 'package:Biquer/constants.dart';
import 'package:Biquer/model/RegisterData.dart';
import 'package:Biquer/screens/register/AdressForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import 'DocumentForm.dart';
import 'RegisterForm.dart';
import 'SelfieForm.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  PageController controller = PageController(initialPage: 0);
  int currentpage = 0;

  @override
  Widget build(BuildContext context) {
    RegisterData _biquerData = Provider.of<RegisterData>(context);

    bool canMoveForward() {
      switch (currentpage) {
        case 0:
          return _biquerData.userLogged();
        case 1:
          return _biquerData.userAddress != null &&
              _biquerData.userAddress.addressComplete();
        case 2:
          return _biquerData.userDocument != null &&
              _biquerData.userDocument.isDocComplete();
        default:
          return _biquerData.userPicURL != null;
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(currentpage == 0 ? AntDesign.close : AntDesign.arrowleft),
          onPressed: () {
            previousPage(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (index) {
                  currentpage = index;
                  setState(() {});
                },
                physics: NeverScrollableScrollPhysics(),
                children: [
                  RegisterForm(),
                  AddressForm(),
                  DocumentForm(),
                  SelfieForm(pageController: controller)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(4),
              child: RaisedButton(
                padding: EdgeInsets.all(20),
                elevation: 0,
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(borderRadius: kDefaultBorder),
                onPressed: !canMoveForward()
                    ? null
                    : () {
                  nextPage(context);
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Continuar'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void nextPage(BuildContext context) async {
    if (currentpage < 3) {
      controller.nextPage(
          duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    } else {
      showDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
                content: CupertinoActivityIndicator(),
                title: Text('Salvando informações'),
              ),
          barrierDismissible: false);
      RegisterData _biquerData = Provider.of<RegisterData>(context);
      bool saved = await _biquerData.saveUserInfo();
      if (saved) {
        showDialog(
            context: context,
            builder: (_) => CupertinoAlertDialog(
                  content: CupertinoActivityIndicator(),
                  title: Text('Cadastro concluído com sucesso!'),
                ),
            barrierDismissible: true);
        Timer(Duration(seconds: 5), () => Navigator.pop(context));
      } else {
        showDialog(
            context: context,
            builder: (_) => CupertinoAlertDialog(
                  content: CupertinoActivityIndicator(),
                  title: Text('Ocorreu um erro durante o cadastro!'),
                ),
            barrierDismissible: true);
      }
    }
  }

  void previousPage(BuildContext context) {
    controller.previousPage(
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }
}
