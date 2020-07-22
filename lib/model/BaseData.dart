import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseData {
  Stream stream;

  String reference();

  final firestoreInstance = Firestore.instance;

  BaseData() {
    this.stream = firestoreInstance.collection(reference()).snapshots();
  }
}
