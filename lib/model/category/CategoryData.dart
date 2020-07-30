import 'package:Biquer/components/service/CategoryCard.dart';
import 'package:Biquer/model/BaseData.dart';
import 'package:Biquer/model/category/Category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../constants.dart';

class CategoryData extends BaseData {
  @override
  StreamBuilder<QuerySnapshot> defaultBuilder(Stream stream,
      {Widget emptyResult}) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final categoriesDocs = snapshot.data.documents;
          return GridView.builder(
            itemCount: categoriesDocs.length,
            itemBuilder: (context, index) {
              Category category = Category.fromMap(
                  categoriesDocs[index].data, categoriesDocs[index].documentID);
              return CategoryCard(category: category);
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 16 / 9,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1),
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
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

  @override
  Stream<DocumentSnapshot> singleDocument(String key) => firestoreInstance
      .collection(kCategoryReference)
      .document(key)
      .snapshots();

  @override
  CollectionReference collectionReference() =>
      firestoreInstance.collection(kCategoryReference);
}
