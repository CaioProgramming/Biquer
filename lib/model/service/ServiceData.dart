import 'dart:developer';

import 'package:Biquer/components/SavingScreen.dart';
import 'package:Biquer/constants.dart';
import 'package:Biquer/model/category/Category.dart';
import 'package:Biquer/model/service/Service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

enum SavingState { SAVING, SAVED, ERROR }

class ServiceData extends ChangeNotifier {
  Service service;
  SavingState state = SavingState.SAVING;

  ServiceData(FirebaseUser user) {
    this.service = Service(userID: user.uid);
  }

  Category category() => service.category;

  saveService() async {
    var fireStoreInstance = Firestore.instance;
    await fireStoreInstance
        .collection("Services")
        .add(service.toMap())
        .catchError((onError) {
      print(onError);
      state = SavingState.ERROR;
    }).whenComplete(() {
      state = SavingState.SAVED;
    });
    notifyListeners();
  }

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
    service.category = category;
    service.categoryKey = category.id;
    updateStyle(0);
    notifyListeners();
  }

  updateStyle(int position) {
    service.stylePosition = position;
    notifyListeners();
  }

  Widget savingScreen() {
    switch (state) {
      case SavingState.SAVING:
        return SavingScreen(
            message: 'Salvando seu bico', image: kSavingServiceIllustration);
        break;
      case SavingState.SAVED:
        return SavingScreen(
            message: 'Serviço salvo com sucesso!',
            image: kSavedServiceIllustration);
        break;
      case SavingState.ERROR:
        saveService();
        return SavingScreen(
            message:
                'Ocorreu um erro ao salvar seu bico, Estamos verificando o que aconteceu',
            image: kErrorServiceIllustration);
        break;
    }
    return SizedBox();
  }

  CategoryStyle selectedStyle() => category().styles[service.stylePosition];
}
