import 'package:Biquer/model/RegisterData.dart';
import 'package:Biquer/screens/register/AdressForm.dart';
import 'package:Biquer/screens/register/SavingScreen.dart';
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
    bool saving = false;
    String message = 'Salvando informações';
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

    Color backColor() {
      switch (currentpage) {
        case 0:
          return Theme.of(context).primaryColor;
        case 1:
          return Colors.teal;
        case 2:
          return Colors.deepPurple;
      }
    }

    void nextPage(BuildContext context) async {
      controller.nextPage(
          duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    }

    void previousPage(BuildContext context) {
      controller.previousPage(
          duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    }

    return Scaffold(
      backgroundColor: backColor(),
      body: Container(
        child: SafeArea(
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
                    SelfieForm(pageController: controller),
                    SavingScreen()
                  ],
                ),
              ),
              Visibility(
                  visible: currentpage < 4 && canMoveForward(),
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: currentpage > 0,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () => previousPage(context),
                            child: Icon(AntDesign.arrowleft),
                          ),
                        ),
                        SizedBox(),
                        MaterialButton(
                          onPressed: () => nextPage(context),
                          child: Icon(AntDesign.arrowright),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
