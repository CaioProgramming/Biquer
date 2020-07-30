import 'package:Biquer/model/category/Category.dart';
import 'package:Biquer/model/category/CategoryData.dart';
import 'package:Biquer/model/service/BicoData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../PageTitle.dart';

class CategorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageTitle(
            'Categoria', 'Selecione uma categoria em relação ao seu serviço'),
        Expanded(child: categories(context)),
      ],
    );
  }

  StreamBuilder categories(BuildContext context) {
    BicoData bicoData = Provider.of(context);
    CategoryData categoryData = CategoryData();
    return categoryData.defaultBuilder(categoryData.defaultStream(),
        selectedCategory: bicoData.category,
        cardSelect: (Category category) => bicoData.updateCategory(category));
  }
}
