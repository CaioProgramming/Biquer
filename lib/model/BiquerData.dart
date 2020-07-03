import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BiquerData extends ChangeNotifier {
  FirebaseUser user;

  BiquerData(this.user);

  void setUser(FirebaseUser user) {
    this.user = user;
    notifyListeners();
  }
}
