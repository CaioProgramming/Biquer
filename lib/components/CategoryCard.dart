import 'package:Biquer/model/Category.dart';
import 'package:Biquer/model/ServiceData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

import '../constants.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final bool selected;

  CategoryCard({@required this.category, this.selected = false});

  @override
  Widget build(BuildContext context) {
    ServiceData serviceData = Provider.of(context);
    return CupertinoButton(
      onPressed: () => serviceData.updateCategory(this.category),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(category.posterImage)),
            borderRadius: kDefaultBorder,
            border: Border.all(
                color: selected
                    ? Theme.of(context).textTheme.button.color
                    : Colors.transparent,
                width: 3)),
        child: Stack(
          children: [
            Center(
                child: Text(
              category.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: category.titleColor != null
                      ? TinyColor.fromString(category.titleColor).color
                      : Colors.white),
            )),
            Positioned(
              left: 4,
              top: 4,
              child: Visibility(
                visible: selected,
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).textTheme.button.color,
                      borderRadius: kDefaultBorder),
                  child: Center(
                    child: Icon(
                      AntDesign.check,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
