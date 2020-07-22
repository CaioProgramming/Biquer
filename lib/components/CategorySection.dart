import 'package:Biquer/model/CategoryData.dart';
import 'package:flutter/material.dart';

import 'PageTitle.dart';

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
