import 'dart:io';

import 'package:Biquer/model/Document.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DocumentData {
  Future<String> uploadDoc(Document document, String uid) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('$uid/documents/docproof${document.id}');
    File image = File(document.docURL);
    if (!image.existsSync()) {
      return Future.error('Erro ao encontrar foto');
    }
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    print('File Uploaded');
    return await storageReference.getDownloadURL();
  }
}
