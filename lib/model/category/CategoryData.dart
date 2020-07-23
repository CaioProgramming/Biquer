import 'package:Biquer/model/BaseData.dart';
import 'package:Biquer/model/category/Category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'file:///C:/Users/cacai/StudioProjects/Biquer/lib/components/service/CategoryCard.dart';

class CategoryData extends BaseData {
  @override
  String reference() => "Categories";

  StreamBuilder getCategories() {
    List<CategoryCard> categoryCards = [];
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          categoryCards.clear();
          final categoriesDocs = snapshot.data.documents;
          for (final category in categoriesDocs) {
            categoryCards.add(CategoryCard(
                category:
                    Category.fromMap(category.data, category.documentID)));
          }
          return GridView.count(
            padding: EdgeInsets.all(0),
            crossAxisCount: 2,
            shrinkWrap: true,
            children: categoryCards,
          );
        } else {
          return Center(
              child: Center(
            child: Column(
              children: [
                Image.network('https://blush.ly/eKcCsFlK_/p'),
                Text('Nenhuma categoria encontrada'),
              ],
            ),
          ));
        }
      },
    );
  }

  Future<Category> getCategory(String id) async {
    DocumentSnapshot categorySnapshot = await singleDocument(id);
    return Category.fromMap(categorySnapshot.data, categorySnapshot.documentID);
  }
}
