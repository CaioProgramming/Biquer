import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseData {
  Stream stream;

  String reference();

  final firestoreInstance = Firestore.instance;

  BaseData() {
    this.stream = firestoreInstance.collection(reference()).snapshots();
  }

  Future<QuerySnapshot> query({String field, String value, int limit = 100}) {
    return firestoreInstance
        .collection(reference())
        .where(field, isEqualTo: value)
        .limit(limit)
        .getDocuments();
  }

  Future<DocumentSnapshot> singleDocument(String key) async {
    return firestoreInstance
        .collection(reference())
        .document(key)
        .snapshots()
        .first;
  }
}
