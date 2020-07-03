import 'dart:io';

import 'package:Biquer/model/AddressData.dart';
import 'package:Biquer/model/DocumentData.dart';
import 'package:Biquer/model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserData {
  Firestore _firestore = Firestore.instance;

  Future<bool> saveUserInfo(User user, String name) async {
    AddressData addressData = AddressData();
    DocumentData documentData = DocumentData();
    String address = await addressData.uploadDoc(user.address, user.uid);
    String document = await documentData.uploadDoc(user.document, user.uid);
    String profilepicture = await uploadPic(user.picURL, user.uid, name);
    user.address.urlComprovAddress = address;
    user.document.docURL = document;
    user.picURL = profilepicture;
    print('$address\n$document\n$profilepicture');
    if (address == null || document == null) {
      Future.error('Erro ao fazer upload de imagens');
      return false;
    }
    bool success = false;
    await _firestore
        .collection('Users')
        .document(user.uid)
        .setData(user.map())
        .catchError((onError) {
      success = false;
      print(onError);
    }).whenComplete(() => success = true);
    return success;
  }

  Future<String> uploadPic(String url, String uid, String name) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('$uid/documents/$name');
    File image = File(url);
    if (!image.existsSync()) {
      return Future.error('Erro ao encontrar foto\n$url');
    }
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    print('File Uploaded');
    return await storageReference.getDownloadURL();
  }
}
