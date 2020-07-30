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
        padding: EdgeInsets.all(selected() ? 4 : 0),
        decoration: BoxDecoration(
            borderRadius: kDefaultBorder,
            border: Border.all(
                color: selected()
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                width: 2)),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(service.posterImage ??
                      'https://i.ibb.co/GF0jJzm/pixeltrue-error.png')),
              borderRadius: kDefaultBorder),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: AutoSizeText(
                      service.title ??
                          'Erro ao recuperar informações do serviço',
                      maxLines: 2,
                      maxFontSize: 26,
                      minFontSize: 16,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 26,
                          color: service.titleColor != null
                              ? TinyColor
                              .fromString(service.titleColor)
                              .color
                              : Theme
                              .of(context)
                              .textTheme
                              .headline6
                              .color),
                    )),
              ),
              price == null
                  ? SizedBox()
                  : Positioned(
                bottom: 4,
                left: 4,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .textTheme
                          .headline6
                          .color,
                      borderRadius: kDefaultBorder),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Seu valor',
                        style: Theme
                            .of(context)
                            .textTheme
                            .caption
                            .copyWith(
                            color: Theme
                                .of(context)
                                .scaffoldBackgroundColor),
                      ),
                      Text(
                        Utils.moneyText(price),
                        style: TextStyle(
                            color:
                            Theme
                                .of(context)
                                .scaffoldBackgroundColor,
                            fontWeight: FontWeight.w300),
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
