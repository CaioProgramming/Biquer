import 'package:Biquer/model/Category.dart';

class Service {
  String name, description, userID;
  double value;
  String categoryKey;
  int stylePosition;
  Category category;

  Service(
      {this.name,
      this.description,
      this.userID,
      this.value,
      this.categoryKey,
      this.stylePosition});

  factory Service.fromMap(Map<String, dynamic> map) {
    return new Service(
      name: map['name'] as String,
      description: map['description'] as String,
      userID: map['userID'] as String,
      value: map['value'] as double,
      categoryKey: map['categoryKey'] as String,
      stylePosition: map['stylePosition'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'name': this.name,
      'description': this.description,
      'user': this.userID,
      'value': this.value,
      'categoryKey': this.categoryKey,
      'stylePosition': this.stylePosition,
    } as Map<String, dynamic>;
  }

  bool hasData() =>
      name != null && description != null && value != null && value > 0;

  bool hasCategory() => category != null;
}
