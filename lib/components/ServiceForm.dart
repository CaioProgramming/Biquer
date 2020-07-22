import 'package:Biquer/components/PageTitle.dart';
import 'package:Biquer/model/ServiceData.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../constants.dart';

class ServiceForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var serviceData = Provider.of<ServiceData>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageTitle('Novo bico',
                'Adicione um novo bico para atrair mais clientes e render mais.'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                onChanged: (value) {
                  serviceData.updateServiceName(value);
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
                  serviceData.updateServiceDescription(value);
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

    final customWidth02 =
        CustomSliderWidths(trackWidth: 1, progressBarWidth: 5, handlerSize: 20);
    final customColors02 = CustomSliderColors(
        trackColor: Theme.of(context).hintColor.withOpacity(0.05),
        dotColor: Colors.black,
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
          Currency currency = Currency.create('BRL', 2, symbol: 'R\$ ');
          Money money = Money.from(value, currency);
          return money.toString();
        });
    final CircularSliderAppearance appearance02 = CircularSliderAppearance(
        customWidths: customWidth02,
        customColors: customColors02,
        infoProperties: info02,
        startAngle: 180,
        angleRange: 360,
        size: 300.0,
        animationEnabled: true);

    final slider = SleekCircularSlider(
      onChangeStart: (double value) {},
      onChangeEnd: (double value) {
        _serviceData.updateServicePrice(value);
      },
      appearance: appearance02,
      min: 0,
      max: 6000,
      initialValue: 0,
    );
    return slider;
  }
}
