import 'package:Biquer/model/ServiceData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import '../utils.dart';
import 'CategorySection.dart';
import 'ServiceForm.dart';
import 'ServicePreview.dart';

class NewServicePages extends StatefulWidget {
  @override
  _NewServicePagesState createState() => _NewServicePagesState();
}

class _NewServicePagesState extends State<NewServicePages> {
  PageController pageController = PageController();

  var currentPage = 0;

  @override
  Widget build(BuildContext context) {
    ServiceData serviceData = Provider.of(context);
    bool enabled() {
      switch (currentPage) {
        case 0:
          return serviceData.service.hasData();
        case 1:
          return serviceData.category() != null;
        default:
          return true;
      }
    }

    Widget actionButton() {
      print('current page $currentPage');
      if (currentPage <= 2) {
        return FloatingActionButton(
          elevation: 0,
          onPressed: enabled()
              ? () {
                  if (currentPage != 2) {
                    pageController.nextPage(
                        duration: Duration(seconds: 1), curve: Curves.easeIn);
                  } else {
                    serviceData.saveService();
                    pageController.nextPage(
                        duration: Duration(seconds: 1), curve: Curves.easeIn);
                  }
                }
              : null,
          child: Icon(
            currentPage != 2 ? AntDesign.right : AntDesign.check,
            color: Utils.barcolor(context),
          ),
          backgroundColor: enabled()
              ? Theme.of(context).textTheme.bodyText1.color
              : Theme.of(context).hintColor,
        );
      } else {
        return SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (position) {
                setState(() {
                  currentPage = position;
                });
              },
              children: [
                ServiceForm(),
                CategorySection(),
                ServicePreview(),
                serviceData.savingScreen()
              ],
            ),
          ),
          Positioned(bottom: 10, right: 10, child: actionButton())
        ],
      ),
    );
  }
}
