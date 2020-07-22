class Category {
  List<CategoryStyle> styles;
  CategoryStyle selectedStyle;
  String title;
  String subtitle;
  String posterImage;
  String titleColor;
  String id;

  Category(
      {this.styles,
      this.selectedStyle,
      this.title,
      this.subtitle,
      this.posterImage,
      this.titleColor,
      this.id});
}

class CategoryStyle {
  String backgroundImage;
  String textColor;

  CategoryStyle({this.backgroundImage, this.textColor});
}
