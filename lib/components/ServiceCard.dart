import 'package:Biquer/constants.dart';
import 'package:Biquer/model/Service.dart';
import 'package:Biquer/model/ServiceData.dart';
import 'package:Biquer/utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

class ServiceCard extends StatelessWidget {
  final bool infinite;

  ServiceCard({this.infinite = false});

  static Widget defaultCard(Service service) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blueGrey.shade300, Colors.grey.shade700],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
          borderRadius: BorderRadius.circular(15)),
      width: double.maxFinite,
      height: 540,
      child: Stack(
        children: [
          Center(
            child:
                Text('Você precisa voltar e informar os dados do seu serviço'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  'https://images.pexels.com/photos/3756879/pexels-photo-3756879.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'))),
      width: double.maxFinite,
      height: !infinite ? 200 : double.maxFinite,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topLeft,
                      colors: [
                        Colors.black.withOpacity(0.40),
                        Colors.transparent
                      ])),
              child: Wrap(
                children: [
                  AutoSizeText(
                    'Desenvolvimento de aplicativos iOS e android',
                    minFontSize: 20,
                    maxFontSize: 50,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w900),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color:
                            TinyColor(Theme.of(context).scaffoldBackgroundColor)
                                .darken(50)
                                .color,
                        borderRadius: kDefaultBorder),
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: 'R\$',
                        style: Theme.of(context).textTheme.caption,
                        children: <TextSpan>[
                          TextSpan(
                              text: '200,00',
                              style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 20,
                                  color:
                                      Theme.of(context).textTheme.button.color))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ServiceCardPreview extends StatelessWidget {
  final bool infinite;

  ServiceCardPreview({this.infinite = false});

  @override
  Widget build(BuildContext context) {
    ServiceData serviceData = Provider.of(context, listen: true);

    List<Container> containers() {
      List<Container> containers = [];
      for (var style in serviceData.category().styles) {
        containers.add(style.imageContainer());
      }
      return containers;
    }

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      width: double.maxFinite,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: kDefaultBorder,
            child: LiquidSwipe(
              pages: containers(),
              enableLoop: true,
              onPageChangeCallback: (position) {
                print('page changed $position');
                serviceData.updateStyle(position);
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: kDefaultBorder,
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topLeft,
                      colors: [
                        Colors.black.withOpacity(0.40),
                        Colors.transparent
                      ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ServiceCardAutoText(
                    servicename: serviceData.service.name,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Utils.barcolor(context),
                        borderRadius: kDefaultBorder),
                    child: Text(money(serviceData.service.value)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  String money(double value) {
    Currency currency = Currency.create('BRL', 2, symbol: 'R\$');
    Money money = Money.from(value, currency);
    return money.toString();
  }
}

class ServiceCardAutoText extends StatelessWidget {
  final String servicename;

  ServiceCardAutoText({this.servicename = ''});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      servicename,
      minFontSize: 20,
      maxFontSize: 50,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
    );
  }
}
