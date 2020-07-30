import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class BaseData {
  final firestoreInstance = Firestore.instance;

  StreamBuilder<QuerySnapshot> defaultBuilder(Stream stream,
      {@required Widget emptyResult});

  CollectionReference collectionReference();

  Stream query({@required String field, @required String value}) =>
      collectionReference().where(field, isEqualTo: value).snapshots();

  Stream singleDocument(String key) =>
      collectionReference().document(key).snapshots();

  Stream defaultStream() {
    return collectionReference().snapshots();
  }
}
