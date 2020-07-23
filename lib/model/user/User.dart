import 'package:Biquer/model/address/Address.dart';
import 'package:Biquer/model/document/Document.dart';

enum UserType {
  individual,
  company,
}

class User {
  String uid, safetyPic;
  Address address;
  Document document;
  UserType type;

  User(
      {this.uid,
      this.safetyPic,
      this.address,
      this.document,
      this.type = UserType.individual});

  Map<String, dynamic> map() {
    return {
      'uid': this.uid,
      'safetyPic': this.safetyPic,
      'type': this.type,
      'address': address.map(),
      'document': document.map()
    };
  }
}
