import 'package:Biquer/model/category/Category.dart';
import 'package:Biquer/model/service/Service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

import '../../constants.dart';

class ServiceCard extends StatelessWidget {
  final Service service;
  final Category selectedCategory;
  final Function onPress;

  ServiceCard({@required this.service, this.selectedCategory, this.onPress});

  @override
  Widget build(BuildContext context) {
    bool selected() =>
        selectedCategory != null && selectedCategory.id == service.id;

    return CupertinoButton(
      onPressed: onPress,
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
          child: Center(
              child: Text(
            service.title ?? 'Erro ao recuperar informações do serviço',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 26,
                color: service.titleColor != null
                    ? TinyColor.fromString(service.titleColor).color
                    : Theme.of(context).textTheme.title.color),
          )),
        ),
      ),
    );
  }
}
