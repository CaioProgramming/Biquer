class Category {
  String title;
  String subtitle;
  String posterImage;
  String titleColor;
  String id;

  Category(
      {this.title, this.subtitle, this.posterImage, this.titleColor, this.id});

  factory Category.fromMap(Map<String, dynamic> map, String key) {
    print('Converting \n $map \nto category');
    return new Category(
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      posterImage: map['posterImage'] as String,
      titleColor: map['titleColor'] as String,
      id: key,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'subtitle': this.subtitle,
      'posterImage': this.posterImage,
      'titleColor': this.titleColor,
      'id': this.id,
    };
  }
}
