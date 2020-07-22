import 'dart:developer';

import 'package:Biquer/model/Category.dart';
import 'package:Biquer/model/Service.dart';
import 'package:flutter/cupertino.dart';

class ServiceData extends ChangeNotifier {
  var service = Service();

  ServiceData() {
    service = Service();
  }

  Category category() => service.category;

  CategoryStyle style() => service.category.selectedStyle;

  updateServiceName(String newName) {
    service.name = newName;
    notifyListeners();
  }

  updateServiceDescription(String newName) {
    service.description = newName;
    notifyListeners();
  }

  updateServicePrice(double newValue) {
    service.value = newValue;
    notifyListeners();
  }

  updateCategory(Category category) {
    if (service.category == null) service.category = Category();
    service.category = category;
    service.category.selectedStyle = category.styles[0];
    notifyListeners();
  }

  updateStyle(CategoryStyle style) {
    if (service.category.selectedStyle == null) {
      service.category.selectedStyle = CategoryStyle();
    }
    service.category.selectedStyle = style;
    notifyListeners();
  }

  updateCategoryStyle(CategoryStyle style) {
    service.category.selectedStyle = style;
    notifyListeners();
  }
}
