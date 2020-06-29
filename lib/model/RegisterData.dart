import 'package:Biquer/model/Address.dart';
import 'package:Biquer/model/Document.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class RegisterData extends ChangeNotifier {
  FirebaseUser _user;
  Address _userAddress;

  Address get userAddress => _userAddress;

  set userAddress(Address value) {
    _userAddress = value;
    print('Address updated');
    notifyListeners();
  }

  Document _userDocument;

  Document get userDocument => _userDocument;

  set userDocument(Document value) {
    _userDocument = value;
    notifyListeners();
  }

  FirebaseUser get user => _user;

  bool userLogged() {
    print('user logged?  ${user != null}');
    return user != null;
  }

  set user(FirebaseUser value) {
    _user = value;
    print('user updated $user');
    notifyListeners();
  }

  String _userPicURL;

  String get userPicURL => _userPicURL;

  set userPicURL(String value) {
    _userPicURL = value;
    notifyListeners();
  }
}
