import 'package:Biquer/model/CEP.dart';
import 'package:Biquer/model/Document.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class RegisterData extends ChangeNotifier {
  FirebaseUser _user;
  CEP _userCEP;
  Document _document;

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

  CEP get userCEP => _userCEP;

  set userCEP(CEP value) {
    _userCEP = value;
    notifyListeners();
  }

  Document get document => _document;

  set document(Document value) {
    _document = value;
    notifyListeners();
  }

  String get userPicURL => _userPicURL;

  set userPicURL(String value) {
    _userPicURL = value;
    notifyListeners();
  }
}
