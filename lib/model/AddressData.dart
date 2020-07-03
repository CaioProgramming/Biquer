import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'Address.dart';

class AddressData {
  Future<String> uploadDoc(Address address, String uid) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('$uid/documents/address${address.cep}');
    File image = File(address.urlComprovAddress);
    if (!image.existsSync()) {
      return Future.error('Erro ao encontrar foto');
    }
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    print('File Uploaded');
    return await storageReference.getDownloadURL();
  }
}
