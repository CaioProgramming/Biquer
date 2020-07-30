import 'package:Biquer/CurrencyInputFormatter.dart';
import 'package:Biquer/components/PageTitle.dart';
import 'package:Biquer/model/service/BicoData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../utils.dart';

class ServiceForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var serviceData = Provider.of<BicoData>(context);

    TextEditingController textController = TextEditingController(
        text: Utils.moneyText(serviceData.bico.price ?? 0));
    var maskFormatter = new CurrencyInputFormatter(maxDigits: 5);

    return Column(
      children: [
        PageTitle("Preço",
            "Para concluir basta definir o valor do seu serviço(lembre-se de não exagerar)"),
        FadeInImage(
            height: 250,
            width: 250,
            placeholder: AssetImage(''),
            image: NetworkImage('https://i.ibb.co/1TkjDxq/taxi-33.png')),
        TextField(
          textAlign: TextAlign.center,
          controller: textController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            WhitelistingTextInputFormatter.digitsOnly,
            maskFormatter
          ],
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          onChanged: (newValue) =>
              serviceData.updateBicoPrice(maskFormatter.getUnmaskedText()),
          decoration: InputDecoration(
              hintText: Utils.moneyText(0),
              border: OutlineInputBorder(borderSide: BorderSide.none)),
        ),
        PriceSlider(
            maxValue: serviceData.service.averagePrice * 2,
            minValue: serviceData.service.minPrice,
            currentValue: serviceData.bico.price,
            label: Utils.moneyText(serviceData.bico.price),
            onChange: (newValue) => serviceData.updateBicoPrice(newValue))
      ],
    );
  }
}

class PriceSlider extends StatelessWidget {
  final double maxValue, minValue, currentValue;
  final String label;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    try {
      return SliderTheme(
          data: SliderTheme.of(context).copyWith(
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 30),
              thumbColor: Colors.black,
              overlayColor: Colors.black.withAlpha(50),
              trackHeight: 1,
              showValueIndicator: ShowValueIndicator.always,
              rangeValueIndicatorShape: PaddleRangeSliderValueIndicatorShape(),
              valueIndicatorShape: PaddleSliderValueIndicatorShape(),
              valueIndicatorColor: Colors.white,
              valueIndicatorTextStyle: Theme.of(context).textTheme.bodyText1,
              activeTrackColor: Theme.of(context).textTheme.button.color,
              inactiveTrackColor: Theme.of(context).textTheme.button.color),
          child: Slider(
            label: label,
            value: currentValue,
            min: minValue,
            max: 10000,
            onChanged: (newValue) => onChange(newValue),
          ));
    } catch (e) {
      print(e);
      return CupertinoActivityIndicator();
    }
  }

  const PriceSlider({
    @required this.maxValue,
    @required this.minValue,
    @required this.currentValue,
    @required this.label,
    @required this.onChange,
  });
}
