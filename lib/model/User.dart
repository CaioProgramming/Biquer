import 'package:Biquer/model/Address.dart';
import 'package:Biquer/model/Document.dart';

class User {
  String uid, picURL;
  Address address;
  Document document;

  User(this.uid, this.picURL, this.address, this.document);

  Map<String, dynamic> map() {
    return {
      'uid': this.uid,
      'picURL': this.picURL,
      'address': address.map(),
      'document': document.map()
    };
  }
}
