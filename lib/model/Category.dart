import 'package:flutter/cupertino.dart';

class Category {
  List<CategoryStyle> styles;
  String title;
  String subtitle;
  String posterImage;
  String titleColor;
  String id;

  Category(
      {this.styles,
      this.title,
      this.subtitle,
      this.posterImage,
      this.titleColor,
      this.id});

  factory Category.fromMap(Map<String, dynamic> map, String key) {
    print('Converting \n $map \nto category');
    return new Category(
      styles: dynamicToStyles(map['styles']),
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      posterImage: map['posterImage'] as String,
      titleColor: map['titleColor'] as String,
      id: map['id'] as String,
    );
  }

  static List<CategoryStyle> dynamicToStyles(List<dynamic> list) {
    List<CategoryStyle> styles = [];
    for (final style in list) {
      styles.add(CategoryStyle.fromMap(style));
    }
    return styles;
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'styles': this.styles,
      'title': this.title,
      'subtitle': this.subtitle,
      'posterImage': this.posterImage,
      'titleColor': this.titleColor,
      'id': this.id,
    } as Map<String, dynamic>;
  }
}

class CategoryStyle {
  String backgroundImage;
  String textColor;

  CategoryStyle({this.backgroundImage, this.textColor});

  factory CategoryStyle.fromMap(Map<String, dynamic> map) {
    print('Converting $map \n to category style');
    return new CategoryStyle(
      backgroundImage: map['backgroundImage'] as String,
      textColor: map['textColor'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'backgroundImage': this.backgroundImage,
      'textColor': this.textColor,
    } as Map<String, dynamic>;
  }

  Widget imageContainer() {
    return Container(
      height: double.maxFinite,
      child: FadeInImage(
          fit: BoxFit.cover,
          placeholder: AssetImage(''),
          image: NetworkImage(backgroundImage)),
    );
  }
}
