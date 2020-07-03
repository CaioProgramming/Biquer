import 'package:Biquer/constants.dart';
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

    void nextPage(BuildContext context) async {
      controller.nextPage(
          duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    }

    void previousPage(BuildContext context) {
      controller.previousPage(
          duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: currentpage == 4
            ? null
            : IconButton(
                icon: Icon(
                    currentpage == 0 ? AntDesign.close : AntDesign.arrowleft),
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
                  SelfieForm(pageController: controller),
                  SavingScreen()
                ],
              ),
            ),
            currentpage != 4
                ? Container(
              margin: EdgeInsets.all(4),
              child: MaterialButton(
                padding: EdgeInsets.all(20),
                elevation: 0,
                color: currentpage < 3 ? Colors.blueAccent : Colors.green,
                shape:
                RoundedRectangleBorder(borderRadius: kDefaultBorder),
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
                        currentpage < 3 ? 'CONTINUAR' : 'CONCLUIR',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
            )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
