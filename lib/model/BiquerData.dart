import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BiquerData extends ChangeNotifier {
  Firestore _firestore = Firestore.instance;
  FirebaseUser user;

  BiquerData(this.user);

  void setUser(FirebaseUser user) {
    this.user = user;
    notifyListeners();
  }
}
