import 'package:Biquer/model/category/CategoryData.dart';
import 'package:flutter/material.dart';

import '../PageTitle.dart';

class CategorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageTitle(
            'Categoria', 'Selecione uma categoria em relação ao seu serviço'),
        Expanded(child: categories()),
      ],
    );
  }

  StreamBuilder categories() {
    CategoryData categoryData = CategoryData();
    return categoryData.defaultBuilder(categoryData.defaultStream());
  }
}
