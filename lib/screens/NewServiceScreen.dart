import 'dart:ui';

import 'package:Biquer/components/CategorySection.dart';
import 'package:Biquer/components/PageTitle.dart';
import 'package:Biquer/components/ServicePreview.dart';
import 'package:Biquer/constants.dart';
import 'package:Biquer/model/ServiceData.dart';
import 'package:Biquer/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class ServiceForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageTitle('Bico',
                'Adicione um novo bico para atrair mais clientes e render mais '),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                onChanged: (value) {
                  var servicedata = Provider.of<ServiceData>(context);
                  servicedata.updateServiceName(value);
                },
                decoration: InputDecoration(
                    hintText: 'Nome do serviço',
                    border: OutlineInputBorder(borderRadius: kDefaultBorder)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                maxLines: 4,
                onChanged: (value) {
                  var servicedata = Provider.of<ServiceData>(context);
                  servicedata.updateServiceDescription(value);
                },
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                    hintText: 'Descrição do serviço',
                    border: OutlineInputBorder(borderRadius: kDefaultBorder)),
              ),
            ),
            Center(child: slider(context))
          ],
        ),
      ),
    );
  }

  SleekCircularSlider slider(BuildContext context) {
    ServiceData _serviceData = Provider.of(context);

    final customWidth02 = CustomSliderWidths(
        trackWidth: 4, progressBarWidth: 10, handlerSize: 10);
    final customColors02 = CustomSliderColors(
        trackColor: Theme.of(context).hintColor.withOpacity(0.05),
        dotColor: Theme.of(context).textTheme.button.color,
        progressBarColor: Colors.green,
        hideShadow: true);
    final info02 = InfoProperties(
        topLabelStyle: TextStyle(
            color: Colors.orangeAccent,
            fontSize: 20,
            fontWeight: FontWeight.w100),
        topLabelText: 'Valor',
        mainLabelStyle: TextStyle(fontSize: 50.0, fontWeight: FontWeight.w400),
        modifier: (double value) {
          final budget = (value * 1000).toInt();
          return '\$ $budget';
        });
    final CircularSliderAppearance appearance02 = CircularSliderAppearance(
        customWidths: customWidth02,
        customColors: customColors02,
        infoProperties: info02,
        startAngle: 180,
        angleRange: 360,
        size: 300.0,
        animationEnabled: true);
    final viewModel02 = ExampleViewModel(
        appearance: appearance02,
        min: 0.05,
        max: 5.041,
        value: 0.05,
        pageColors: [Colors.black, Colors.black87]);
    final slider = SleekCircularSlider(
      onChangeStart: (double value) {},
      onChangeEnd: (double value) {
        _serviceData.updateServicePrice(value);
      },
      innerWidget: viewModel02.innerWidget,
      appearance: viewModel02.appearance,
      min: viewModel02.min,
      max: viewModel02.max,
      initialValue: viewModel02.value,
    );
    return slider;
  }
}
