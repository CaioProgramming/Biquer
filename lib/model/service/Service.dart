import 'package:Biquer/model/category/Category.dart';

import 'file:///C:/Users/cacai/StudioProjects/Biquer/lib/model/category/CategoryData.dart';

class Service {
  String name, description, userID, id;
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
      this.category,
      this.id,
      this.stylePosition});

  factory Service.fromMap(Map<String, dynamic> map, String key) {
    return new Service(
      name: map['name'] as String,
      description: map['description'] as String,
      userID: map['user'] as String,
      value: map['value'] as double,
      categoryKey: map['categoryKey'] as String,
      stylePosition: map['stylePosition'] as int,
      id: key,
    );
  }

  static Future<Service> withStyle(Map<String, dynamic> map, String key) async {
    print('converting \n\n$map \n\n to Service');
    return new Service(
        name: map['name'] as String,
        id: key,
        description: map['description'] as String,
        userID: map['user'] as String,
        value: map['value'] as double,
        categoryKey: map['categoryKey'] as String,
        stylePosition: map['stylePosition'] as int,
        category: await CategoryData().getCategory(map['categoryKey']));
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

  bool hasCategory() => category != null && categoryKey != null;

  CategoryStyle style() => category.styles[stylePosition];
}
