import 'package:Biquer/model/category/Category.dart';
import 'package:Biquer/model/service/BicoData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

import '../../constants.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  CategoryCard({@required this.category});

  @override
  Widget build(BuildContext context) {
    BicoData serviceData = Provider.of(context);
    Category selectedCategory = serviceData.category;
    bool selected() =>
        selectedCategory != null && selectedCategory.id == category.id;

    return CupertinoButton(
      onPressed: () => serviceData.updateCategory(this.category),
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
                  fit: BoxFit.cover, image: NetworkImage(category.posterImage)),
              borderRadius: kDefaultBorder),
          child: Center(
              child: Text(
            category.title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 26,
                color: category.titleColor != null
                    ? TinyColor.fromString(category.titleColor).color
                    : Colors.white),
          )),
        ),
      ),
    );
  }
}
