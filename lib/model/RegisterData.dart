import 'package:Biquer/model/Address.dart';
import 'package:Biquer/model/Document.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class RegisterData extends ChangeNotifier {
  FirebaseUser _user;
  Address _userAddress;
  String _addressCEP, _addressURL = "";
  String addressNumber = "";
  String docID;
  String docurl;

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
    print('document updated on provider');
    notifyListeners();
  }

  void updateAddressURL(String url) {
    _addressURL = url;
    print('updated address url');
    checkAddress();
    notifyListeners();
  }

  void checkAddress() {
    if (_addressCEP.isNotEmpty &&
        _addressURL.isNotEmpty &&
        addressNumber.isNotEmpty) {
      userAddress = Address(
          cep: _addressCEP,
          number: int.parse(addressNumber),
          urlComprovAdress: _addressURL);
      print('updated address');
    }
  }

  void checkDocument() {
    if (docID != null && docurl != null) {
      userDocument = Document(id: docID.toString(), docURL: docurl);
      print('updated document');
    }
  }

  void updateAddressNumber(String number) {
    addressNumber = number;
    checkAddress();
    notifyListeners();
    print('updated number $number on provider');
  }

  void updateDocID(String id) {
    docID = id;
    checkDocument();
    notifyListeners();
    print('updated docID $id on provider');
  }

  void updateDocURL(String url) {
    docurl = url;
    checkDocument();
    notifyListeners();
    print('updated docURL $url on provider');
  }

  void updateAddressCEP(String cep) {
    _addressCEP = cep;
    checkAddress();
    notifyListeners();
    print('cep $cep updated on provider');
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
