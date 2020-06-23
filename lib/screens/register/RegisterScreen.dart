import 'package:Biquer/model/BiquerData.dart';
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
    BiquerData _biquerData = Provider.of<BiquerData>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(currentpage == 0 ? AntDesign.close : AntDesign.arrowleft),
          onPressed: () {
            if (currentpage != 0) {
              controller.previousPage(
                  duration: Duration(milliseconds: 500), curve: Curves.easeIn);
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            PageView(
              controller: controller,
              onPageChanged: (index) {
                currentpage = index;
                setState(() {});
              },
              physics: NeverScrollableScrollPhysics(),
              children: [
                RegisterForm(),
                DocumentForm(),
                SelfieForm(pageController: controller)
              ],
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Visibility(
                visible: _biquerData.user != null,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor:
                      currentpage == 2 ? Colors.green : Colors.blue,
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(
                      currentpage == 2
                          ? Feather.check
                          : FlutterIcons.arrow_right_fea,
                    ),
                    onPressed: () {
                      controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
