import 'dart:ui';

import 'package:Biquer/components/CategorySection.dart';
import 'package:Biquer/components/ServiceForm.dart';
import 'package:Biquer/components/ServicePreview.dart';
import 'package:Biquer/model/ServiceData.dart';
import 'package:Biquer/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class NewService extends StatefulWidget {
  static String screenRoute = '/newService';

  @override
  _NewServiceState createState() => _NewServiceState();
}

class _NewServiceState extends State<NewService> {
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    int currentPage = 0;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: ChangeNotifierProvider(
        create: (context) => ServiceData(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Expanded(
                child: PageView(
                  controller: pageController,
                  onPageChanged: (position) {
                    currentPage = position;
                    print(currentPage);
                    setState(() {});
                  },
                  children: [
                    ServiceForm(),
                    CategorySection(),
                    ServicePreview()
                  ],
                ),
              ),
              Positioned(
                  bottom: 10,
                  right: 10,
                  child: currentPage < 2
                      ? FloatingActionButton(
                          onPressed: () {
                            pageController.nextPage(
                                duration: Duration(seconds: 1),
                                curve: Curves.easeIn);
                          },
                          child: Icon(
                            AntDesign.right,
                            color: Utils.barcolor(context),
                          ),
                          backgroundColor:
                              Theme.of(context).textTheme.bodyText1.color,
                        )
                      : CupertinoButton(
                          child: Text('Salvar'),
                          onPressed: () {},
                        ))
            ],
          ),
        ),
      ),
    );
  }
}

class ExampleViewModel {
  final List<Color> pageColors;
  final CircularSliderAppearance appearance;
  final double min;
  final double max;
  final double value;
  final InnerWidget innerWidget;

  ExampleViewModel(
      {@required this.pageColors,
      @required this.appearance,
      this.min = 0,
      this.max = 100,
      this.value = 50,
      this.innerWidget});
}
