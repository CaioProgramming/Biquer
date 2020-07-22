import 'package:Biquer/model/Category.dart';
import 'package:Biquer/model/ServiceData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CategoryCard.dart';
import 'PageTitle.dart';

class CategorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var category = Category(
        styles: [
          CategoryStyle(
              backgroundImage:
                  'https://images.pexels.com/photos/1309766/pexels-photo-1309766.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
              textColor: '#fff'),
          CategoryStyle(
              backgroundImage:
                  'https://images.pexels.com/photos/2733675/pexels-photo-2733675.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
              textColor: '#fff'),
          CategoryStyle(
              backgroundImage:
                  'https://images.unsplash.com/photo-1492107376256-4026437926cd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
              textColor: '#000'),
          CategoryStyle(
              backgroundImage:
                  'https://images.unsplash.com/photo-1527800792452-506aacb2101f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2134&q=80',
              textColor: '#fff'),
        ],
        title: 'Tecnologia',
        id: '0',
        titleColor: "#fff",
        posterImage:
            'https://images.pexels.com/photos/38568/apple-imac-ipad-workplace-38568.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260');

    ServiceData serviceData = Provider.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageTitle(
            'Categoria', 'Selecione uma categoria em relação ao seu serviço'),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          shrinkWrap: true,
          children: [
            CategoryCard(
                selected: serviceData.category() != null &&
                    serviceData.category().id == category.id,
                category: category),
            CategoryCard(
                selected: serviceData.category() != null &&
                    serviceData.category().id == category.id,
                category: category),
          ],
        ),
      ],
    );
  }
}
