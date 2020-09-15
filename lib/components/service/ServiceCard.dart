import 'dart:ui';

import 'package:Biquer/model/service/Service.dart';
import 'package:Biquer/utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

import '../../constants.dart';

class ServiceCard extends StatelessWidget {
  final Service service;
  final double price;
  final Service selectedService;
  final Function onServiceSelect;

  ServiceCard(
      {@required this.service,
      this.price,
      this.selectedService,
      this.onServiceSelect});

  @override
  Widget build(BuildContext context) {
    bool selected() =>
        selectedService != null && selectedService.id == service.id;

    return CupertinoButton(
      padding: EdgeInsets.all(0),
      onPressed: onServiceSelect == null
          ? null
          : () {
              onServiceSelect(service);
            },
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(selected() ? 4 : 0),
        decoration: BoxDecoration(
            borderRadius: kDefaultBorder,
            border: Border.all(
                color: selected()
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                width: 2)),
        child: Container(
          height: double.maxFinite,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.20),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(service.posterImage ??
                      'https://i.ibb.co/GF0jJzm/pixeltrue-error.png')),
              borderRadius: kDefaultBorder),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: AutoSizeText(
                  service.title ?? 'Erro ao recuperar informações do serviço',
                  maxLines: 2,
                  maxFontSize: 36,
                  minFontSize: 10,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 26,
                      color: service.titleColor != null
                          ? TinyColor.fromString(service.titleColor).color
                          : Theme.of(context).textTheme.headline6.color),
                ),
              ),
              SizedBox(),
              price == null
                  ? SizedBox()
                  : Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Seu valor',
                                style: Theme.of(context).textTheme.caption),
                            Text(
                              Utils.moneyText(price),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
