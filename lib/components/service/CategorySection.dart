import 'package:flutter/material.dart';

import 'file:///C:/Users/cacai/StudioProjects/Biquer/lib/model/category/CategoryData.dart';

import '../PageTitle.dart';

class CategorySection extends StatelessWidget {
  void getCategories() async {}

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageTitle(
            'Categoria', 'Selecione uma categoria em relação ao seu serviço'),
        Expanded(child: CategoryData().getCategories()),
      ],
    );
  }
}
