import 'package:Biquer/constants.dart';
import 'package:Biquer/model/service/Service.dart';
import 'package:Biquer/model/service/ServiceData.dart';
import 'package:Biquer/utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

class ServiceCard extends StatelessWidget {
  final bool infinite;
  final Service service;

  ServiceCard({this.infinite = false, this.service});

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
              image: NetworkImage(service.style().backgroundImage))),
      width: double.maxFinite,
      height: !infinite ? double.maxFinite / 2 : double.maxFinite,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ServiceCardAutoText(
                    servicename: service.name,
                    textColor:
                        TinyColor.fromString(service.style().textColor).color,
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
                    child: Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: Utils.barcolor(context),
                          borderRadius: kDefaultBorder),
                      child: Text(Utils.moneyText(service.value)),
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
                    child: Text(Utils.moneyText(serviceData.service.value)),
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

class ServiceCardAutoText extends StatelessWidget {
  final String servicename;
  final Color textColor;

  ServiceCardAutoText({this.servicename = '', this.textColor});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      servicename,
      minFontSize: 20,
      maxFontSize: 50,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: textColor, fontWeight: FontWeight.w900),
    );
  }
}
